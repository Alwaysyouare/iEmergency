//
//  ICIInfoCenterController.m
//  iEmergency
//
//  Created by ICI on 15-8-20.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIInfoCenterController.h"
#import "SCNavTabBarController.h"
#import "ICIMessageListController.h"
#import "ICINoticeListController.h"
#import "ICINewPushMessage.h"

@interface ICIInfoCenterController ()

@end

@implementation ICIInfoCenterController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processPushNotification:) name:kICINewPushInfoNotication object:nil];
    
    // Do any additional setup after loading the view.
    ICIMessageListController *messageListController = [[ICIMessageListController alloc] init];
    messageListController.title = @"消息";
    
    ICINoticeListController *noticeListController = [[ICINoticeListController alloc] init];
    noticeListController.title = @"公告";
    
    ICINoticeListController *taskListController = [[ICINoticeListController alloc] init];
    taskListController.title = @"任务";
    
    ICINoticeListController *earthInfoListController = [[ICINoticeListController alloc] init];
    earthInfoListController.title = @"震情";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[messageListController, noticeListController, taskListController,earthInfoListController];
    navTabBarController.showArrowButton = NO;
    [navTabBarController addParentController:self];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 *  处理推送的全局Notification
 */
- (void)processPushNotification:(NSNotification *)notification
{
    ICINewPushMessage *newMessage = (ICINewPushMessage *)notification.object;
    if ([newMessage.title isEqualToString:kTitleForNewMessage]) {
      //显示下拉提示
    [self showNewStatuses];
    }
    
}

/**
 *  提示用户最新的微博数量
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatuses
{
    
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    
    // 2.显示文字
    label.text = @"您有新的消息";
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    // 5.添加到导航控制器的view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 6.动画
    CGFloat duration = 0.75;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
