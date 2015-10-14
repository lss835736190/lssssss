//
//  MovieDetailController.h
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieDetail;

@interface MovieDetailController : UIViewController

// 记录传递过来的电影详情信息(从收藏页面传递过来)
@property (nonatomic, strong) MovieDetail *movieDetail;
// 记录上个页面传递过来的电影的ID,方便本页面进行网络请求
@property (nonatomic, strong) NSString *movieId;

@end
