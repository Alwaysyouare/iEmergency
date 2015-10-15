//
//  ICIMessageListController.m
//  iEmergency
//
//  Created by ICI on 15-8-20.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMessageListController.h"
#import "ICIMessageObject.h"
#import "ICIAccount.h"
#import "ICINewPushMessage.h"
#import "ICIMessageCell.h"

@interface ICIMessageListController ()

/**
 *  消息数组
 */
@property (nonatomic,strong) NSMutableArray *messages;
@end

@implementation ICIMessageListController

/**
 *  初始化
 *
 *  @return 数组
 */
- (NSMutableArray *)messages
{
    if (_messages == nil) {
        _messages = [NSMutableArray array];
        
    }
    return _messages;
}

- (void)viewWillAppear:(BOOL)animated
{
    ICILog(@"will Appear");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processPushNotification:) name:kICINewPushInfoNotication object:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"ICIMessageCell" bundle:nil] forCellReuseIdentifier:ICIMessageCellID];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initMessagesArray];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) initMessagesArray
{
    ICIAccount *currentAccount = [ICIAccount account];
    //从数据库读取消息
    _messages = [ICIMessageObject fetchMessageListWithUser:currentAccount.PuId];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ICIMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ICIMessageCellID];
    ICIMessageObject *message = _messages[indexPath.row];
    [cell setMessage:message];
    return cell;
}


/**
 *  处理推送的全局Notification
 */
- (void)processPushNotification:(NSNotification *)notification
{
    ICINewPushMessage *newMessage = (ICINewPushMessage *)notification.object;
    if ([newMessage.title isEqualToString:kTitleForNewMessage]) {
        [self initMessagesArray];
        [self.tableView reloadData];
        ICINewPushMessage *msg = [[ICINewPushMessage alloc] init];
        msg.title = kTitleForReadMessage;
        msg.body = @"";
        [[NSNotificationCenter defaultCenter]postNotificationName:kICINewPushInfoNotication object:msg];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ICIMessageObject *msg = _messages[indexPath.row];
    //todo 根据msg的id，获取出联系人，然后打开消息对话窗口
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
