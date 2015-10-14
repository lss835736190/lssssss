//
//  UserEntry.m
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "UserEntry.h"

static UserEntry *user = nil;

@implementation UserEntry

+ (instancetype)sharedUser {
    
    if (user == nil) {
        user = [[UserEntry alloc] init];
    }
    return user;
}

- (BOOL)isLogin {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"status"];
}

- (void)setStatus:(BOOL)status {
    
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"status"];
}

@end
