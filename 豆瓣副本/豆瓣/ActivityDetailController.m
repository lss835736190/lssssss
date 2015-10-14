//
//  ActivityDetailController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "ActivityDetailController.h"

#import "ActivityDetailView.h"
#import "Activity.h"
#import "MyHelp.h"
#import "UserEntry.h"
#import "LoginController.h"
#import "DataBaseHandler.h"

@interface ActivityDetailController () {
    
    UIAlertView *_alert;
}

@end

@implementation ActivityDetailController

#pragma mark 设置显示的 View,同时显示传递过来的数据
- (void)loadView {
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"ActivityDetailView" owner:nil options:nil];
    ActivityDetailView *detailView = arr.lastObject;
    // 使垂直方向上的滚动条不显示
    detailView.showsVerticalScrollIndicator = NO;
    // 将传递过来的数据显示出来
    [detailView showData:self.activity];
    self.view = detailView;
}

#pragma mark 设置界面
- (void)setupView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_share.png"] style:UIBarButtonItemStyleDone target:self action:@selector(collected:)];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.title = self.activity.title;
    
    
    [MyHelp showProgress:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    [self setupView];
}

#pragma mark 点击导航栏的返回
- (void)back:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 对收藏行为做处理 -
- (void)p_dealWithCollectionBehaviour {
    
    /*
     这个过程中,打开数据库,做完处理之后,要立即关闭数据库
     如果已经收藏了,给出提示信息
     如果还没有收藏,首先进行收藏,然后给出提示信息
     */
    
    // 打开数据库
    [[DataBaseHandler sharedDataBase] openDataBase];
    // 判断是否已经收藏
    if ([[DataBaseHandler sharedDataBase] selectActivityByID:self.activity.ID]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该活动已经收藏过" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        // 活动还没有被收藏,需要收藏的情况
        // 存入数据库
        [[DataBaseHandler sharedDataBase] insertActivity:self.activity];
        // 显示提示信息
        [self p_createAlertView];
    }
    // 关闭数据库
    [[DataBaseHandler sharedDataBase] closeDataBase];
}

#pragma mark 点击导航栏的收藏
- (void)collected:(UIBarButtonItem *)item {
    
    if ([UserEntry sharedUser].isLogin) { // 已经登录的情况
        [self p_dealWithCollectionBehaviour];
    } else {
        
        LoginController *loginController = [[LoginController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self.navigationController presentViewController:navController animated:YES completion:^{}];
        
        loginController.changeStatus = ^(BOOL status) {
            if (status == YES) {
                // 改变登录状态
                [UserEntry sharedUser].status = status;
                [self p_dealWithCollectionBehaviour];
            }
        };
    }
}

#pragma mark - 创建自动消失的alertView
- (void)p_createAlertView {
    
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissAlertView) userInfo:nil repeats:NO];
    [_alert show];
}

#pragma mark 触发alertView消失
- (void)dismissAlertView {
    
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
