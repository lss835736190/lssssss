//
//  MovieCell.m
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "MovieCell.h"

#import "Movie.h"
#import "UIImageView+WebCache.h"

@implementation MovieCell


- (void)showData:(Movie *)movie {
    
    [self.movieImgView sd_setImageWithURL:[NSURL URLWithString:movie.pic_url] placeholderImage:[UIImage imageNamed:@"picholder.png"]];
    self.movieNameLabel.text = movie.movieName;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
