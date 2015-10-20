//
//  ICIAppDelegate.m
//  iEmergency
//
//  Created by ICI on 15-7-27.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIAppDelegate.h"
#import "ICITabBarControllerViewController.h"
#import "ICILoginController.h"
#import "ICINewFeatureViewController.h"
#import <Bugtags/Bugtags.h>

@implementation ICIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //启动日志崩溃抓取
//    [Bugtags startWithAppKey:@"cd7d879740803e0c0d3cd5c428a52ae1" invocationEvent:BTGInvocationEventNone];
    //启动百度地图
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"VMZ4wjwmiaL3Uf2lvWRSijFq" generalDelegate:self];
    if (!ret) {
        ICILog(@"BaiduMap Manager start failed");
    }
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //Foundation CoreFoundation 使用 __bridge进行转换
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    //取出存储的旧版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    //获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    if ([currentVersion isEqualToString:lastVersion]) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ICILoginController *login = [story instantiateViewControllerWithIdentifier:@"login"];
        self.window.rootViewController = login;
    }
    else{
        self.window.rootViewController = [[ICINewFeatureViewController alloc] init];
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        ICILog(@"联网成功");
    }
    else{
        ICILog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        ICILog(@"授权成功");
    }
    else {
        ICILog(@"onGetPermissionState %d",iError);
    }
}


@end
