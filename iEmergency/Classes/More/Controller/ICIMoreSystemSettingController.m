//
//  ICIMoreSystemSettingController.m
//  iEmergency
//
//  Created by ICI on 15-7-30.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreSystemSettingController.h"
#import "ICIMoreItem.h"
#import "ICIMoreGroup.h"
#import "ICIMoreCell.h"
#import "ICIMoreArrowItem.h"
#import "ICIMoreSwitchItem.h"
#import "ICIMoreSegueItem.h"

@interface ICIMoreSystemSettingController ()
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation ICIMoreSystemSettingController

- (NSMutableArray *)datas
{
    if (_datas == nil) {
        ICIMoreItem *item00 = [[ICIMoreSegueItem alloc] initWithIcon:nil title:@"视频直播质量" segueName:nil];
        item00.subTitle = @"清晰";
        ICIMoreItem *item01 = [[ICIMoreSwitchItem alloc] initWithIcon:nil title:@"声音同步传输"];
        ICIMoreItem *item02 = [[ICIMoreSegueItem alloc] initWithIcon:nil title:@"图片拍摄时间间隔" segueName:nil];
        item02.subTitle = @"5秒";
        ICIMoreGroup *group0 = [[ICIMoreGroup alloc] init];
        group0.items = @[item00,item01,item02];
        
        ICIMoreItem *item10 = [[ICIMoreSwitchItem alloc] initWithIcon:nil title:@"定位开关"];
        ICIMoreItem *item11 = [[ICIMoreSegueItem alloc] initWithIcon:nil title:@"定位模式" segueName:nil];
        item11.subTitle = @"网络模糊定位";
        ICIMoreItem *item12 = [[ICIMoreSegueItem alloc] initWithIcon:nil title:@"位置上报周期" segueName:nil];
        item12.subTitle = @"5分钟";
        ICIMoreGroup *group1 = [[ICIMoreGroup alloc] init];
        group1.items = @[item10,item11,item12];
        
        ICIMoreItem *item20 = [[ICIMoreSegueItem alloc] initWithIcon:nil title:@"图片质量" segueName:nil];
        item20.subTitle = @"清晰";

        ICIMoreGroup *group2 = [[ICIMoreGroup alloc] init];
        group2.items = @[item20];

        
        _datas = [NSMutableArray array];
        [_datas addObject:group0];
        [_datas addObject:group1];
        [_datas addObject:group2];

        
    }
    return _datas;
}

#pragma mark - 初始化方法
- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    ICIMoreGroup *moreGroup = self.datas[section];
    return moreGroup.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    ICIMoreCell *cell = [ICIMoreCell cellWithTableView:tableView];
    
    //设置数据
    ICIMoreGroup *group = self.datas[indexPath.section];
    ICIMoreItem *item = group.items[indexPath.row];
    
    cell.item = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ICIMoreGroup *group = self.datas[indexPath.section];
    ICIMoreItem *item = group.items[indexPath.row];
    //判断block是否保存了代码
    if (item.option != nil) {
        item.option();
    }
    else if ([item isKindOfClass:[ICIMoreArrowItem class]]) {
        ICIMoreArrowItem *arrowItem = (ICIMoreArrowItem *)item;
        UIViewController *vc = [[arrowItem.destVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([item isKindOfClass:[ICIMoreSegueItem class]])
    {
        ICIMoreSegueItem *segueItem = (ICIMoreSegueItem* )item;
        if (segueItem.segueName != nil) {
            [self performSegueWithIdentifier:segueItem.segueName sender:tableView];
        }
    }
}

@end
