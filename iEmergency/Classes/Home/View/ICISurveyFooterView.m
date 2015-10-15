//
//  ICISurveyFooterView.m
//  iEmergency
//
//  Created by ICI on 15-9-15.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICISurveyFooterView.h"

@implementation ICISurveyFooterView


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
            }
    return self;
}

- (void)awakeFromNib
{
    [self.btnSave.layer setCornerRadius:6.0];
    [self.btnReport.layer setCornerRadius:6.0];
    [self.btnCancel.layer setCornerRadius:6.0];

}

+ (instancetype)footerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ICISurveyFooter" owner:nil options:nil][0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
