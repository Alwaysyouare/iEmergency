//
//  ICIMoreCell.m
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreCell.h"
#import "ICIMoreItem.h"
#import "ICIMoreArrowItem.h"
#import "ICIMoreSwitchItem.h"
#import "ICIMoreSegueItem.h"

@interface ICIMoreCell()
@property (nonatomic,strong) UISwitch *switchBtn;

@end

@implementation ICIMoreCell


- (UISwitch *)switchBtn
{
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
        //监听改变
        [_switchBtn addTarget:self action:@selector(switchBtnChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (void)switchBtnChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchBtn.isOn forKey:self.item.title];
    [defaults synchronize];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"Cell";
    ICIMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ICIMoreCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setItem:(ICIMoreItem *)item
{
    _item = item;
    
    self.textLabel.text = _item.title;
    self.imageView.image = [UIImage imageNamed:_item.icon];
    
    //设置辅助视图
    if ([_item isKindOfClass:[ICIMoreArrowItem class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([_item isKindOfClass:[ICIMoreSegueItem class]])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.detailTextLabel.text = _item.subTitle;
    }
    else if([_item isKindOfClass:[ICIMoreSwitchItem class]])
    {
        self.accessoryView = self.switchBtn;
        //恢复状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchBtn.on = [defaults boolForKey:self.item.title];
        //设置没有选中状态
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView = nil;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
