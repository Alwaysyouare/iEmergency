//
//  ICIMessageObject.m
//  iEmergency
//
//  Created by ICI on 15-8-20.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMessageObject.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
@implementation ICIMessageObject


+(ICIMessageObject*)messageFromDictionary:(NSDictionary*)aDic
{
    ICIMessageObject *msg=[[ICIMessageObject alloc]init];
    [msg setMessageFrom:[aDic objectForKey:kMESSAGE_FROM]];
    [msg setMessageTo:[aDic objectForKey:kMESSAGE_TO]];
    [msg setMessageContent:[aDic objectForKey:kMESSAGE_CONTENT]];
    [msg setMessageDate:[aDic objectForKey:kMESSAGE_DATE]];
    [msg setMessageUnread:[aDic objectForKey:kMESSAGE_UNREAD]];
    [msg setMessageDate:[aDic objectForKey:kMESSAGE_TYPE]];
    return  msg;
}


//将对象转换为字典
-(NSDictionary*)toDictionary
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_messageId,kMESSAGE_ID,_messageFrom,kMESSAGE_FROM,_messageTo,kMESSAGE_TO,_messageContent,kMESSAGE_TYPE,_messageDate,kMESSAGE_DATE,_messageType,kMESSAGE_TYPE,_messageUnread,kMESSAGE_UNREAD, nil];
    return dic;
    
}

//增删改查

+(BOOL)save:(ICIMessageObject*)aMessage
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    NSString *createStr=@"CREATE  TABLE  IF NOT EXISTS 'wcMessage' ('messageId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  UNIQUE , 'messageFrom' VARCHAR, 'messageTo' VARCHAR, 'messageContent' VARCHAR, 'messageDate' DATETIME,'messageType' INTEGER,'messageUnread' INTEGER)";
    
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    
    
    
    NSString *insertStr=@"INSERT INTO 'wcMessage' ('messageFrom','messageTo','messageContent','messageDate','messageType','messageUnread') VALUES (?,?,?,?,?,?)";
    worked = [db executeUpdate:insertStr,aMessage.messageFrom,aMessage.messageTo,aMessage.messageContent,aMessage.messageDate,aMessage.messageType,aMessage.messageUnread];
    FMDBQuickCheck(worked);
    
    
    
    [db close];
    //发送全局通知
//    [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPNewMsgNotifaction object:aMessage ];
//    [aMessage release];
    
    
    return worked;
}




//获取某联系人聊天记录
+(NSMutableArray*)fetchMessageListWithUser:(NSString *)userId
{
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    FMDatabase *db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return messageList;
    }
    
    NSString *queryString=@"select * from wcMessage where messageFrom=? or messageTo=? order by messageDate desc";
    
    FMResultSet *rs=[db executeQuery:queryString,userId,userId];
    while ([rs next]) {
        ICIMessageObject *message=[[ICIMessageObject alloc]init];
        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
        [message setMessageUnread:[rs objectForColumnName:kMESSAGE_UNREAD]];
        [ messageList addObject:message];
        
    }
    return  messageList;
    
}

@end
