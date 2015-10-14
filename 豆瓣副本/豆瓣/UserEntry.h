//
//  UserEntry.h
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntry : NSObject

// 是否登录
@property (nonatomic, assign, getter=isLogin) BOOL status;

// 获取当前用户单例
+ (instancetype)sharedUser;

@end
