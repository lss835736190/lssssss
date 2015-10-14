//
//  ActivityCell.m
//  豆瓣
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "ActivityCell.h"

#import "Activity.h"
#import "UIImageView+WebCache.h"

@implementation ActivityCell

#pragma mark 对日期字符串进行格式化为想要的类型
- (NSString *)stringFromDateString:(NSString *)dateStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    formatter.dateFormat = @"MM-dd HH:mm";
    return [formatter stringFromDate:date];
}

- (void)showData:(Activity *)activity {
    
    self.titleLabel.text = activity.title;
    self.timeLabel.text = [[self stringFromDateString:activity.begin_time] stringByAppendingFormat:@"--%@", [self stringFromDateString:activity.end_time]];    
    self.addressLabel.text = activity.address;
    self.categoryLabel.text = activity.category_name;
    self.participantCountLabel.text = [NSString stringWithFormat:@"%lu", activity.participant_count];
    self.wisherCountLabel.text = [NSString stringWithFormat:@"%lu", activity.wisher_count];
    // 利用第三方类加载图片
    [self.activityImgView sd_setImageWithURL:[NSURL URLWithString:activity.image] placeholderImage:[UIImage imageNamed:@"picholder.png"]];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
