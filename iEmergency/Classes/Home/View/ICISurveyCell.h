//
//  ICISurveyCell.h
//  iEmergency
//
//  Created by ICI on 15-8-31.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICISurveyItem;

#define SurveyBasicCellID @"SurveyBasicCell"

@interface ICISurveyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextField *value;
@property (nonatomic,copy) ICISurveyItem *surveyItem;
@end
