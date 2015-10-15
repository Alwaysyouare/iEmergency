//
//  ICIMoreEventsParam.h
//  iEmergency
//
//  Created by ICI on 15-8-10.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICIMoreEventsParam : NSObject

/**
 *  事件ID
 */
@property (nonatomic,copy) NSString *Distance;

/**
 *  事件纬度
 */
@property (nonatomic,copy) NSString *DzLat;

/**
 *  事件经度
 */
@property (nonatomic,copy) NSString *DzLon;

/**
 *  事件等级
 */
@property (nonatomic,copy) NSString *DzLevel;

/**
 *  事件开始时间
 */
@property (nonatomic,copy) NSString *StartTime;

/**
 *  事件结束时间
 */
@property (nonatomic,copy) NSString *EndTime;

/**
 *  事件开始索引
 */
@property (nonatomic,assign) NSInteger FromIndex;

/**
 *  事件结束索引
 */
@property (nonatomic,assign) NSInteger EndIndex;

@end
