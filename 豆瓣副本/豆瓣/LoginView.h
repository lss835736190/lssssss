//
//  LoginView.h
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

// 用户名
@property (nonatomic, weak, readonly) UITextField *nameText;
// 密码
@property (nonatomic, weak, readonly) UITextField *pwdText;
// 登陆
@property (nonatomic, weak, readonly) UIButton *loginBtn;
// 注册
@property (nonatomic, weak, readonly) UIButton *registerBtn;

@end
