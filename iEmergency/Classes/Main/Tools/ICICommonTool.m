//
//  ICICommonTool.m
//  iEmergency
//
//  Created by ICI on 15-8-14.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICICommonTool.h"

@implementation ICICommonTool

/**
 *  根据View生成Image
 *
 *  @param view view description
 *
 *  @return     image对象
 */
+ (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}

// 获取当前处于activity状态的view controller
+ (UIViewController *)activityViewController
{
    UIViewController *appRootVc = [UIApplication sharedApplication].keyWindow.rootViewController ;
    UIViewController *topVC = appRootVc;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
@end
