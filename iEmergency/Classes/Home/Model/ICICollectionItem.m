//
//  ICICollectionItem.m
//  iEmergency
//
//  Created by ICI on 15-7-29.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICICollectionItem.h"

@implementation ICICollectionItem


- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVC
{
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
        self.destVC = destVC;
    }
    return  self;
    
}

@end
