//
//  Activity.m
//  豆瓣
//
//  Created by lanou3g on 15/9/17.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "Activity.h"

@implementation Activity

#pragma mark 防止程序崩溃
// 防止未找到匹配的键值出现崩溃,以及将某些键值对应的建转化一下
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"owner"]) {
        self.name = value[@"name"];
    }
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

#pragma mark 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.title forKey:@"1"];
    [aCoder encodeObject:self.begin_time forKey:@"2"];
    [aCoder encodeObject:self.end_time forKey:@"3"];
    [aCoder encodeObject:self.address forKey:@"4"];
    [aCoder encodeObject:self.category_name forKey:@"5"];
    [aCoder encodeInteger:self.participant_count forKey:@"6"];
    [aCoder encodeInteger:self.wisher_count forKey:@"7"];
    [aCoder encodeObject:self.image forKey:@"8"];
    [aCoder encodeObject:self.name forKey:@"9"];
    [aCoder encodeObject:self.content forKey:@"10"];
    [aCoder encodeObject:self.ID forKey:@"11"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"1"];
        self.begin_time = [aDecoder decodeObjectForKey:@"2"];
        self.end_time = [aDecoder decodeObjectForKey:@"3"];
        self.address = [aDecoder decodeObjectForKey:@"4"];
        self.category_name = [aDecoder decodeObjectForKey:@"5"];
        self.participant_count = [aDecoder decodeIntegerForKey:@"6"];
        self.wisher_count = [aDecoder decodeIntegerForKey:@"7"];
        self.image = [aDecoder decodeObjectForKey:@"8"];
        self.name = [aDecoder decodeObjectForKey:@"9"];
        self.content = [aDecoder decodeObjectForKey:@"10"];
        self.ID = [aDecoder decodeObjectForKey:@"11"];
    }
    return self;
}

@end
