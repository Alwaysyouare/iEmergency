//
//  ICIHttpTool.h
//  iEmergency
//
//  Created by ICI on 15-8-5.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

//网络请求地址
#define HOSTSERVERURL @"http://10.100.0.16:8100/monitoring/service4pu"
#define HOSTSERVERURLFORCU @"http://10.100.0.16:8100/monitoring_dzj/service4cu"
#define HOSTSERVERURLFORPU @"http://10.100.0.16:8100/monitoring_dzj/service4pu"

#define METHORD_LOGIN @"PU_SetOnline"
#define METHORD_HEART_BEAT @"PU_SetTick"
#define METHORD_LOGIN_OUT @"PU_SetOffline"
#define METHORD_SET_PUSHREGISTER @"PU_SetPushRegister"

#define METHORD_CU_QUERY_DZMIDLIST @"CU_QueryEmergencyDzMidList"

#define RES_SUCCESS @"0"

@interface ICIHttpTool : NSObject

/**
 *  简单的Post请求
 *
 *  @param method  请求方法名
 *  @param params  请求参数模型。不能嵌套的模型，可以容易转化成字典。
 *  @param success 成功结果处理
 *  @param failure 请求失败处理
 */
+(void)post:(NSString *)method params:(id)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  业务相关的Post请求
 *
 *  @param method  请求方法名
 *  @param params  请求参数模型。不能嵌套的模型，可以容易转化成字典。
 *  @param success 成功结果处理
 *  @param failure 请求失败处理
 */
+(void)postForCu:(NSString *)method params:(id)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;


/**
 *  提交调查表到服务器
 *
 *  @param surveyTable <#surveyTable description#>
 *  @param success     <#success description#>
 *  @param failure     <#failure description#>
 */
+ (void)postSurveyTable:(id)surveyTable success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

@end
