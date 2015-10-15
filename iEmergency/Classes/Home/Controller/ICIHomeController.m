//
//  ICIHomeController.m
//  iEmergency
//
//  Created by ICI on 15-7-29.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIHomeController.h"
#import "ICICollectionItem.h"
#import "ICICollectionCell.h"
#import "ICINewPushMessage.h"
#import "ICICommonTool.h"
#import "ICIInfoCenterController.h"

#define ICICollectCellIdentifier @"CollectCellIdentifier"

@interface ICIHomeController ()

//定义数组
@property (nonatomic,strong) NSArray *collectionItems;
@end

@implementation ICIHomeController
{
    int nUnReadInfo;
}

-(NSArray *)collectionItems
{
    if (_collectionItems == nil) {
        //
        NSMutableArray *models = [NSMutableArray array];
        ICICollectionItem *item0 = [[ICICollectionItem alloc] initWithIcon:@"home_item_callcenter" title:@"应急指挥" destClass:nil];
         ICICollectionItem *item1 = [[ICICollectionItem alloc] initWithIcon:@"home_item_uploadmessage" title:@"调查上报" destClass:nil];
         ICICollectionItem *item2 = [[ICICollectionItem alloc] initWithIcon:@"home_item_contacts" title:@"短号互通" destClass:nil];
         ICICollectionItem *item3 = [[ICICollectionItem alloc] initWithIcon:@"home_item_message" title:@"信息通报" destClass:nil];
         ICICollectionItem *item4 = [[ICICollectionItem alloc] initWithIcon:@"home_item_filedownload" title:@"资料共享" destClass:nil];
         ICICollectionItem *item5 = [[ICICollectionItem alloc] initWithIcon:@"home_item_others" title:@"紧急救助" destClass:nil];
        
        [models addObject:item0];
        [models addObject:item1];
        [models addObject:item2];
        [models addObject:item3];
        [models addObject:item4];
        [models addObject:item5];
        _collectionItems = models;
        
    }
    return _collectionItems;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    nUnReadInfo = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processPushNotification:) name:kICINewPushInfoNotication object:nil];
    UINib *nib = [UINib nibWithNibName:@"ICICollectionCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:ICICollectCellIdentifier];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,10,10);
}


- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ICICollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ICICollectCellIdentifier forIndexPath:indexPath];
    //设置数据
    cell.backgroundColor = [UIColor whiteColor];
    cell.item = self.collectionItems[indexPath.item];
    UIView *selectView = [[UIView alloc] initWithFrame:cell.bounds];
    selectView.backgroundColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = selectView;
    if (indexPath.item == 3 && nUnReadInfo > 0) {
        cell.iconNew.hidden = NO;
    }else
    {
        cell.iconNew.hidden = YES;
    }
    return  cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.item) {
        case 0:
            [self performSegueWithIdentifier:@"YingJiZhiHui" sender:collectionView];
            break;
        case 1:
            [self performSegueWithIdentifier:@"ZaiQingShangBao" sender:collectionView];
            break;
        case 2:
            [self performSegueWithIdentifier:@"DuanHaoHuTong" sender:collectionView];
            break;
        case 3:
            {
                [self setTabbarItemBadgeValue:nil];
                nUnReadInfo = 0;
                NSArray *reloadArray = @[indexPath];
                [collectionView reloadItemsAtIndexPaths:reloadArray];
                [self performSegueWithIdentifier:@"XinXiTongBao" sender:collectionView];
                break;
            }
        case 4:
            [self performSegueWithIdentifier:@"ZiLiaoGongXiang" sender:collectionView];
            break;
        case 5:
            [self performSegueWithIdentifier:@"JinJiQiuZhu" sender:collectionView];
            break;
        default:
            break;
    }
    
}


/**
 *  处理推送的全局Notification
 */
- (void)processPushNotification:(NSNotification *)notification
{
    ICINewPushMessage *newMessage = (ICINewPushMessage *)notification.object;
    if ([newMessage.title isEqualToString:kTitleForNewMessage]) {
        //如果当前在消息界面或者消息界面 子界面
        if ([[ICICommonTool activityViewController] isKindOfClass:[ICIInfoCenterController class]] || [[[ICICommonTool activityViewController] parentViewController] isKindOfClass:[ICIInfoCenterController class]]) {
            return;
        }
        //新的推送消息 设置TabBarBadgeValue
        nUnReadInfo++;
        [self setTabbarItemBadgeValue:[NSString stringWithFormat:@"%d",nUnReadInfo]];
        [self.collectionView reloadData];
    }else if([newMessage.title isEqualToString:kTitleForReadMessage]){
        [self setTabbarItemBadgeValue:nil];
        nUnReadInfo = 0;
        [self.collectionView reloadData];
    }
}


- (void)setTabbarItemBadgeValue:(NSString *)value
{
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *barItem = [tabBar.items objectAtIndex:0];
    barItem.badgeValue = value;
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
