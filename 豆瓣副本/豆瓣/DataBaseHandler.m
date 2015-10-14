//
//  DataBaseHandler.m
//  UILesson19_数据库sqlite
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "DataBaseHandler.h"
#import <sqlite3.h>

#import "User.h"
#import "Activity.h"
#import "MovieDetail.h"
#import "MyHelp.h"

// 创建一个静态的单例对象
static DataBaseHandler *handler = nil;

@implementation DataBaseHandler

#pragma mark 类方法获取该单例对象
+ (instancetype)sharedDataBase {
    
    if (handler == nil) {
        handler = [[DataBaseHandler alloc] init];
    }
    return handler;
}


#pragma mark 创建 / 打开数据库
// 创建数据库句柄对象
static sqlite3 *dbHandler = nil;

- (void)openDataBase {
    
    if (dbHandler != nil) {
        return;
    }
    
    // 获取Documents的路径
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    // 创建数据库
    NSString *dbPath = [docDir stringByAppendingPathComponent:@"AllData.sqlite"];
    NSLog(@"%@", dbPath);
    
    // 打开数据库
    if (sqlite3_open(dbPath.UTF8String, &dbHandler) == SQLITE_OK) {
        NSLog(@"数据库打开成功");
    } else {
        NSLog(@"数据库打开失败");
    }
}

#pragma mark 创建表
- (void)p_createTableByQuery:(NSString *)sqlStr {
    
    // 执行SQL语句
    if (sqlite3_exec(dbHandler, sqlStr.UTF8String, NULL, NULL, NULL) == SQLITE_OK) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
}

#pragma mark 插入数据
- (void)insertByQuery:(NSString *)sqlStr withObj:(id)obj{
    
    // 准备伴随指针
    sqlite3_stmt *stmt;
    // 预执行
    if (sqlite3_prepare(dbHandler, sqlStr.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [obj ID].UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 2, [obj title].UTF8String, -1, NULL);
        NSData *data = [MyHelp dataOfArchiverObject:obj withKey:[obj ID]];
        sqlite3_bind_blob(stmt, 3, data.bytes, (int)data.length, NULL);
        
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }
    sqlite3_finalize(stmt);
}

#pragma mark 删除数据
- (void)deleteByQuery:(NSString *)sqlStr {
    
    // 执行SQL语句
    if (sqlite3_exec(dbHandler, sqlStr.UTF8String, NULL, NULL, NULL) == SQLITE_OK) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}

#pragma mark 获取一个数据
- (instancetype)selectOneDataByQuery:(NSString *)sqlStr condition:(NSString *)ID {
    
    // 准备伴随指针
    sqlite3_stmt *stmt;
    // 预执行
    id obj = nil;
    if (sqlite3_prepare_v2(dbHandler, sqlStr.UTF8String, -1, &stmt, nil) == SQLITE_OK) {
        // 绑定参数
        sqlite3_bind_text(stmt, 1, ID.UTF8String, -1, NULL);
        // 执行读取数据
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            // 获取数据
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            // 将数据解档为对象
            obj = [MyHelp objOfUnarchiverObjectWithData:data withKey:ID];
        }
    }
    // 关闭伴随指针
    sqlite3_finalize(stmt);
    return obj;
}

#pragma mark 获取所有数据
- (NSArray *)selectAllByQuery:(NSString *)sqlStr {
    
    // 准备伴随指针
    sqlite3_stmt *stmt;
    // 预执行
    NSMutableArray *allCollections = [NSMutableArray array];
    if (sqlite3_prepare_v2(dbHandler, sqlStr.UTF8String, -1, &stmt, nil) == SQLITE_OK) {
        // 执行读取数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            id obj = [MyHelp objOfUnarchiverObjectWithData:data withKey:ID];
            [allCollections addObject:obj];
        }
    }
    // 关闭伴随指针
    sqlite3_finalize(stmt);
    return allCollections;
}

#pragma mark 关闭数据库
- (void)closeDataBase {
    
    if (sqlite3_close_v2(dbHandler) == SQLITE_OK) {
        dbHandler = nil;
        NSLog(@"关闭成功");
    } else {
        NSLog(@"关闭失败");
    }
}



#pragma mark - 活动表的操作
#pragma mark 创建活动表
- (void)createActivityTable {
    
    // 准备SQL语句
    NSString *sqlStr = @"create table if not exists activities(id text primary key, title text, data blob)";
    [self p_createTableByQuery:sqlStr];
}

#pragma mark 收藏活动
- (void)insertActivity:(Activity *)aActivity {
    
    // 准备SQL语句
    NSString *sqlStr = @"insert into activities values(?, ?, ?)";
    [self insertByQuery:sqlStr withObj:aActivity];
}

#pragma mark 删除收藏的活动
- (void)deleteActivityByID:(NSString *)ID {
    
    // 准备SQL语句
    NSString *sqlStr = [NSString stringWithFormat:@"delete from activities where id = '%@'", ID];
    [self deleteByQuery:sqlStr];
}

#pragma mark 获取一个收藏的活动
- (Activity *)selectActivityByID:(NSString *)ID {
    
    // 准备SQL语句
    NSString *sqlStr = @"select data from activities where id = ?";
    return (Activity *)[self selectOneDataByQuery:sqlStr condition:ID];
}

#pragma mark 获取所有收藏的活动
- (NSArray *)selectAllActivities {
    
    // 准备SQL语句
    NSString *sqlStr = @"select id, data from activities";
    return [self selectAllByQuery:sqlStr];
}

#pragma mark - 电影表的操作
#pragma mark 创建电影表
- (void)createMovieTable {
    
    // 准备SQL语句
    NSString *sqlStr = @"create table if not exists movies(id text primary key, title text, data blob)";
    // 2. 执行SQL语句
    [self p_createTableByQuery:sqlStr];
}

#pragma mark 收藏电影
- (void)insertMovie:(MovieDetail *)aMovie {
    
    // 准备SQL语句
    NSString *sqlStr = @"insert into movies values(?, ?, ?)";
    [self insertByQuery:sqlStr withObj:aMovie];
}

#pragma mark 删除一个电影
- (void)deleteMovieByID:(NSString *)ID {
    
    // 准备SQL语句
    NSString *sqlStr = [NSString stringWithFormat:@"delete from movies where id = '%@'", ID];
    [self deleteByQuery:sqlStr];
}

#pragma mark 查找一个电影
- (MovieDetail *)selectMovieByID:(NSString *)ID {
    
    // 准备SQL语句
    NSString *sqlStr = @"select data from movies where id = ?";
    return (MovieDetail *)[self selectOneDataByQuery:sqlStr condition:ID];
}

#pragma mark 查找所有电影
- (NSArray *)selectAllMovies {
    
    // 准备SQL语句
    NSString *sqlStr = @"select id, data from movies";
    return [self selectAllByQuery:sqlStr];
}





#pragma mark - 操作用户 -
#pragma mark 创建用户表
- (void)createUserTable {
    
    // 准备SQL语句
    NSString *sqlStr = @"create table if not exists users(name text primary key, pwd text, email text, contact text)";
    [self p_createTableByQuery:sqlStr];
}

#pragma mark 添加一个用户
- (void)insertUser:(User *)user {
    
    // 准备SQL语句
    NSString *sqlStr = [NSString stringWithFormat:@"insert into users values('%@', '%@', '%@', '%@')", user.name, user.pwd, user.email, user.contact];
    // 执行SQL语句
    if (sqlite3_exec(dbHandler, sqlStr.UTF8String, NULL, NULL, NULL) == SQLITE_OK) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
}

#pragma mark 获取用户信息
- (User *)selectUserByUserName:(NSString *)userName {
    
    // 准备SQL语句
    NSString *sqlStr = @"select * from users where name = ?";
    // 准备伴随指针
    sqlite3_stmt *stmt;
    // 预执行
    User *usr = nil;
    if (sqlite3_prepare_v2(dbHandler, sqlStr.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        // 绑定参数
        sqlite3_bind_text(stmt, 1, userName.UTF8String, -1, NULL);
        // 执行
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            usr = [[User alloc] init];
            usr.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            usr.pwd = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            usr.email = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            usr.contact = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        }
    }
    return usr;
}

#pragma mark 判断用户是否存在
- (BOOL)isExistByUserName:(NSString *)userName {
    
    return [self selectUserByUserName:userName] != nil;
}

@end