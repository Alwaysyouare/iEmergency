//
//  ICICollectionCell.m
//  iEmergency
//
//  Created by ICI on 15-7-29.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICICollectionCell.h"
#import "ICICollectionItem.h"

@implementation ICICollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    self.iconView.layer.cornerRadius = 8;
    self.iconView.clipsToBounds = YES;
}

- (void)setItem:(ICICollectionItem *)item
{
    _item = item;
    self.iconView.image = [UIImage imageNamed:self.item.icon];
    self.titleLabel.text = self.item.title;
    
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
