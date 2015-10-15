//
//  ICIEventCell.h
//  iEmergency
//
//  Created by ICI on 15-8-11.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICIMoreEvents;

#define EventsCellID @"EventsCell"

@interface ICIEventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *EventName;
@property (weak, nonatomic) IBOutlet UILabel *EventTime;
@property (weak, nonatomic) IBOutlet UILabel *EventLevel;
@property (nonatomic,copy) ICIMoreEvents *event;

@end
