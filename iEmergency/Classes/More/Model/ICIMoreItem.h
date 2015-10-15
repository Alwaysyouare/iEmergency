//
//  ICIMoreItem.h
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^optionBlock)();
@interface ICIMoreItem : NSObject

/**
 * 图标
 */
@property (nonatomic, copy) NSString *icon;

/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 * 子标题
 */
@property (nonatomic, copy) NSString *subTitle;


@property (nonatomic, copy) optionBlock option;

/**
 * 目标控制器
 */
//@property (nonatomic, assign) Class destVC;

//- (instancetype) initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVC;

- (instancetype) initWithIcon:(NSString *)icon title:(NSString *)title;

@end
