//
//  Cinema.m
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "Cinema.h"

@implementation Cinema

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
