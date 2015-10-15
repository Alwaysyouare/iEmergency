//
//  ICIMoreEvents.m
//  iEmergency
//
//  Created by ICI on 15-8-10.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreEvents.h"

#define KeyForEventId @"KeyEventId"
#define KeyForEventName @"KeyEventName"
#define KeyForEventLevel @"KeyEventLevel"
#define KeyForEventDepth @"KeyEventDepth"
#define KeyForEventLon @"KeyEventLon"
#define KeyForEventLat @"KeyEventLat"
#define KeyForEventPos @"KeyEventPos"
#define KeyForEventStartTime @"KeyEventStartTime"

@implementation ICIMoreEvents

/**
 *  当从文件中读取一个对象的时候调用
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.DzEventId = [aDecoder decodeObjectForKey:KeyForEventId];
        self.DzEventName = [aDecoder decodeObjectForKey:KeyForEventName];
        self.DzLevel = [aDecoder decodeObjectForKey:KeyForEventLevel];
        self.DzDepth = [aDecoder decodeObjectForKey:KeyForEventDepth];
        self.DzLon = [aDecoder decodeObjectForKey:KeyForEventLon];
        self.DzLat = [aDecoder decodeObjectForKey:KeyForEventLat];
        self.DzPos = [aDecoder decodeObjectForKey:KeyForEventPos];
        self.DzStartTime = [aDecoder decodeObjectForKey:KeyForEventStartTime];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *
 *  @param aCoder <#aCoder description#>
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.DzEventId forKey:KeyForEventId];
    [aCoder encodeObject:self.DzEventName forKey:KeyForEventName];
    [aCoder encodeObject:self.DzLevel forKey:KeyForEventLevel];
    [aCoder encodeObject:self.DzDepth forKey:KeyForEventDepth];
    [aCoder encodeObject:self.DzLon forKey:KeyForEventLon];
    [aCoder encodeObject:self.DzLat forKey:KeyForEventLat];
    [aCoder encodeObject:self.DzPos forKey:KeyForEventPos];
    [aCoder encodeObject:self.DzStartTime forKey:KeyForEventStartTime];
}

@end
