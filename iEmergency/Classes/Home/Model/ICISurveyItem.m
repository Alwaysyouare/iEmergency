//
//  ICISurveyItem.m
//  iEmergency
//
//  Created by ICI on 15-8-31.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICISurveyItem.h"

@implementation ICISurveyItem

- (instancetype)initWithName:(NSString *)name value:(NSString *)value
{
    if (self = [super init]) {
        self.name = name;
        self.value = value;
    }
    return  self;
    
}

@end
