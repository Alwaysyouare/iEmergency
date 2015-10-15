//
//  ICIMoreArrowItem.h
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreItem.h"

@interface ICIMoreArrowItem : ICIMoreItem
/**
 * 目标控制器
 */
@property (nonatomic, assign) Class destVC;

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVC;
@end
