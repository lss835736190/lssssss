//
//  MovieCollectionCell.h
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface MovieCollectionCell : UICollectionViewCell

#pragma mark - 属性
// 显示图片
@property (nonatomic, strong) UIImageView *imageView;
// 显示标题
@property (nonatomic, strong) UILabel *titleLabel;

#pragma mark - 方法
- (void)showData:(Movie *)movie;

@end
