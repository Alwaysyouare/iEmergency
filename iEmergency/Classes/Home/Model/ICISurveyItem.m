//
//  ICISurveyItem.m
//  iEmergency
//
//  Created by ICI on 15-8-31.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICISurveyItem.h"
//#import "MJExtension.h"

@implementation ICISurveyItem

- (instancetype) initWithName:(NSString *)name key:(NSString *)key value:(NSString *)value nTag:(NSInteger)nTag nType:(NSInteger)nType
{
    if (self = [super init]) {
        self.name = name;
        self.value = value;
        self.key = key;
        self.nTag = nTag;
        self.nType = nType;
    }
    return  self;
    
}

/**
 *
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
- (instancetype) initWithDict:(NSDictionary *)dict
{
    //return [ICISurveyItem objectWithKeyValues:dict];
    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype) itemWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
