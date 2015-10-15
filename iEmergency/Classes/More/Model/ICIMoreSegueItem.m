//
//  ICIMoreSegueItem.m
//  iEmergency
//
//  Created by ICI on 15-7-30.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreSegueItem.h"

@implementation ICIMoreSegueItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title segueName:(NSString *)segueName
{
    if (self = [super initWithIcon:icon title:title]) {
        self.segueName = segueName;
    }
    return  self;
    
}

@end
