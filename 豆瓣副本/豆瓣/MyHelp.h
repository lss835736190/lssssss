//
//  MyHelp.h
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHelp : NSObject

// 显示进度小菊花
+ (void)showProgress:(UIView *)view;

#pragma mark 数据库专用归档和解档函数
+ (NSData *)dataOfArchiverObject:(id)obj withKey:(NSString *)key;
+ (instancetype)objOfUnarchiverObjectWithData:(NSData *)data withKey:(NSString *)key;

@end
