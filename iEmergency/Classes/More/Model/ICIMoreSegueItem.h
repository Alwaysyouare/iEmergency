//
//  ICIMoreSegueItem.h
//  iEmergency
//
//  Created by ICI on 15-7-30.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreItem.h"

@interface ICIMoreSegueItem : ICIMoreItem

/**
 * 跳转Segue的名称
 */
@property (nonatomic, copy) NSString *segueName;

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title segueName:(NSString *)segueName;

@end
