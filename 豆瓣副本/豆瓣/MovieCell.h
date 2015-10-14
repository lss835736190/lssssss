//
//  MovieCell.h
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface MovieCell : UITableViewCell
// 电影宣传海报
@property (weak, nonatomic) IBOutlet UIImageView *movieImgView;
// 电影名
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;

// 显示数据
- (void)showData:(Movie *)movie;

@end
