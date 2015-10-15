//
//  ICISurveyFooterView.h
//  iEmergency
//
//  Created by ICI on 15-9-15.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICISurveyFooterView : UIView
+ (instancetype)footerView;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnReport;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@end
