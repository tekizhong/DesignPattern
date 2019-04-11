//
//  TKSingleton.m
//  TKSingleton
//
//  Created by Evergrande-teki on 2019/4/11.
//  Copyright © 2019年 Evergrande-teki. All rights reserved.
//

#import "TKSingleton.h"
#import "PushViewController.h"
#import "PresentViewController.h"

@interface TKSingleton()
- (void)initialize;

@end

@implementation TKSingleton

static TKSingleton *tkSingleton_ = nil;

+ (TKSingleton *)sharedInstance {
    @synchronized(self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tkSingleton_ = [[super allocWithZone:NULL] init];
            [tkSingleton_ initialize];
        });
    }
    return tkSingleton_;
}

- (void)initialize {
    _rootViewController = [[RootViewController alloc] init];
    _activityViewController = _rootViewController;
}


+ (id)allocWithZone:(struct _NSZone *)zone {
    return  [self sharedInstance];
}


- (id)copyWithZone:(NSZone *)zone {
    return self;
}



- (IBAction)buttonClick:(id)object
{
    if ([object isKindOfClass:[UIButton class]]) {
        switch ([(UIButton*)object tag]) {
            case KButtonTypeNormal:
                NSLog(@"点击了正常状态下的按钮");
                break;
            case KButtonTypePush:
            {
                PushViewController *pushVC = [[PushViewController alloc] init];
                [_rootViewController.navigationController pushViewController:pushVC animated:YES];
                _activityViewController = pushVC;
            }
                break;
            case KButtonTypePresent:
            {
                PresentViewController *presentVC = [[PresentViewController alloc] init];
                [_rootViewController presentViewController:presentVC animated:YES completion:NULL];
                _activityViewController = presentVC;
            }
                break;
            case KButtonTypePushBack:
            {
                [_rootViewController.navigationController popViewControllerAnimated:YES];
                _activityViewController = _rootViewController;
            }
                break;
            case KButtonTypePresentBack:
            {
                [_rootViewController dismissViewControllerAnimated:YES completion:NULL];
                _activityViewController = _rootViewController;
            }
                break;
            default:
                break;
        }
    }else if ([object isKindOfClass:[UIBarButtonItem class]]){
        [_rootViewController.navigationController popViewControllerAnimated:YES];
        _activityViewController = _rootViewController;
    }
}

@end
