//
//  MovieShowController.h
//  豆瓣
//
//  Created by lanou3g on 15/9/20.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieShowController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
// 需要两个view进行转换

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end
