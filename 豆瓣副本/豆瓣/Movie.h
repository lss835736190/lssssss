//
//  Movie.h
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

// 电影名
@property (nonatomic, strong) NSString *movieName;
// 图片地址
@property (nonatomic, strong) NSString *pic_url;
// 电影编号
@property (nonatomic, strong) NSString *movieId;

@end
