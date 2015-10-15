//
//  ICIMoreItem.m
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreItem.h"

@implementation ICIMoreItem

//- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVC
//{
//    if (self = [super init]) {
//        self.icon = icon;
//        self.title = title;
//        self.destVC = destVC;
//    }
//    return  self;
//    
//}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title
{
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
    }
    return  self;
    
}
@end
