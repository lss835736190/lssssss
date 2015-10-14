//
//  MovieDetail.h
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetail : NSObject <NSCoding>

// 电影编号,方便存入数据库中
@property (nonatomic, strong) NSString *ID;

// 简介
@property (nonatomic, strong) NSString *plot_simple;
// 电影名字
@property (nonatomic, strong) NSString *title;
// 分类
@property (nonatomic, strong) NSString *genres;
// 国家
@property (nonatomic, strong) NSString *country;
// 时间
@property (nonatomic, strong) NSString *runtime;
// 图片
@property (nonatomic, strong) NSString *poster;
// 评论人数
@property (nonatomic, strong) NSString *rating_count;
// 评分
@property (nonatomic, strong) NSString *rating;
// 上映时间
@property (nonatomic, strong) NSString *release_date;
// 制作人信息
@property (nonatomic, strong) NSString * actors;

@end
