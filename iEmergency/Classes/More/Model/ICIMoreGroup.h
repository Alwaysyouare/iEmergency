//
//  ICIMoreGroup.h
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICIMoreGroup : NSObject

/**
 * 头部标题
 */
@property (nonatomic, copy) NSString *headerTitle;

/**
 * 底部标题
 */
@property (nonatomic, copy) NSString *footerTitle;

/**
 * 当前分组中所有行的数据(保存的是ICIMoreItem模型)
 */
@property (nonatomic, copy) NSArray *items;



@end
