//
//  ICIMoreCell.h
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICIMoreItem;

@interface ICIMoreCell : UITableViewCell

@property (nonatomic,strong) ICIMoreItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
