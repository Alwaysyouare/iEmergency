//
//  ICIXmppManager.m
//  iEmergency
//
//  Created by ICI on 15-8-19.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIXmppManager.h"
#import "ICINewPushMessage.h"
#import "GDataXmlNode.h"
#import "ICIMessageObject.h"

#define PUSHSERVER @"10.100.0.16"
#define XMPPUSERID @"XMPPUSERID"
#define DEFAULTPWD @"1234567890"

static ICIXmppManager *singleInstance = nil;

@implementation ICIXmppManager
@synthesize xmppStream = _xmppStream;
BOOL bTryAgain = NO;

//返回单实例
+(id)sharedXmppConnectInstance
{
    if(singleInstance==nil)
    {
        @synchronized(self)
        {
            if(singleInstance==nil)
            {
                singleInstance=[[[self class] alloc] init];
                
            }
        }
    }
    return singleInstance;
}

//防止创建多个实例
+(id)allocWithZone:(NSZone *)zone;
{
    if(singleInstance==nil)
    {
        singleInstance=[super allocWithZone:zone];
    }
    return singleInstance;
}

//防止创建多个实例
+(id)copyWithZone:(NSZone *)zone
{
    //NSLog(@"run into EyesXmppConncet's copyWithZone");
    return singleInstance;
}

-(id)init
{
    if (self = [super init]) {
    }
    return self;
}


-(XMPPStream*)xmppStream
{
    if (_xmppStream == nil) {
        //初始化XMPPStream
        _xmppStream = [[XMPPStream alloc] init];
        //原来是这样写的，有警告
        //      [_xmppStream addDelegate:self delegateQueue:dispatch_get_current_queue()];
        [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _xmppStream;
}


-(void)goOnline
{
    //发送上线状态
    XMPPPresence *pressence = [XMPPPresence presence];
    [self.xmppStream sendElement:pressence];
    //登记推送服务ID
    ICINewPushMessage *msg = [[ICINewPushMessage alloc] init];
    msg.title = kTitleForBindPushUser;
    msg.body = self.userId;
    //发送全局通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kICINewPushInfoNotication object:msg];
}

-(void)goOffline
{
    //发送下线状态unavailable
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [self.xmppStream sendElement:presence];
}

-(BOOL)connect
{
    //Vindor标示符
    UIDevice *device = [UIDevice currentDevice];
    NSUUID *deviceId = [device identifierForVendor];
    NSString *strDeviceId = [deviceId UUIDString];
    
    self.password = DEFAULTPWD;
    self.userId = [strDeviceId lowercaseString];
    //    self.userId = @"57ea4bba-4607-4d96-bc17-333a1f5f5ee6";
    
    if ([self.xmppStream isConnected]) {
        return YES;
    }
    if (self.userId == nil || self.password == nil) {
        return NO;
    }
    //    NSString *jid = [[NSString alloc] initWithFormat:@"%@@%@", self.userId, self.server];
    //    [self.xmppStream setMyJID:[XMPPJID jidWithString:jid]];
    XMPPJID *xmppJid = [XMPPJID jidWithUser:self.userId domain:PUSHSERVER resource:@"AndroidpnClient"];
    [self.xmppStream setMyJID:xmppJid];
    [self.xmppStream setHostName:PUSHSERVER];
    [self.xmppStream setHostPort:5222];
    
    NSError *error = nil;
    if (![self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        ICILog(@"con't connect: %@", PUSHSERVER);
        ICILog(@"error: %@",[error localizedDescription]);
        return NO;
    }
    return YES;
}

-(void)disconnect
{
    [self goOffline];
    [self.xmppStream disconnect];
}

//已连接服务器
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    self.isOpen = YES;
    NSError *error = nil;
    if ([self.userId isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:XMPPUSERID]]) {
        //验证
        id <XMPPSASLAuthentication> someAuth = nil;
        someAuth = [[XMPPDeprecatedDigestAuthentication alloc] initWithStream:self.xmppStream password:self.password];
        if ([self.xmppStream authenticate:someAuth error:&error]) {
            ICILog(@"authenticated.");
        }
        else
        {
            ICILog(@"authenticate fail.");
        }
    }
    else
    {
        //注册
        if ([self.xmppStream registerWithPassword:self.password error:&error]) {
            NSLog(@"registered.");
        }
    }
}

//注册成功
-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    ICILog(@"register ok");
    NSError *error = nil;
    //保存用户名
    [[NSUserDefaults standardUserDefaults] setObject:self.userId forKey:XMPPUSERID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //验证
    id <XMPPSASLAuthentication> someAuth = nil;
    someAuth = [[XMPPDeprecatedDigestAuthentication alloc] initWithStream:self.xmppStream password:self.password];
    if ([self.xmppStream authenticate:someAuth error:&error]) {
        ICILog(@"authenticated.");
    }
    else
    {
        ICILog(@"authenticate fail.");
    }
}

//注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    ICILog(@"register fail");
}

//验证通过
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    ICILog(@"Authenticate ok.");
    [self goOnline];
}

//验证失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    ICILog(@"Authenticate fail");
    if (bTryAgain == NO) {
        bTryAgain = YES;
        //注册
        NSError *error = nil;
        if ([self.xmppStream registerWithPassword:self.password error:&error]) {
            NSLog(@"registered again.");
        }
    }
}

-(void)xmppStream:(XMPPStream*)sender didReceiveMessage:(XMPPMessage *)message
{
    ICILog(@"message = %@", message);
    
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:msg forKey:@"msg"];
    [dict setObject:from forKey:@"sender"];
    
}
//收到消息
-(BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    //NSLog(@"IQ = %@", iq);
    
    NSXMLElement *notification = iq.childElement;
    NSString *strName = notification.name;
    NSString *strTitle;
    NSString *strMessage;
    
    //解析出title和message
    if ([@"notification" isEqualToString:strName]) {
        NSArray *items = [notification children];
        for (NSXMLElement *item in items) {
            if([@"title" isEqualToString:[item name]])
                strTitle = [item stringValue];
            if ([@"message" isEqualToString:[item name]])
                strMessage = [item stringValue];
        }
    }
    ICINewPushMessage *msg = [[ICINewPushMessage alloc] init];
    msg.title = strTitle;
    msg.body = strMessage;
    if ([strTitle isEqualToString:kTitleForNewMessage]) {
        //新的消息推送
        ICIMessageObject *newMsg = [[ICIMessageObject alloc] init];
        //将字符串加载到XMl中
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:strMessage options:0 error:nil];
        //GDataXMLElement *root = doc.rootElement;
        GDataXMLElement *msgCuId = [doc nodesForXPath:@"//Message//Parameters//CuId" error:nil][0];
        GDataXMLElement *msgCuName = [doc nodesForXPath:@"//Message//Parameters//CuName" error:nil][0];
        GDataXMLElement *msgPuId = [doc nodesForXPath:@"//Message//Parameters//PuId" error:nil][0];
        GDataXMLElement *msgContent = [doc nodesForXPath:@"//Message//Parameters//MessageContent" error:nil][0];
        newMsg.messageFrom = msgCuName.stringValue;
        newMsg.messageTo = msgPuId.stringValue;
        newMsg.messageContent = msgContent.stringValue;
        newMsg.messageFrom = msgCuId.stringValue;
        newMsg.messageType = [NSNumber numberWithInteger:MessageTypeRec];
        newMsg.messageUnread = [NSNumber numberWithInteger:MessageUnread];
        newMsg.messageDate = [NSDate date];
        [ICIMessageObject save:newMsg];
        
    }
    //发送全局通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kICINewPushInfoNotication object:msg];
    
    return NO;
}



@end
