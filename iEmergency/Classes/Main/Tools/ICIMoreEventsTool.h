//
//  ICIMoreEventsTool.h
//  iEmergency
//
//  Created by ICI on 15-8-13.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ICIMoreEvents;
@interface ICIMoreEventsTool : NSObject

+ (void)save:(ICIMoreEvents *)event;
+ (ICIMoreEvents *)event;
@end
