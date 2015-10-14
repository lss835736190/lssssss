//
//  ActivityDetailView.h
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Activity;


@interface ActivityDetailView : UIScrollView

#pragma mark - 属性
// 活动标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 活动图片
@property (weak, nonatomic) IBOutlet UIImageView *activityImgView;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
// 举办方
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 类型
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
// 地址
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
// 活动内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

#pragma mark - 方法
- (void)showData:(Activity *)activity;

@end
