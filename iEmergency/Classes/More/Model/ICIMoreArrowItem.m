//
//  ICIMoreArrowItem.m
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreArrowItem.h"

@implementation ICIMoreArrowItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVC
{
    if (self = [super initWithIcon:icon title:title]) {
        self.destVC = destVC;
    }
    return  self;

}

@end
