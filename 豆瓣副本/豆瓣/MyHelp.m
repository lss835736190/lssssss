//
//  MyHelp.m
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "MyHelp.h"

#import "MBProgressHUD.h"

@implementation MyHelp

#pragma mark 将对象归档,获取数据对象
+ (NSData *)dataOfArchiverObject:(id)obj withKey:(NSString *)key {
    
    // 初始化数据对象
    NSMutableData *data = [NSMutableData data];
    // 将数据对象与归档器绑定
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始归档数据
    [archiver encodeObject:obj forKey:key];
    // 结束归档
    [archiver finishEncoding];
    // 返回转化为数据的对象
    return data;
}

#pragma mark 将数据解档为对象   fecefcefas
+ (instancetype)objOfUnarchiverObjectWithData:(NSData *)data withKey:(NSString *)key {
    
    // 将数据与解档器绑定
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 解档数据
    id obj = [unarchiver decodeObjectForKey:key];
    // 解档结束
    [unarchiver finishDecoding];
    // 返回对象
    return obj;
}

#pragma mark 显示小菊花
+ (void)showProgress:(UIView *)view {
    
    // 第三方类库显示小菊花
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    // 显示的文字
    hud.labelText = @"黄强为您加载";
   
    [view addSubview:hud];
    [hud show:YES];
    // 延迟0.5s后消失
    [hud hide:YES afterDelay:0.5f];
}


@end
