//
//  ICIAppDelegate.h
//  iEmergency
//
//  Created by ICI on 15-7-27.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface ICIAppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    /**
     *  BaiduMap
     */
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@end

