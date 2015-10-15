//
//  ICINewPushMessage.h
//  iEmergency
//
//  Created by ICI on 15-8-19.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kICINewPushInfoNotication @"ICINewPushInfoNotication"

#define kTitleForBindPushUser @"NoticationForBindPushUser"

#define kTitleForNewMessage @"PushMessageInfo"

#define kTitleForReadMessage @"HasReadMessage"

@interface ICINewPushMessage : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *body;
@end
