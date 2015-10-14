//
//  MovieCollectionCell.m
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//


#define kInterval 10
#define kMargin 10
#define kImgWidth 100
#define kImgHeight 190
#define kTitleHeight 30



#import "MovieCollectionCell.h"

#import "Movie.h"
#import "UIImageView+WebCache.h"

@implementation MovieCollectionCell

// 懒加载
- (UIImageView *)imageView {
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height -  kTitleHeight)];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imageView.frame), CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.imageView.frame), kTitleHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

// 将数据显示在界面上
- (void)showData:(Movie *)movie {
    
    // 第三方加载图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:movie.pic_url]];
    self.titleLabel.text = movie.movieName;
}

@end
