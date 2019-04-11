# DesignPattern-Singleton
#引言

最近在用xib拖入Object的时候发现一个问题，xib各连线正常，但是死活不调用单例中的方法。经过一步步排查，检查出原来是单例模式出了问题。特此记录下。

#1、何为单例模式

单例模式：保证一个类仅有一个实例，并提供一个访问它的全局访问点。

#2、何时使用单例模式

 在以下情形，应该考虑使用单例模式：
 + 类只能有一个实例，而且必须从一个为人熟知的访问点对其进行访问，比如工厂方法
+ 这个唯一的实例只能通过子类化进行

#3、使用OC实现单例模式

.h

```
@interface TKSingleton : NSObject<NSCopying>

@property (nonatomic, readonly)  UIViewController *activityViewController;
@property (nonatomic, readonly) RootViewController *rootViewController;

+ (TKSingleton *) sharedInstance;
@end
```
.m

```
@interface TKSingleton()
- (void)initialize;
@end

@implementation TKSingleton

static TKSingleton *tkSingleton_ = nil;

+ (TKSingleton *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tkSingleton_ = [[self alloc] init];
        [tkSingleton_ initialize];
    });
    return tkSingleton_;
}

- (void)initialize {
    _rootViewController = [[RootViewController alloc] init];
    _activityViewController = _rootViewController;
}

@end
```
这是我们通常的写法，乍一看也没什么毛病(之前我也是这么写的导致后面没有调用单例中的方法)。如果真是这样的话，那么就没必要写这个文章记录了。但实际上，需要克服一些障碍才能让实现足够可靠，可以用在真正的应用程序中。如果需要实现单例模式中的“严格”版本，要想在实际中使用，需要面对一下两个主要的障碍：
+ 发起调用的对象不能以其他分配方式实例化单例对象。否则就有可能创建单例类的多个实例。
+ 对单例对象实例化的限制应该与引用计数内存模型共存

```
@interface TKSingleton()
- (void)initialize;
@end

@implementation TKSingleton

static TKSingleton *tkSingleton_ = nil;

+ (TKSingleton *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tkSingleton_ = [[super allocWithZone:NULL] init];
        [tkSingleton_ initialize];
    });
    return tkSingleton_;
}

- (void)initialize {
    _rootViewController = [[RootViewController alloc] init];
    _activityViewController = _rootViewController;
}


+ (id)allocWithZone:(struct _NSZone *)zone {
    return [TKSingleton sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return [TKSingleton sharedInstance];
}

@end

```

关于单例模式的初始化，官方推荐使用GCD。不仅可以解决多条线程的线程安全问题，也能保证性能。在`shareInstance`方法中，跟第一个例子一样，首先检查类的唯一实例是否已经创建，如果没有，就创建新的实例并将其返回。但是这回，他不是使用alloc这样的方法，而是调用`[[super allocWithZone:NULL] init]`来生成新的实例。为什么是`super`而不是`self`呢？这是因为在`self`中重载了基本的对象分配方法，所以需要“借用”其父类(即`NSObject`)的功能，来帮助处理底层内存分配的杂务。
在`allocWithZone:(struct _NSZone *)zone`方法中，只是返回从`sharedInstance `方法返回的类实例。在`Cocoa Touch`框架中，调用类的`allocWithZone:(struct _NSZone *)zone`方法，会分配实例的内存，引用计数会置为1，然后会返回实例。类似地，需要重载`copyWithZone:(NSZone *)zone`方法，以保证不会返回实例的副本，而是通过返回`[TKSingleton sharedInstance]`返回同一个实例。

#4、解决方案

回到之前提出的问题，解决的方案就是将`tkSingleton_ = [[self alloc] init];`替换成`tkSingleton_ = [[super allocWithZone:NULL] init];` 并增加`allocWithZone:(struct _NSZone *)zone`方法。

附上[Demo](https://github.com/tekizhong/DesignPattern-Singleton)的链接地址。
