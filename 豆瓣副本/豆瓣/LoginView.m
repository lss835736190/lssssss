//
//  LoginView.m
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


#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark 设置界面
- (void)setupView {
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kHorizontalMargin, kTopMargin, kLabelWidth, kLabelHeight)];
    nameLabel.text = @"用户名:";
    nameLabel.font = [UIFont systemFontOfSize:22];
    [self addSubview:nameLabel];    
    
    UITextField *nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + kInterval, CGRectGetMinY(nameLabel.frame), self.frame.size.width - kHorizontalMargin * 2 - kInterval - nameLabel.frame.size.width, nameLabel.frame.size.height)];
    nameTxt.placeholder = @"请输入用户名";
    nameTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTxt.returnKeyType = UIReturnKeyNext;
    _nameText = nameTxt;
    [self addSubview:_nameText];
    
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame) + kInterval, kLabelWidth, kLabelHeight)];
    pwdLabel.text = @"密码:";
    pwdLabel.font = [UIFont systemFontOfSize:22];
    [self addSubview:pwdLabel];
    
    UITextField *pwdTxt = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameText.frame), CGRectGetMaxY(self.nameText.frame) + kInterval, CGRectGetWidth(self.nameText.frame), CGRectGetHeight(self.nameText.frame))];
    pwdTxt.placeholder = @"请输入密码";
    pwdTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwdTxt.returnKeyType = UIReturnKeyGo;
    pwdTxt.secureTextEntry = YES;
    _pwdText = pwdTxt;
    [self addSubview:_pwdText];
    
    CGFloat btnWidth = (self.frame.size.width - kHorizontalMargin * 2 - kInterval) * 0.5f;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(CGRectGetMinX(pwdLabel.frame), CGRectGetMaxY(pwdLabel.frame) + kInterval, btnWidth, kButtonHeight);
    loginBtn.backgroundColor = [UIColor brownColor];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.clipsToBounds = YES;
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    _loginBtn = loginBtn;
    [self addSubview:_loginBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registerBtn.frame = CGRectMake(CGRectGetMaxX(self.loginBtn.frame) + kInterval, CGRectGetMaxY(pwdLabel.frame) + kInterval, btnWidth, kButtonHeight);
    registerBtn.backgroundColor = [UIColor orangeColor];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.layer.cornerRadius = 5;
    registerBtn.clipsToBounds = YES;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    _registerBtn = registerBtn;
    [self addSubview:_registerBtn];
}

@end
