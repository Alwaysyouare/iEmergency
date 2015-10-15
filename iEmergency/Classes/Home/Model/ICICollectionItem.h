//
//  ICICollectionItem.h
//  iEmergency
//
//  Created by ICI on 15-7-29.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICICollectionItem : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;
/**
 * 目标控制器
 */
@property (nonatomic, assign) Class destVC;

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVC;
@end
