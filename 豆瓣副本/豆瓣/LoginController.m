//
//  LoginController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#define kTopMargin 120
#define kHorizontalMargin 30
#define kInterval 20
#define kLabelWidth 100
#define kLabelHeight 30
#define kButtonHeight 50


#import "LoginController.h"

#import "User.h"
#import "LoginView.h"
#import "RegisterController.h"
#import "DataBaseHandler.h"
#import "UserEntry.h"


@interface LoginController ()

@property (nonatomic, weak, readonly) LoginView *loginView;

// 创建一个私有的用户对象
@property (nonatomic, strong) User *user;

@end

@implementation LoginController

- (void)loadView {
    
    LoginView *view = [[LoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _loginView = view;
    self.view = view;
}

#pragma mark 设置界面
- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"用户登陆";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    self.loginView.nameText.delegate = self;
    self.loginView.pwdText.delegate = self;
    
    [self.loginView.loginBtn addTarget:self action:@selector(logined:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.registerBtn addTarget:self action:@selector(registed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 导航栏的返回
- (void)back:(UIBarButtonItem *)item {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - 按钮点击事件
- (void)logined:(UIButton *)btn {
    // 退出键盘
    [self.view endEditing:YES];
    
    NSString *message = nil;
    NSUInteger tagValue = 0;
    
    // 打开数据库
    [[DataBaseHandler sharedDataBase] openDataBase];
    
    self.user = [[DataBaseHandler sharedDataBase] selectUserByUserName:self.loginView.nameText.text];
    
    if (self.user == nil) {
        message = @"该用户不存在, 请您先注册";
        tagValue = 2;
    } else {
        if ([self.loginView.pwdText.text isEqualToString:self.user.pwd]) {
            message = @"恭喜您, 登录成功!";
            tagValue = 1;
        } else {
            message = @"密码不正确, 请重新输入!";
            tagValue = 0;
        }
    }
    
    // 关闭数据库
    [[DataBaseHandler sharedDataBase] closeDataBase];
    
    // 给出提示信息
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = tagValue;
    [alert show];
}

- (void)registed:(UIButton *)btn {
    // 退下键盘
    [self.view endEditing:YES];
    
    RegisterController *regController = [[RegisterController alloc] init];
    [self.navigationController pushViewController:regController animated:YES];
    regController.successRegister = ^(BOOL success) {
        if (success) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                self.changeStatus(success);
            }];
        }
    };
}

#pragma mark - alerView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 0) {
        self.loginView.pwdText.text = @"";
    } else if (alertView.tag == 1) {
        [UserEntry sharedUser].status = YES;
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            self.changeStatus(YES);
            [UserEntry sharedUser].status = YES;
        }];
    } else {
        self.loginView.nameText.text = @"";
        self.loginView.pwdText.text = @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    [self setupView];
}

#pragma mark - textField 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.loginView.nameText) {
        [self.loginView.pwdText becomeFirstResponder];
    } else {
        [self.loginView.pwdText resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
