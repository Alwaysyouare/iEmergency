//
//  ICIMoreEventsController.m
//  iEmergency
//
//  Created by ICI on 15-8-10.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreEventsController.h"
#import "ICIHttpTool.h"
#import "ICIMoreEventsParam.h"
#include "ICIMoreEvents.h"
#import "MBProgressHUD+NJ.h"
#import "MJRefresh.h"
#import "ICIEventCell.h"
#import "ICIMoreEventsTool.h"

#define moreCount 9




@interface ICIMoreEventsController ()

/**
 *  事件数组
 */
@property (nonatomic,strong) NSMutableArray *events;

@property (nonatomic,copy) NSString *oldEventId;
@property (nonatomic,copy) NSIndexPath *lastIndexPath;
@end

@implementation ICIMoreEventsController


/**
 *  初始化事件数组.由于使用MJRefresh，需要有个一个初始占位符
 *
 *  @return 事件数组
 */
- (NSMutableArray *)events
{
    if (_events == nil) {
        _events = [NSMutableArray array];
        ICIMoreEvents *event1 = [[ICIMoreEvents alloc] init];
        [_events addObject:event1];

    }
    return _events;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化读取数据
    _oldEventId = [ICIMoreEventsTool event].DzEventId;
    
    __weak typeof(self) weakSelf = self;
    __weak UITableView *tableView = self.tableView;
    [self.tableView registerNib:[UINib nibWithNibName:@"ICIEventCell" bundle:nil] forCellReuseIdentifier:EventsCellID];
    
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"HeaderRefresh");
        [tableView.footer resetNoMoreData];
        [weakSelf loadNewEvents];
    }];
    tableView.header.automaticallyChangeAlpha = YES;
    [tableView.header beginRefreshing];
    
    //目前无法显示加载
    tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreEvents];
    }];
  }

/**
 *  加载最新的地震事件
 */
- (void)loadNewEvents
{
    ICIMoreEventsParam *params = [[ICIMoreEventsParam alloc] init];
    params.DzLat=@"";
    params.Distance=@"";
    params.DzLon=@"";
    params.DzLevel=@"";
    params.StartTime=@"";
    params.EndTime = @"";
    
    params.FromIndex = 0;
    params.EndIndex = moreCount;
    [ICIHttpTool postForCu:METHORD_CU_QUERY_DZMIDLIST params:params success:^(id responseObj) {
        if (responseObj != nil) {
            NSArray *newEvents = responseObj;
            [self.events removeAllObjects];
            [self.events addObjectsFromArray:newEvents];
            [self.tableView reloadData];
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.tableView.header endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取事件列表失败，稍后重试"];
    }];
    
}

/**
 *  加载更多地震事件
 */
- (void)loadMoreEvents
{
    ICIMoreEventsParam *params = [[ICIMoreEventsParam alloc] init];
    params.DzLat=@"";
    params.Distance=@"";
    params.DzLon=@"";
    params.DzLevel=@"";
    params.StartTime=@"";
    params.EndTime = @"";
    
    params.FromIndex = self.events.count;
    params.EndIndex = self.events.count + moreCount;
    [ICIHttpTool postForCu:METHORD_CU_QUERY_DZMIDLIST params:params success:^(id responseObj) {
        if (responseObj != nil) {
            NSArray *newEvents = responseObj;
            [self.events addObjectsFromArray:newEvents];
            [self.tableView reloadData];
            
            if (newEvents.count == 0) {
                //显示无更多数据.
                [self.tableView.footer noticeNoMoreData];
            }else{
                // 拿到当前的下拉刷新控件，结束刷新状态
                [self.tableView.footer endRefreshing];
            }

        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取事件列表失败，稍后重试"];
    }];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

/**
 *  显示具体的Cell
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ICIEventCell *cell = [tableView dequeueReusableCellWithIdentifier:EventsCellID];
        // Configure the cell...
    ICIMoreEvents *event = self.events[indexPath.row];
    [cell setEvent:event];
    if ([event.DzEventId isEqualToString:_oldEventId]) {
        _lastIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    int newRow = [indexPath row];
    int oldRow = [_lastIndexPath row];
    if (newRow !=oldRow) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_lastIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        _lastIndexPath = indexPath;
        ICIMoreEvents *event = self.events[indexPath.row];
        _oldEventId = event.DzEventId;
        //如果选择后直接退出，则使用该方法
        //[self.navigationController popViewControllerAnimated:YES];
    }
    
}

/**
 *  VC消失。此处保存用户选择的事件ID到UserDefault中。
 *
 *  @param animated <#animated description#>
 */
- (void)viewDidDisappear:(BOOL)animated
{
    if (_lastIndexPath != nil) {
        ICIMoreEvents *event = self.events[_lastIndexPath.row];
        [ICIMoreEventsTool save:event];
    }
    

}

/**
 *  Cell的高度
 *
 *  @param tableView ;
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    NSLog(@"Events List Dealloc");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
