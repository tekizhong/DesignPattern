//
//  PushViewController.m
//  TKSingleton
//
//  Created by Evergrande-teki on 2019/4/11.
//  Copyright © 2019年 Evergrande-teki. All rights reserved.
//

#import "PushViewController.h"
#import "TKSingleton.h"
@interface PushViewController ()

@end

@implementation PushViewController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    // 若没有allocWithZone方法，此处打印出来的TKSingleton对象跟单例创建的对象地址不一样。导致问题出现。
    NSLog(@"array:%@",array);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark -  CustomDelegate

#pragma mark -  Event Response
- (void)back:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.tag = KButtonTypePushBack;
    [[TKSingleton sharedInstance] buttonClick:btn];
}

#pragma mark -  Private Methods

#pragma mark -  Getters and Setters





@end
