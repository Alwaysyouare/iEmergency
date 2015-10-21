//
//  ICISurveyGroup.m
//  iEmergency
//
//  Created by alwaysyouare on 15/10/21.
//  Copyright © 2015年 ICI. All rights reserved.
//

#import "ICISurveyGroup.h"
#import "ICISurveyItem.h"

@implementation ICISurveyGroup

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.headerTitle = [dict valueForKey:@"headerTitle"];
        NSArray *itemsArray = [dict valueForKey:@"items"];
        if (itemsArray != nil) {
            NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:itemsArray.count];
            for (NSDictionary *dictAttr in itemsArray) {
                ICISurveyItem *surveyItem = [ICISurveyItem itemWithDict:dictAttr];
                [attributesArray addObject:surveyItem];
            }
            self.items = attributesArray;
        }

    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
