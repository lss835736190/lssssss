//
//  CinemaCell.h
//  豆瓣
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cinema;

@interface CinemaCell : UITableViewCell

#pragma mark - 属性
// 最下层的 View
@property (nonatomic, strong) UIImageView *backImgView;
// 影院名称
@property (nonatomic, strong) UILabel *cinemaNameLabel;
// 影院地址
@property (nonatomic, strong) UILabel *addressLabel;
// 影院电话
@property (nonatomic, strong) UILabel *telephoneLabel;

#pragma mark - 方法
// 显示数据
- (void)showData:(Cinema *)cinema;

@end
