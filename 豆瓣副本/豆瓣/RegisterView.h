//
//  RegisterView.h
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIScrollView
// 用户名
@property (nonatomic, weak, readonly) UITextField *nameText;
// 密码
@property (nonatomic, weak, readonly) UITextField *pwdText;
// 确认密码
@property (nonatomic, weak, readonly) UITextField *pwdAgainText;
// 邮箱
@property (nonatomic, weak, readonly) UITextField *emailText;
// 联系方式
@property (nonatomic, weak, readonly) UITextField *contactText;


@end
