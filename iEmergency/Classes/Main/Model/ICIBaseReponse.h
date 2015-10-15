//
//  ICIBaseReponse.h
//  iEmergency
//
//  Created by ICI on 15-8-6.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICIBaseReponse : NSObject

/**
 *  结果代码。0代表成功，其他代表失败
 */
@property (nonatomic,copy) NSString *ResultCode;

/**
 *  结果描述
 */
@property (nonatomic,copy) NSString *ResultMsg;
@end
