//
//  ICIEventCell.m
//  iEmergency
//
//  Created by ICI on 15-8-11.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIEventCell.h"
#import "ICIMoreEvents.h"
@implementation ICIEventCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setEvent:(ICIMoreEvents *)event
{
    _event = event;
    _EventName.text = event.DzEventName;
    _EventTime.text = event.DzStartTime;
    _EventLevel.text = [event.DzLevel stringByAppendingString:@"级"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
