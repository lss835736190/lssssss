//
//  ActivityDetailController.h
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Activity;

@interface ActivityDetailController : UIViewController

// 接受上一个页面传递过来的数据
@property (nonatomic, strong) Activity *activity;

@end
