//
//  DataBaseHandler.h
//  UILesson19_数据库sqlite
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class Activity;
@class MovieDetail;

@interface DataBaseHandler : NSObject

// 获取单例对象
+ (instancetype)sharedDataBase;


// 1. 创建 / 打开数据库
- (void)openDataBase;
// 关闭数据库
- (void)closeDataBase;


#pragma mark - 操作活动
// 创建一个活动收藏表
- (void)createActivityTable;
// 添加一个活动
- (void)insertActivity:(Activity *)aActivity;
// 删除一个活动
- (void)deleteActivityByID:(NSString *)ID;
// 查找一个活动
- (Activity *)selectActivityByID:(NSString *)ID;
// 查找所有的活动
- (NSArray *)selectAllActivities;

#pragma mark - 操作电影
// 创建一个电影
- (void)createMovieTable;
// 添加一个电影
- (void)insertMovie:(MovieDetail *)aMovie;
// 删除一个电影
- (void)deleteMovieByID:(NSString *)ID;
// 查找一个电影
- (MovieDetail *)selectMovieByID:(NSString *)ID;
// 查找所有电影
- (NSArray *)selectAllMovies;

#pragma mark - 操作用户
// 创建用户表
- (void)createUserTable;
// 添加一个用户
- (void)insertUser:(User *)user;
// 查找一个用户
- (User *)selectUserByUserName:(NSString *)userName;
// 判断用户是否存在
- (BOOL)isExistByUserName:(NSString *)userName;


@end
