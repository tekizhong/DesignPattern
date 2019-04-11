//
//  TKSingleton.h
//  TKSingleton
//
//  Created by Evergrande-teki on 2019/4/11.
//  Copyright © 2019年 Evergrande-teki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

typedef enum : NSUInteger {
    KButtonTypeNormal,
    KButtonTypePush,
    KButtonTypePresent,
    KButtonTypePushBack,
    KButtonTypePresentBack
} KButtonType;

@interface TKSingleton : NSObject<NSCopying>

@property (nonatomic, readonly)  UIViewController *activityViewController;
@property (nonatomic, readonly) RootViewController *rootViewController;

+ (TKSingleton *) sharedInstance;

- (IBAction)buttonClick:(id)object;

@end
