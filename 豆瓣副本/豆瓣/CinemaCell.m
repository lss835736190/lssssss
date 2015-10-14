//
//  CinemaCell.m
//  豆瓣
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#define kMargin 10
#define kInterval 10
#define kLabelDefaultHeight 20


#import "CinemaCell.h"

#import "Cinema.h"

@implementation CinemaCell

- (UIImageView *)backImgView {
    
    if (_backImgView == nil) {
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, kMargin, self.frame.size.width - kMargin * 2, self.frame.size.height - kMargin * 2)];
        [self.contentView addSubview:_backImgView];
    }
    return _backImgView;
}


#pragma mark 懒加载初始化控件
- (UILabel *)cinemaNameLabel {
    
    if (_cinemaNameLabel == nil) {
        _cinemaNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin, CGRectGetWidth(self.backImgView.frame) - kMargin * 2, kLabelDefaultHeight)];
        _cinemaNameLabel.font = [UIFont systemFontOfSize:25];
        [self.backImgView addSubview:_cinemaNameLabel];
    }
    return _cinemaNameLabel;
}

- (UILabel *)addressLabel {
    
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.cinemaNameLabel.frame), CGRectGetMaxY(self.cinemaNameLabel.frame) + kInterval, CGRectGetWidth(self.cinemaNameLabel.frame), kLabelDefaultHeight)];
        _addressLabel.textColor = [UIColor darkGrayColor];
        _addressLabel.numberOfLines = 0;
        [self.backImgView addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (UILabel *)telephoneLabel {
    
    if (_telephoneLabel == nil) {
        _telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.addressLabel.frame), CGRectGetMaxY(self.addressLabel.frame) + kInterval, CGRectGetWidth(self.addressLabel.frame), kLabelDefaultHeight)];
        _telephoneLabel.textColor = [UIColor darkGrayColor];
        [self.backImgView addSubview:_telephoneLabel];
    }
    return _telephoneLabel;
}


#pragma mark 将数据显示在 cell 上
- (void)showData:(Cinema *)cinema {
    
    self.backImgView.image = [UIImage imageNamed:@"bg_eventlistcell.png"];
    self.cinemaNameLabel.text = cinema.cinemaName;
    self.addressLabel.text = cinema.address;
    
    // 更改电话标签的位置
    CGRect rect = self.telephoneLabel.frame;
    rect.origin.y = self.addressLabel.frame.origin.y + self.addressLabel.frame.size.height + kInterval;
    self.telephoneLabel.frame = rect;
    self.telephoneLabel.text = cinema.telephone;
    
    // 最后更改背景的高度
    rect = self.backImgView.frame;
    rect.size.height = kLabelDefaultHeight * 2 + kMargin * 2 + kInterval * 2 + self.addressLabel.frame.size.height;
    self.backImgView.frame = rect;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
