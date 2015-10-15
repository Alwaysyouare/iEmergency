//
//  ICIHttpTool.m
//  iEmergency
//
//  Created by ICI on 15-8-5.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIHttpTool.h"
#import "AFHTTPRequestOperationManager.h"
#import "GDataXmlNode.h"
#import "MJExtension.h"
#import "ICIAccount.h"
#import "ICIMoreEvents.h"

@implementation ICIHttpTool

/**
 *  post请求
 *
 *  @param method  请求方法名
 *  @param params  请求实体。
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)post:(NSString *)method params:(NSObject *)params success:(void (^)(id))success failure:(void (^)(NSError *error))failure
{
    //初始化AFN
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //设置response处理为不处理。否则按json格式处理返回结果，会出错
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置接受的类型
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:HOSTSERVERURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    //根据名称构造消息体
    NSString *strBody=@"";
    strBody = [strBody stringByAppendingFormat:@"<Message Version='1.0' Type='%@'>",method];
    
    //模型转换成字典。然后取出所有的Key来填充Body
    NSArray *paramsArray = [params.keyValues allKeys];
    
    for (int i=0; i < paramsArray.count; i++) {
        NSString *strKey = [paramsArray objectAtIndex:i];
        NSString *strValue = [params.keyValues objectForKey:strKey];
        strBody = [strBody stringByAppendingFormat:@"<%@>%@</%@>",strKey,strValue,strKey];
    }
    strBody = [strBody stringByAppendingString:@"</Message>"];
    
    [request setHTTPBody:[strBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperation *operation = [mgr HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //将返回结果转化成字符串
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        ICILog(@"%@",result);
        
        //将字符串加载到XMl中
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:result options:0 error:nil];
        GDataXMLElement *root = doc.rootElement;
        
        //解析方法名称。是请求方法名加_RSP
        NSString *responseMethodName = [[root attributeForName:@"Type"] stringValue];
        //去掉后缀_RSP
        NSString *methodName = [responseMethodName substringWithRange:NSMakeRange(0, responseMethodName.length - 4)];
        
        
        //根据方法名，将xml解析成不同的实体，然后返回
        if ([methodName isEqualToString:METHORD_LOGIN]) {
            //登录请求
            ICIAccount *account = [[ICIAccount alloc] init];
            GDataXMLElement *resultEle = [root elementsForName:@"Result"][0];
            account.ResultCode =[[resultEle attributeForName:@"Code"] stringValue];
            account.ResultMsg = [[root elementsForName:@"ResultMsg"][0] stringValue];
            account.AccessId = [[root elementsForName:@"AccessId"][0] stringValue];
            if (success) {
                success(account);
            }
           
        }else if ([methodName isEqualToString:METHORD_LOGIN_OUT])
        {
            ICIBaseReponse *baseResponse = [[ICIBaseReponse alloc] init];
            GDataXMLElement *resultEle = [root elementsForName:@"Result"][0];
            baseResponse.ResultCode =[[resultEle attributeForName:@"Code"] stringValue];
            if (success) {
                success(baseResponse);
            }

        }
        else{
            if (success) {
                success(responseObject);
            }
        }
                
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            ICILog(@"Post for Common error:%@",error.localizedDescription);
        }
    }];
    [mgr.operationQueue addOperation:operation];

}

/**
 *  post请求
 *
 *  @param method  请求方法名
 *  @param params  请求实体。
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)postForCu:(NSString *)method params:(NSObject *)params success:(void (^)(id))success failure:(void (^)(NSError *error))failure
{
    //初始化AFN
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //设置response处理为不处理。否则按json格式处理返回结果，会出错
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置接受的类型
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:HOSTSERVERURLFORCU]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    //根据名称构造消息体
    NSString *strBody=@"";
    strBody = [strBody stringByAppendingString:@"<Message Version='1.0'>"];
    strBody = [strBody stringByAppendingFormat:@"<Header MessageType='%@' SessionId='1' SequenceNumber='1' Flag='0' />",method];
    strBody = [strBody stringByAppendingString:@"<Parameters>"];
    //模型转换成字典。然后取出所有的Key来填充Body
    NSArray *paramsArray = [params.keyValues allKeys];
    
    for (int i=0; i < paramsArray.count; i++) {
        NSString *strKey = [paramsArray objectAtIndex:i];
        NSString *strValue = [params.keyValues objectForKey:strKey];
        strBody = [strBody stringByAppendingFormat:@"<%@>%@</%@>",strKey,strValue,strKey];
    }
    strBody = [strBody stringByAppendingString:@"</Parameters>"];
    strBody = [strBody stringByAppendingString:@"</Message>"];
    
    [request setHTTPBody:[strBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperation *operation = [mgr HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //将返回结果转化成字符串
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        ICILog(@"%@",result);
        
        //将字符串加载到XMl中
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:result options:0 error:nil];
        GDataXMLElement *root = doc.rootElement;
        GDataXMLElement *header = [root elementsForName:@"Header"][0];
        
        //解析方法名称。是请求方法名加_RSP
        NSString *responseMethodName = [[header attributeForName:@"MessageType"] stringValue];
        //去掉后缀_RSP
        NSString *methodName = [responseMethodName substringWithRange:NSMakeRange(0, responseMethodName.length - 4)];
        
        
        //根据方法名，将xml解析成不同的实体，然后返回
        if ([methodName isEqualToString:METHORD_CU_QUERY_DZMIDLIST]) {
            //事件列表
            NSMutableArray *arrayEvents = [NSMutableArray array];
            GDataXMLElement *resultEle = [root elementsForName:@"Result"][0];
            NSString *resultCode =[[resultEle attributeForName:@"Code"] stringValue];
            if ([resultCode isEqualToString:RES_SUCCESS]) {
                NSArray *dzInfoArray = [doc nodesForXPath:@"//Message//Parameters//ListData//DzInfo" error:nil];
                for (GDataXMLElement *dzInfo in dzInfoArray) {
                    ICIMoreEvents *event = [[ICIMoreEvents alloc] init];
                    event.DzEventId = [[dzInfo attributeForName:@"DzEventId"] stringValue];
                    event.DzEventName = [[dzInfo attributeForName:@"DzEventName"] stringValue];
                    event.DzStartTime = [[dzInfo attributeForName:@"DzStartTime"] stringValue];
                    event.DzEndTime = [[dzInfo attributeForName:@"DzEndTime"] stringValue];
                    event.DzLat = [[dzInfo attributeForName:@"DzLat"] stringValue];
                    event.DzLon = [[dzInfo attributeForName:@"DzLon"] stringValue];
                    event.DzPos = [[dzInfo attributeForName:@"DzPos"] stringValue];
                    event.DzDepth = [[dzInfo attributeForName:@"DzDepth"] stringValue];
                    event.DzLevel = [[dzInfo attributeForName:@"DzLevel"] stringValue];
                    [arrayEvents addObject:event];
                }
            }
           
            if (success) {
                success(arrayEvents);
            }
            
        }
        else{
            if (success) {
                success(responseObject);
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
             ICILog(@"Post for CU error:%@",error.localizedDescription);
        }
    }];
    [mgr.operationQueue addOperation:operation];
    
}


@end
