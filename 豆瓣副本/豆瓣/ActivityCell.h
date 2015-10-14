//
//  ActivityCell.h
//  豆瓣
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Activity;

@interface ActivityCell : UITableViewCell
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
// 地点
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
// 分类
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
// 感兴趣的人数
@property (weak, nonatomic) IBOutlet UILabel *wisherCountLabel;
// 参与的人数
@property (weak, nonatomic) IBOutlet UILabel *participantCountLabel;
// 活动的图像
@property (weak, nonatomic) IBOutlet UIImageView *activityImgView;

// 将数据显示到 cell 上
- (void)showData:(Activity *)activity;

@end
