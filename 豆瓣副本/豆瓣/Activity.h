//
//  Activity.h
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject <NSCoding>
// 活动编号,方便存到数据库中
@property (nonatomic, strong) NSString *ID;

// 活动标题
@property (nonatomic, strong) NSString *title;
// 开始时间
@property (nonatomic, strong) NSString *begin_time;
// 结束时间
@property (nonatomic, strong) NSString *end_time;
// 地址
@property (nonatomic, strong) NSString *address;
// 活动类型
@property (nonatomic, strong) NSString *category_name;
// 参加人数
@property (nonatomic, assign) NSUInteger participant_count;
// 感兴趣人数
@property (nonatomic, assign) NSUInteger wisher_count;
// 活动图像
@property (nonatomic, strong) NSString *image;
// 活动举办方
@property (nonatomic, strong) NSString *name;
// 活动内容
@property (nonatomic, strong) NSString *content;

@end
