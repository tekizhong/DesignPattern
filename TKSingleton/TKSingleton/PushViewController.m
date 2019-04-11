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
