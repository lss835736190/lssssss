//
//  ActivityDetailView.m
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//


#define kDefaultHeightUpside 385
#define kMargin 15


#import "ActivityDetailView.h"

#import "Activity.h"
#import "UIImageView+WebCache.h"

@implementation ActivityDetailView

#pragma mark 求出文字的高度
- (CGFloat)heightForWord:(NSString *)str view:(UIView *)view {
    
    return [str boundingRectWithSize:CGSizeMake(view.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
}

- (void)showData:(Activity *)activity {
    
    // 第三方加载图片
    [self.activityImgView sd_setImageWithURL:[NSURL URLWithString:activity.image] placeholderImage:[UIImage imageNamed:@"picholder.png"]];
    
    self.titleLabel.text = activity.title;
    
    // 处理显示时间的标签
    self.timeLabel.text = [[activity.begin_time substringWithRange:NSMakeRange(5, 11)] stringByAppendingString:[activity.end_time substringWithRange:NSMakeRange(5, 11)]];
    self.nameLabel.text = activity.name;
    
    // 处理类型标签
    self.categoryLabel.text = [NSString stringWithFormat:@"类型: %@", activity.category_name];
    
    // 处理地址标签的高度
    self.addressLabel.text = activity.address;
    CGRect rect = self.addressLabel.frame;
    rect.size.height = [self heightForWord:activity.address view:self.addressLabel];
    self.addressLabel.frame = rect;
    
    // 处理文本内容的高度
    self.contentLabel.text = activity.content;
    rect = self.contentLabel.frame;
    rect.size.height = [self heightForWord:activity.content view:self.contentLabel];
    self.contentLabel.frame = rect;
    
    // 处理 scroll 的滚动范围
    self.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(self.contentLabel.frame) + kMargin);
}

@end
