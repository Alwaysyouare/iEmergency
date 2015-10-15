//
//  ICIMoreController.m
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreController.h"
#import "ICIMoreItem.h"
#import "ICIMoreGroup.h"
#import "ICIMoreCell.h"
#import "ICIMoreArrowItem.h"
#import "ICIMoreSwitchItem.h"
#import "ICIMoreSegueItem.h"
#import "ICILoginController.h"
#import "MBProgressHUD+NJ.h"
#import "ICIHttpTool.h"
#import "ICIAccount.h"
#import "ICIAccountParam.h"
#import "ICIMoreEventsController.h"

@interface ICIMoreController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation ICIMoreController

- (NSMutableArray *)datas
{
    if (_datas == nil) {
        ICIMoreItem *item00 = [[ICIMoreSegueItem alloc] initWithIcon:@"MoreShare" title:@"离线地图" segueName:@"OfflineMap"];
        ICIMoreGroup *group0 = [[ICIMoreGroup alloc] init];
        group0.items = @[item00];
        
        ICIMoreItem *item10 = [[ICIMoreSegueItem alloc] initWithIcon:@"MoreShare" title:@"当前地震事件" segueName:@"CurrentEvent"];
        ICIMoreItem *item11 = [[ICIMoreSegueItem alloc] initWithIcon:@"MoreShare" title:@"应急号码设置" segueName:@"NumbersSetting"];
        ICIMoreItem *item12 = [[ICIMoreSegueItem alloc] initWithIcon:@"MoreShare" title:@"系统设置" segueName:@"SystemSetting"];
        ICIMoreGroup *group1 = [[ICIMoreGroup alloc] init];
        group1.items = @[item10,item11,item12];
        
        ICIMoreItem *item20 = [[ICIMoreArrowItem alloc] initWithIcon:@"MoreShare" title:@"检查新版本" destClass:[ICILoginController class]];
        item20.option = ^{
            [MBProgressHUD showMessage:@"正在检查..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"没有新版本"];
            });
            
        };

        ICIMoreItem *item21 = [[ICIMoreSegueItem alloc] initWithIcon:@"MoreShare" title:@"功能使用介绍" segueName:@"Help"];
        ICIMoreItem *item22 = [[ICIMoreSegueItem alloc] initWithIcon:@"MoreShare" title:@"关于应急通" segueName:@"About"];
        ICIMoreGroup *group2 = [[ICIMoreGroup alloc] init];
        group2.items = @[item20,item21,item22];
        
        ICIMoreItem *item30 = [[ICIMoreItem alloc] initWithIcon:@"MoreShare" title:@"退出登录"];
                ICIMoreGroup *group3 = [[ICIMoreGroup alloc] init];
        __weak typeof(self) vc = self;
        item30.option = ^{
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"确定注销当前账号？"
                                          delegate:vc
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:@"退出登录"
                                          otherButtonTitles:nil, nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
            [actionSheet showInView:vc.view];
            
        };
        group3.items = @[item30];
        
        _datas = [NSMutableArray array];
        [_datas addObject:group0];
        [_datas addObject:group1];
        [_datas addObject:group2];
        [_datas addObject:group3];
 
    }
    return _datas;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //发送退出请求
        ICIAccount *iciAccount = [ICIAccount account];
        ICIAccountParam *accountParam = [[ICIAccountParam alloc] init];
        accountParam.PuId = iciAccount.PuId;
        accountParam.AccessId = iciAccount.AccessId;
        [MBProgressHUD showMessage:@"正在退出..."];
        [ICIHttpTool post:METHORD_LOGIN_OUT params:accountParam success:^(id responseObj) {
            //注销成功
            [MBProgressHUD hideHUD];
            if ([responseObj isKindOfClass:[ICIBaseReponse class]]) {
                ICIBaseReponse *baseResponse = (ICIBaseReponse *)responseObj;
                if ([baseResponse.ResultCode isEqualToString:RES_SUCCESS]) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }else{
                    [MBProgressHUD showError:baseResponse.ResultMsg];
                }

            }else{
                [MBProgressHUD showError:@"退出失败"];
            }
            
        } failure:^(NSError *error) {
            //注销失败
            [MBProgressHUD showError:error.localizedDescription];
        }];

        
    }

}

-(void) dealloc
{
    NSLog(@"More Controller dealloc");
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
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
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

@end
