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
 *  条目的类型。0：文本；1.数字；2.小数；
 */
@property (nonatomic,assign) NSInteger nType;


/**
 *  初始化条目
 *
 *  @param name  标签名
 *  @param key   条目对应的关键字
 *  @param value 关键字对应的值
 *  @param nTag  值控件的Tag属性值
 *  @param nType 条目的类型.0：文本；1.数字；2.小数；
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithName:(NSString *)name key:(NSString *)key value:(NSString *)value nTag:(NSInteger)nTag nType:(NSInteger)nType;

/**
 *  使用字典初始化条目
 *
 *  @param dict 字典
 *
 *  @return 条目类型
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  使用字典初始化对象
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)itemWithDict:(NSDictionary *)dict;
@end
