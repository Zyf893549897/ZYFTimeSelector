//
//  ZYFViewController.m
//  ZYFTimeSelector
//
//  Created by 张云飞 on 09/11/2022.
//  Copyright (c) 2022 张云飞. All rights reserved.
//

#import "ZYFViewController.h"
#import <ZYFTimeSelector-umbrella.h>
#define kZYFScreenBounds [UIScreen mainScreen].bounds
@interface ZYFViewController ()

@end

@implementation ZYFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton * but = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    but.backgroundColor = [UIColor orangeColor];
    [but addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}

-(void)butAction:(UIButton *)but{
    TimeSelectedView * timeView=[[TimeSelectedView alloc] initWithFrame:kZYFScreenBounds];
    timeView.timeBlockA = ^(NSString * _Nonnull timestr) {
        NSLog(@"=======%@",timestr);
    };
    [timeView zyf_showInAppWindowAnimation];
}

@end
