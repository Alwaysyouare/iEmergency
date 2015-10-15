//
//  ICIMessageObject.h
//  iEmergency
//
//  Created by ICI on 15-8-20.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMESSAGE_TYPE @"messageType"
#define kMESSAGE_UNREAD @"messageUnread"
#define kMESSAGE_FROM @"messageFrom"
#define kMESSAGE_TO @"messageTo"
#define kMESSAGE_CONTENT @"messageContent"
#define kMESSAGE_DATE @"messageDate"
#define kMESSAGE_ID @"messageId"

typedef NS_ENUM(NSInteger, MessageType)
{
    MessageTypeSend = 1,
    MessageTypeRec = 2
};

typedef NS_ENUM(NSInteger, MessageReadState)
{
    MessageUnread = 1,
    MessageRead = 2
};

@interface ICIMessageObject : NSObject
@property (nonatomic,copy) NSString *messageFrom;
@property (nonatomic,copy) NSString *messageTo;
@property (nonatomic,copy) NSString *messageContent;
@property (nonatomic,copy) NSDate *messageDate;
/**
 *  消息类型 1.发送，2.接受
 */
@property (nonatomic,copy) NSNumber *messageType;
@property (nonatomic,copy) NSNumber *messageUnread;
@property (nonatomic,copy) NSNumber *messageId;

//将对象转换为字典
-(NSDictionary*)toDictionary;
+(ICIMessageObject*)messageFromDictionary:(NSDictionary*)aDic;

//数据库增删改查
+(BOOL)save:(ICIMessageObject*)aMessage;
+(NSMutableArray*)fetchMessageListWithUser:(NSString *)userId;
@end
