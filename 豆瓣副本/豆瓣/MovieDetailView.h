//
//  MovieDetailView.h
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieDetail;

@interface MovieDetailView : UIScrollView

#pragma mark - 属性
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *posterImgView;
// 评分 + 评论人数
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
// 上映时间
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
// 分类
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
// 国家
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
// 制作人信息
@property (weak, nonatomic) IBOutlet UILabel *actorsLabel;
// 简介
@property (weak, nonatomic) IBOutlet UILabel *plotSimpleLabel;
// 电影情节(只显示这四个字,设置属性是为了布局的需要)
@property (weak, nonatomic) IBOutlet UILabel *plotLabel;

#pragma mark - 方法
- (void)showData:(MovieDetail *)detail;

@end
