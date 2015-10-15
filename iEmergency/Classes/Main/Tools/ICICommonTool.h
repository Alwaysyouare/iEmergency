//
//  ICICommonTool.h
//  iEmergency
//
//  Created by ICI on 15-8-14.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  工具类
 */
@interface ICICommonTool : NSObject

/**
 *  获取View的图片
 *
 *  @param view view description
 *
 *  @return
 */
+ (UIImage *)imageFromView:(UIView *)view;

/**
 *  获取当前活动的VC
 *
 *  @return return value description
 */
+ (UIViewController *)activityViewController;

@end
