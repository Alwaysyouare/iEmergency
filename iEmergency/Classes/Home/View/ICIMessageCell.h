//
//  ICIMessageCell.h
//  iEmergency
//
//  Created by ICI on 15-8-21.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ICIMessageCellID @"ICIMessageCell"
@class ICIMessageObject;

@interface ICIMessageCell : UITableViewCell
@property (nonatomic,copy) ICIMessageObject *message;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
