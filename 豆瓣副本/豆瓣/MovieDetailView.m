//
//  MovieDetailView.m
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#define kInterval 15
#define kMargin 15


#import "MovieDetailView.h"

#import "MovieDetail.h"
#import "UIImageView+WebCache.h"

@implementation MovieDetailView

#pragma mark 求出文字的高度
- (CGFloat)heightForWord:(NSString *)str view:(UIView *)view {
    
    return [str boundingRectWithSize:CGSizeMake(view.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
}

- (void)showData:(MovieDetail *)detail {
    
    // 第三方加载图片
    [self.posterImgView sd_setImageWithURL:[NSURL URLWithString:detail.poster]];
    
    // 设置评论
    self.ratingLabel.text = [NSString stringWithFormat:@"评分: %@   (%@评论)", detail.rating, detail.rating_count];
    
    self.releaseDateLabel.text = detail.release_date;
    self.runtimeLabel.text = detail.runtime;
    self.genresLabel.text = detail.genres;
    self.countryLabel.text = detail.country;
    
    // 设置制作人标签的高度
    CGRect rect = self.actorsLabel.frame;
    rect.size.height = [self heightForWord:detail.actors view:self.actorsLabel];
    self.actorsLabel.frame = rect;
    self.actorsLabel.text = detail.actors;
    
    // 设置电影情节(这四个字的标签)所在的位置
    rect = self.plotLabel.frame;
    rect.origin.y = CGRectGetMaxY(self.actorsLabel.frame) + kInterval;
    self.plotLabel.frame = rect;
    
    // 设置电影内容标签的位置和高度
    rect = self.plotSimpleLabel.frame;
    rect.size.height = [self heightForWord:detail.plot_simple view:self.plotSimpleLabel];
    rect.origin.y = CGRectGetMaxY(self.plotLabel.frame) + kInterval;
    self.plotSimpleLabel.frame = rect;
    self.plotSimpleLabel.text = detail.plot_simple;
    
    // 设置 scrollView 的滚动范围
    self.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(self.plotSimpleLabel.frame) + kMargin);
    
    // 这样做是为了让显示不能充满屏幕的也能滚动
    if (self.contentSize.height <= self.frame.size.height) {
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height + kMargin);
    }    
}



@end
