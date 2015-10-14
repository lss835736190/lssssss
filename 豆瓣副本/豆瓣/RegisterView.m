//
//  RegisterView.m
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#define kMargin 30
#define kInterval 10
#define kLabelWidth 100
#define kLabelHeight 50


#import "RegisterView.h"

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 初始化用户名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin, kLabelWidth, kLabelHeight)];
    nameLabel.text = @"用户名:";
    [self addSubview:nameLabel];
    
    UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+ kInterval, CGRectGetMinY(nameLabel.frame), CGRectGetWidth(self.frame) - CGRectGetWidth(nameLabel.frame) - kMargin * 2 - kInterval, CGRectGetHeight(nameLabel.frame))];
    nameText.placeholder = @"请输入用户名";
    _nameText = nameText;
    [self addSubview:_nameText];
    
    // 初始化密码
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame) + kInterval, CGRectGetWidth(nameLabel.frame), CGRectGetHeight(nameLabel.frame))];
    pwdLabel.text = @"密码:";
    [self addSubview:pwdLabel];
    
    UITextField *pwdText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameText.frame), CGRectGetMinY(pwdLabel.frame), CGRectGetWidth(nameText.frame), CGRectGetHeight(nameText.frame))];
    pwdText.secureTextEntry = YES;
    pwdText.placeholder = @"请输入密码";
    _pwdText = pwdText;
    [self addSubview:_pwdText];
    
    // 初始化确认密码
    UILabel *pwdAgainLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(pwdLabel.frame), CGRectGetMaxY(pwdLabel.frame) + kInterval, CGRectGetWidth(pwdLabel.frame), CGRectGetHeight(pwdLabel.frame))];
    pwdAgainLabel.text = @"确认密码:";
    [self addSubview:pwdAgainLabel];
    
    UITextField *pwdAgainText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(pwdText.frame), CGRectGetMinY(pwdAgainLabel.frame), CGRectGetWidth(pwdText.frame), CGRectGetHeight(pwdText.frame))];
    pwdAgainText.secureTextEntry = YES;
    pwdAgainText.placeholder = @"再次输入密码";
    _pwdAgainText = pwdAgainText;
    [self addSubview:_pwdAgainText];
    
    // 初始化邮箱
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(pwdAgainLabel.frame), CGRectGetMaxY(pwdAgainLabel.frame) + kInterval, CGRectGetWidth(pwdAgainLabel.frame), CGRectGetHeight(pwdAgainLabel.frame))];
    emailLabel.text = @"邮箱:";
    [self addSubview:emailLabel];
    
    UITextField *emailText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(pwdAgainText.frame), CGRectGetMinY(emailLabel.frame), CGRectGetWidth(pwdAgainText.frame), CGRectGetHeight(pwdAgainText.frame))];
    emailText.keyboardType = UIKeyboardTypeEmailAddress;
    emailText.placeholder = @"请输入邮箱";
    _emailText = emailText;
    [self addSubview:_emailText];
    
    // 初始化邮箱
    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(emailLabel.frame), CGRectGetMaxY(emailLabel.frame) + kInterval, CGRectGetWidth(emailLabel.frame), CGRectGetHeight(emailLabel.frame))];
    contactLabel.text = @"联系方式:";
    [self addSubview:contactLabel];
    
    UITextField *contactText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(emailText.frame), CGRectGetMinY(contactLabel.frame), CGRectGetWidth(emailText.frame), CGRectGetHeight(emailText.frame))];
    contactText.keyboardType = UIKeyboardTypeNumberPad;
    contactText.placeholder = @"请输入联系方式";
    _contactText = contactText;
    [self addSubview:_contactText];
    
    // 总体设置字体大小
    for (UIView *view in self.subviews) {
        if ([view class] == [UILabel class]) {
            UILabel *label = (UILabel *)view;
            // 设置字体的大小
            label.font = [UIFont systemFontOfSize:22];
        } else {
            UITextField *text = (UITextField *)view;
            // 设置显示下一项
            text.returnKeyType = UIReturnKeyNext;
            // 设置当编辑的时候显示清理按钮
            text.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
}

@end
