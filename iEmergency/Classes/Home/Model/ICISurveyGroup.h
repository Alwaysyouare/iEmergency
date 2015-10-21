//
//  ICISurveyGroup.h
//  iEmergency
//
//  Created by alwaysyouare on 15/10/21.
//  Copyright © 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICISurveyGroup : NSObject

/**
 *  分组的头标题
 */
@property (nonatomic , strong) NSString* headerTitle;

/**
 *  分组属性数组，每一项为ICISurveyItem对象
 */
@property (nonatomic , strong) NSArray* items;

/**
 *  使用字典初始化对象
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  使用字典初始化对象
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end
