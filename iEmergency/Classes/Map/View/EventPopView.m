//
//  EventPopView.m
//  iEmergency
//
//  Created by ICI on 15-8-14.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "EventPopView.h"

@implementation EventPopView

+ (EventPopView *)initWithFrame:(CGRect)frame
{
    EventPopView *view = (EventPopView *)[[NSBundle mainBundle] loadNibNamed:@"EventPopView" owner:nil options:nil][0];
    view.frame = frame;
    return view;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (EventPopView *)instanceEventPopView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"EventPopView" owner:self options:nil];
    return [nibView objectAtIndex:0];
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
