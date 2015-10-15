//
//  ICISurveyCell.m
//  iEmergency
//
//  Created by ICI on 15-8-31.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICISurveyCell.h"
#import "ICISurveyItem.h"

@implementation ICISurveyCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSurveyItem:(ICISurveyItem *)surveyItem
{
    _surveyItem = surveyItem;
    _name.text = surveyItem.name;
    _value.text = surveyItem.value;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
