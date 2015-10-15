//
//  EventPopView.h
//  iEmergency
//
//  Created by ICI on 15-8-14.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventPopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *name;

+ (EventPopView *)initWithFrame:(CGRect)frame;
+ (EventPopView *)instanceEventPopView;
@end
