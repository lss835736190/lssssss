//
//  User.h
//  豆瓣
//
//  Created by lanou3g on 15/9/22.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// 用户名
@property (nonatomic, copy) NSString *name;
// 密码
@property (nonatomic, copy) NSString *pwd;
// 邮箱
@property (nonatomic, copy) NSString *email;
// 联系方式
@property (nonatomic, copy) NSString *contact;

@end
