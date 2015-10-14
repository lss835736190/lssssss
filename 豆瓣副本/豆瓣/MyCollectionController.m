//
//  MyCollectionController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "MyCollectionController.h"

#import "LoginController.h"
#import "MyActivitiesController.h"
#import "MyMoviesController.h"
#import "MyHelp.h"
#import "UserEntry.h"

@interface MyCollectionController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation MyCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login:)];
    
    // 设置导航栏的按钮的前景色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.dataArr = @[@"我的活动", @"我的电影", @"清除缓存"];
    
    [MyHelp showProgress:self.view];
}

- (void)login:(UIBarButtonItem *)item {
    
    // tag值默认是0, 默认显示的也是登录(0表示登录, 1表示注销)
    if (item.tag == 0) {
        LoginController *loginController = [[LoginController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self.navigationController presentViewController:navigation animated:YES completion:^{}];
        
        loginController.changeStatus = ^(BOOL status) {
            self.navigationItem.rightBarButtonItem.tag = status;
            if (status == YES) {
                self.navigationItem.rightBarButtonItem.title = @"注销";
            }
        };
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认注销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = item.tag;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        self.navigationItem.rightBarButtonItem.tag = 0;
        self.navigationItem.rightBarButtonItem.title = @"登录";
        [UserEntry sharedUser].status = NO;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 如果用户已经登录,直接进入下一个界面
    // 如果用户还没有登录,就弹出登录界面,用户登录成功后,直接进入点击的界面
    if ([UserEntry sharedUser].isLogin) {
        [self p_changeControllerWithRow:indexPath.row];
    } else {
        LoginController *loginController = [[LoginController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self.navigationController presentViewController:navController animated:YES completion:^{}];
        
        // 根据传递回来的状态做出响应
        loginController.changeStatus = ^(BOOL status) {
            if (status == YES) {
                self.navigationItem.rightBarButtonItem.title = @"注销";
                self.navigationItem.rightBarButtonItem.tag = 1;
                [self p_changeControllerWithRow:indexPath.row];
            }
        };
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    if ([UserEntry sharedUser].isLogin) {
        self.navigationItem.rightBarButtonItem.title = @"注销";
        self.navigationItem.rightBarButtonItem.tag = 1;
    }
}

#pragma mark - 根据点击的位置切换到其他页面
- (void)p_changeControllerWithRow:(NSUInteger)row {
    
    if (row == 0) {
        MyActivitiesController *actController = [[MyActivitiesController alloc] init];
        [self.navigationController pushViewController:actController animated:YES];
    } else if (row == 1) {
        MyMoviesController *movController = [[MyMoviesController alloc] init];
        [self.navigationController pushViewController:movController animated:YES];
    } else {
#warning 清理缓存未实现
        NSLog(@"清理缓存");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
