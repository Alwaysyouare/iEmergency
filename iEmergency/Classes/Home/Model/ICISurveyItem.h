//
//  ICISurveyItem.h
//  iEmergency
//
//  Created by ICI on 15-8-31.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICISurveyItem : NSObject
/**
 *  item的标题
 */
@property (nonatomic,copy) NSString *name;
/**
 *  item的值。对应文本框的值
 */
@property (nonatomic,copy) NSString *value;
/**
 *  初始化item
 *
 *  @param name  标题名称
 *  @param value 初始化值
 *
 *  @return item
 */
- (instancetype)initWithName:(NSString *)name value:(NSString *)value;
@end
