//
//  ICIXmppManager.h
//  iEmergency
//
//  Created by ICI on 15-8-19.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"

@interface ICIXmppManager : NSObject <XMPPStreamDelegate>

@property (nonatomic,readonly) XMPPStream *xmppStream;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *password;
@property (nonatomic)BOOL isOpen;

+(id)sharedXmppConnectInstance;
-(void)goOnline;
-(void)goOffline;
-(BOOL)connect;
-(void)disconnect;
@end
