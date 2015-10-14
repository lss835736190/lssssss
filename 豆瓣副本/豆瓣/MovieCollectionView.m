//
//  MovieCollectionView.m
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "MovieCollectionView.h"

@implementation MovieCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
