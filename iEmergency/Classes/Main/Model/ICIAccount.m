//
//  ICIAccount.m
//  iEmergency
//
//  Created by ICI on 15-8-5.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIAccount.h"

@implementation ICIAccount

+ (instancetype) accountWithDict:(NSDictionary *)dict
{
    ICIAccount *account = [[self alloc] init];
    account.PuId = dict[@"PuId"];
    account.AccessId = dict[@"AccessId"];
    return account;
}


+ (ICIAccount *)account
{
    ICIAccount *account = [[self alloc] init];
    account.PuId =  [[NSUserDefaults standardUserDefaults] valueForKey:KEYFORPUID];
    account.AccessId=  [[NSUserDefaults standardUserDefaults] valueForKey:KEYFORACCESSID];
    account.Pwd=  [[NSUserDefaults standardUserDefaults] valueForKey:KEYFORPWD];
    return account;
}

+ (void)save:(ICIAccount *)account
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:account.PuId forKey:KEYFORPUID];
    [defaults setValue:account.AccessId forKey:KEYFORACCESSID];
    [defaults setValue:account.Pwd forKey:KEYFORPWD];
    [defaults synchronize];
}

@end
