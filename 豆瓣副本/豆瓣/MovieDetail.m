//
//  MovieDetail.m
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "MovieDetail.h"

@implementation MovieDetail

#pragma mark 放置出现崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"movieid"]) {
        self.ID = value;
    }
}

#pragma mark 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.ID forKey:@"0"];
    [aCoder encodeObject:self.plot_simple forKey:@"1"];
    [aCoder encodeObject:self.title forKey:@"2"];
    [aCoder encodeObject:self.genres forKey:@"3"];
    [aCoder encodeObject:self.country forKey:@"4"];
    [aCoder encodeObject:self.runtime forKey:@"5"];
    [aCoder encodeObject:self.poster forKey:@"6"];
    [aCoder encodeObject:self.rating_count forKey:@"7"];
    [aCoder encodeObject:self.rating forKey:@"8"];
    [aCoder encodeObject:self.release_date forKey:@"9"];
    [aCoder encodeObject:self.actors forKey:@"10"];
}

#pragma mark 解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.ID = [aDecoder decodeObjectForKey:@"0"];
        self.plot_simple = [aDecoder decodeObjectForKey:@"1"];
        self.title = [aDecoder decodeObjectForKey:@"2"];
        self.genres = [aDecoder decodeObjectForKey:@"3"];
        self.country = [aDecoder decodeObjectForKey:@"4"];
        self.runtime = [aDecoder decodeObjectForKey:@"5"];
        self.poster = [aDecoder decodeObjectForKey:@"6"];
        self.rating_count = [aDecoder decodeObjectForKey:@"7"];
        self.rating = [aDecoder decodeObjectForKey:@"8"];
        self.release_date = [aDecoder decodeObjectForKey:@"9"];
        self.actors = [aDecoder decodeObjectForKey:@"10"];
    }
    return self;
}

@end
