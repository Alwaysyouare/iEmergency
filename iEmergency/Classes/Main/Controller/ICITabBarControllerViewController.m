//
//  ICITabBarControllerViewController.m
//  iEmergency
//
//  Created by ICI on 15-7-27.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICITabBarControllerViewController.h"
#import "ICIHttpTool.h"
#import "ICIAccountParam.h"
#import "ICIAccount.h"
#import "ICIXmppManager.h"
#import "ICINewPushMessage.h"
#import "ICIBindPushServerParam.h"

#import "ICIMessageObject.h"

@interface ICITabBarControllerViewController ()
@property (nonatomic,copy) NSString *puId;
@property (nonatomic,copy) NSString *accessId;
@property (nonatomic,strong) NSTimer *heartBeatTimer;
@end

@implementation ICITabBarControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
     __weak typeof(self) weakSelf = self;
    
    [self initTabBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processPushNotification:) name:kICINewPushInfoNotication object:nil];
    [self connectPushServer];
    //启动定时器，发送心跳
    ICIAccount *iciAccount = [ICIAccount account];
    _accessId = iciAccount.AccessId;
    _puId = iciAccount.PuId;
    _heartBeatTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:weakSelf selector:@selector(sendHeartBeat) userInfo:nil repeats:YES];
    
}

- (void)initTabBar
{
    // Do any additional setup after loading the view
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *tabBarItem0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];
    tabBarItem0.selectedImage = [UIImage imageNamed:@"hometab_emergency_pressed"];
    tabBarItem0.image = [[UIImage imageNamed:@"hometab_emergency_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem0.title = NSLocalizedString(@"Main_TabBarTitle_Home",@"");
    
    tabBarItem1.selectedImage = [UIImage imageNamed:@"hometab_map_pressed"];
    tabBarItem1.image = [[UIImage imageNamed:@"hometab_map_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem1.title = NSLocalizedString(@"Main_TabBarTitle_Map",@"");
    tabBarItem2.selectedImage = [UIImage imageNamed:@"hometab_more_pressed"];
    tabBarItem2.image = [[UIImage imageNamed:@"hometab_more_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.title = NSLocalizedString(@"Main_TabBarTitle_More",@"");

}

/**
 *  连接PushServer
 */
- (void)connectPushServer
{
    ICIXmppManager *xmppManager = [ICIXmppManager sharedXmppConnectInstance];
    [xmppManager connect];
}

- (void) viewDidDisappear:(BOOL)animated
{
    if (_heartBeatTimer.isValid) {
        [_heartBeatTimer invalidate];
    }
    NSLog(@"viewDidDispear");
}

- (void)dealloc
{
    NSLog(@"tabBar dealloc");
    ICIXmppManager *xmppManager = [ICIXmppManager sharedXmppConnectInstance];
    if (xmppManager != nil) {
        [xmppManager disconnect];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 发送心跳
 */
- (void)sendHeartBeat
{
    ICIAccountParam *params = [[ICIAccountParam alloc] init];
    params.PuId = _puId;
    params.AccessId = _accessId;
    [ICIHttpTool post:METHORD_HEART_BEAT params:params success:^(id responseObj) {
//        NSString *result = [[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",result);
    } failure:^(NSError *error) {
        //NSLog(@"%@",error.localizedDescription);
    }];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  处理推送的全局Notification
 */
- (void)processPushNotification:(NSNotification *)notification
{
    ICINewPushMessage *newMessage = (ICINewPushMessage *)notification.object;
    if ([newMessage.title isEqualToString:kTitleForBindPushUser]) {
        //收到绑定的消息
        [self bindPushServer:newMessage.body];
    }
}

/**
 *  提交绑定信息
 *
 *  @param pushUserId <#pushUserId description#>
 */
- (void)bindPushServer:(NSString *)pushUserId
{
    ICIAccount *account = [ICIAccount account];
    ICIBindPushServerParam *param = [[ICIBindPushServerParam alloc] init];
    param.PuId = account.PuId;
    param.AccessId = account.AccessId;
    param.PushId = pushUserId;
    
    [ICIHttpTool post:METHORD_SET_PUSHREGISTER params:param success:^(id responseObj) {
        
    } failure:^(NSError *error) {
        
    }];
    
    //测试推送
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self TestPush];
//    });
    
    
}

- (void)TestPush
{
    ICINewPushMessage *msg = [[ICINewPushMessage alloc] init];
    msg.title = kTitleForNewMessage;
    msg.body = @"string";
    
    ICIMessageObject *newMsg = [[ICIMessageObject alloc] init];
    newMsg.messageFrom = @"管理员";
    
    newMsg.messageTo = [ICIAccount account].PuId;
    newMsg.messageContent = @"测试内容";
    newMsg.messageType = [NSNumber numberWithInteger:MessageTypeRec];
    newMsg.messageUnread = [NSNumber numberWithInteger:MessageUnread];
    newMsg.messageDate = [NSDate date];
    [ICIMessageObject save:newMsg];
    //发送全局通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kICINewPushInfoNotication object:msg];
}
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
