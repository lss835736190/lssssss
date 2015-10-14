//
//  RegisterController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "RegisterController.h"

#import "RegisterView.h"
#import "UserEntry.h"
#import "DataBaseHandler.h"
#import "User.h"

@interface RegisterController ()

@property (nonatomic, weak, readonly) RegisterView *registerView;

@end

@implementation RegisterController

- (void)loadView {
    
    RegisterView *registerView = [[RegisterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _registerView = registerView;
    registerView.contentSize = CGSizeMake(registerView.frame.size.width, registerView.frame.size.height + 20);
    registerView.showsVerticalScrollIndicator = NO;
    self.view = registerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registed:)];
    
    // 设置代理
    for (UIView *view in self.registerView.subviews) {
        if ([view class] == [UITextField class]) {
            ((UITextField *)view).delegate = self;
        }
    }
}

#pragma mark 注册的实现
- (void)registed:(UIBarButtonItem *)item {
    
    NSString *message = nil;
    NSUInteger tagValue = 0;
    if ([self.registerView.nameText.text isEqualToString:@""]) {
        message = @"用户名不能为空!";
    } else if ([self.registerView.pwdText.text isEqualToString:@""]) {
        message = @"密码不能为空!";
    } else if (![self.registerView.pwdText.text isEqualToString:self.registerView.pwdAgainText.text]) {
        message = @"两次输入的密码不相同,请重新输入!";
        tagValue = 1;
    } else {
        // 打开数据库
        [[DataBaseHandler sharedDataBase] openDataBase];
        if ([[DataBaseHandler sharedDataBase] isExistByUserName:self.registerView.nameText.text]) {
            message = @"该用户已经存在,请选择一个其它的用户名";
            tagValue = 2;
        } else {
            message = @"注册成功";
            tagValue = 3;
        }
        [[DataBaseHandler sharedDataBase] closeDataBase];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = tagValue;
    [alert show];
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (alertView.tag) {
        case 1:
            self.registerView.pwdText.text = @"";
            self.registerView.pwdAgainText.text = @"";
            break;
        case 2:
            self.registerView.nameText.text = @"";
            self.registerView.pwdText.text = @"";
            self.registerView.emailText.text = @"";
            self.registerView.contactText.text = @"";
            break;
        case 3:
        {
            // 改变当前登录状态
            [UserEntry sharedUser].status = YES;
            
            // 保存用户信息
            User *user = [[User alloc] init];
            user.name = self.registerView.nameText.text;
            user.pwd = self.registerView.pwdText.text;
            user.email = self.registerView.emailText.text;
            user.contact = self.registerView.contactText.text;
            [[DataBaseHandler sharedDataBase] openDataBase];
            [[DataBaseHandler sharedDataBase] insertUser:user];
            [[DataBaseHandler sharedDataBase] closeDataBase];
            
            // 将结果告诉上一层的controller
            self.successRegister(YES);
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
    self.successRegister(NO);
}



#pragma mark - 实现UITextFieldDelegate的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.registerView.nameText) {
        [self.registerView.pwdText becomeFirstResponder];
    } else if (textField == self.registerView.pwdText) {
        [self.registerView.pwdAgainText becomeFirstResponder];
    } else if (textField == self.registerView.pwdAgainText) {
        [self.registerView.emailText becomeFirstResponder];
    } else if (textField == self.registerView.emailText) {
        [self.registerView.contactText becomeFirstResponder];
    } else {
        [self.registerView.contactText resignFirstResponder];
    }
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
