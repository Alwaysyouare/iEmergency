//
//  ICICollectionCell.h
//  iEmergency
//
//  Created by ICI on 15-7-29.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICICollectionItem;

@interface ICICollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconNew;
@property (nonatomic,copy) ICICollectionItem *item;

@end
