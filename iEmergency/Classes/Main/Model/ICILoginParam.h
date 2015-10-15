//
//  ICILoginParam.h
//  iEmergency
//
//  Created by ICI on 15-8-6.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICILoginParam : NSObject
/**
 *  设备ID
 */
@property (nonatomic,copy) NSString *PuId;
/**
 *  登录账户
 */
@property (nonatomic,copy) NSString *Password;

/**
 *  设备唯一标示
 */
@property (nonatomic,copy) NSString *DeviceImei;

@end
