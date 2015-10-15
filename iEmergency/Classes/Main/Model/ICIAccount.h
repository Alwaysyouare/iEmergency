//
//  ICIAccount.h
//  iEmergency
//
//  Created by ICI on 15-8-5.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICIBaseReponse.h"


//PuId的存储Key
#define KEYFORPUID @"KeyICIPuId"
#define KEYFORACCESSID @"KeyICIAccessId"
#define KEYFORPWD @"KeyICIPwd"

@interface ICIAccount : ICIBaseReponse

@property (nonatomic,copy) NSString *PuId;
@property (nonatomic,copy) NSString *AccessId;
@property (nonatomic,copy) NSString *Pwd;

/**
 *  存储账号
 *
 *  @param account 账号信息
 */
+ (void)save:(ICIAccount *)account;

/**
 *  读取账号
 *
 *  @return 账号信息
 */
+ (ICIAccount *) account;

/**
 *  使用字典生成
 *
 *  @param dict 字典
 *
 *  @return 对象类型
 */
+ (instancetype) accountWithDict:(NSDictionary *)dict;

@end
