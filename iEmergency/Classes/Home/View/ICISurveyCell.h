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

/**
 *  Cell点击委托
 */
@protocol ICISurveyCellDelegate <NSObject>

@optional
- (void)ICISurveyCellClick;

@end

@interface ICISurveyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextField *value;
@property (weak, nonatomic) IBOutlet UIButton *location;

@property (nonatomic , weak) id<ICISurveyCellDelegate> delegate;
- (IBAction)onLocation:(id)sender;

@property (nonatomic,copy) ICISurveyItem *surveyItem;
@end
