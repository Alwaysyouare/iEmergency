//
//  ICIMoreEventsTool.m
//  iEmergency
//
//  Created by ICI on 15-8-13.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreEventsTool.h"

#define ICIEventFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"event.data"]

@implementation ICIMoreEventsTool

+ (void)save:(ICIMoreEvents *)event
{
    //归档
    [NSKeyedArchiver archiveRootObject:event toFile:ICIEventFilePath];
    
}

+ (ICIMoreEvents *)event
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:ICIEventFilePath];
}
@end
