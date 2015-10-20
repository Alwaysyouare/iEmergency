//
//  ICISurveyTable.h
//  iEmergency
//
//  Created by alwaysyouare on 15/10/19.
//  Copyright © 2015年 ICI. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  调查表对象
 */
@interface ICISurveyTable : NSObject

/**
 *  调查表名称
 */
@property(nonatomic,copy)NSString *tableName;

/**
 *  调查表属性列表。每一项为属性-值的字典
 */
@property(nonatomic,strong)NSArray *attributesList;

/**
 *  附件列表，每一项为ICIAttachmentItem的对象
 */
@property(nonatomic,strong)NSMutableArray *attachmentList;

@end
