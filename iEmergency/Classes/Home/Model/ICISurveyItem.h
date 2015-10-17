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
 *  item对应的字段名称
 */
@property (nonatomic,copy) NSString *key;

/**
 *  item的值。对应文本框的值
 */
@property (nonatomic,copy) NSString *value;

/**
 *  value文本框对应的Tag值
 */
@property (nonatomic,assign) NSInteger nTag;

/**
 *  初始化item
 *
 *  @param name  标题名称
 *  @param value 初始化值
 *
 *  @return item
 */
- (instancetype)initWithName:(NSString *)name key:(NSString *)key value:(NSString *)value nTag:(NSInteger)nTag;
@end
