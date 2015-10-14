//
//  Cinema.h
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cinema : NSObject

// 影院 id
@property (nonatomic, strong) NSString *ID;
// 影院名称
@property (nonatomic, strong) NSString *cinemaName;
// 影院地址
@property (nonatomic, strong) NSString *address;
// 影院电话
@property (nonatomic, strong) NSString *telephone;
// 影院乘车路线
@property (nonatomic, strong) NSString *trafficRoutes;

@end
