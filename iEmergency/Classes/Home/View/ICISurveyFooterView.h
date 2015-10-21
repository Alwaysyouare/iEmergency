//
//  ICISurveyFooterView.h
//  iEmergency
//
//  Created by ICI on 15-9-15.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,ICISurveyFooterClick)
{
    ICISurveyFooterClickAddAttach,
    ICISurveyFooterClickCancel,
    ICISurveyFooterClickSave,
    ICISurveyFooterClickReport
};

/**
 * 操作栏按钮点击事件委托
 */
@protocol ICISurveyFooterViewDelegate <NSObject>

@optional

- (void)ICISurveyViewDidClickBtn:(ICISurveyFooterClick)btnType;

@end

/**
 *  调查表编辑页面底部操作栏
 */
@interface ICISurveyFooterView : UIView
+ (instancetype)footerView;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnReport;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UILabel *labelAttachCount;

@property (weak, nonatomic) id<ICISurveyFooterViewDelegate> delegate;
- (IBAction)onSave:(id)sender;
- (IBAction)onReport:(id)sender;
- (IBAction)onCancel:(id)sender;
- (IBAction)onAddAttach:(id)sender;

@end
