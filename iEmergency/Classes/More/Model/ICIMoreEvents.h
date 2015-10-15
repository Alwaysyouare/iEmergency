//
//  ICIMoreEvents.h
//  iEmergency
//
//  Created by ICI on 15-8-10.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICIMoreEvents : NSObject <NSCoding>

/**
 *  事件ID
 */
@property (nonatomic,copy) NSString *DzEventId;

/**
 *  事件名称
 */
@property (nonatomic,copy) NSString *DzEventName;

/**
 *  事件纬度
 */
@property (nonatomic,copy) NSString *DzLat;

/**
 *  事件经度
 */
@property (nonatomic,copy) NSString *DzLon;

/**
 *  事件位置
 */
@property (nonatomic,copy) NSString *DzPos;

/**
 *  事件等级
 */
@property (nonatomic,copy) NSString *DzLevel;

/**
 *  事件深度
 */
@property (nonatomic,copy) NSString *DzDepth;

/**
 *  事件开始时间
 */
@property (nonatomic,copy) NSString *DzStartTime;

/**
 *  事件结束时间
 */
@property (nonatomic,copy) NSString *DzEndTime;

@end
