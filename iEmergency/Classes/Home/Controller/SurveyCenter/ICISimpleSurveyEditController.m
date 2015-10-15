//
//  ICISimpleSurveyEditController.m
//  iEmergency
//
//  Created by ICI on 15-8-31.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICISimpleSurveyEditController.h"
#import "ICISurveyItem.h"
#import "ICIMoreGroup.h"
#import "ICISurveyCell.h"
#import "ICISurveyFooterView.h"

@interface ICISimpleSurveyEditController ()

/**
 *  字段列表
 */
@property (nonatomic, strong) NSMutableArray *items;
/**
 *  附件列表
 */
@property (nonatomic, strong) NSMutableArray *attachments;
@end

@implementation ICISimpleSurveyEditController

/**
 *  初始化item
 *
 *  @return item数组
 */
- (NSMutableArray *)items
{
    if (_items == nil) {
        //
        ICISurveyItem *item00 = [[ICISurveyItem alloc] initWithName:@"位置" value:nil];
        ICISurveyItem *item01 = [[ICISurveyItem alloc] initWithName:@"经度" value:nil];
        ICISurveyItem *item02 = [[ICISurveyItem alloc] initWithName:@"纬度" value:nil];
        ICISurveyItem *item03 = [[ICISurveyItem alloc] initWithName:@"调查人" value:nil];
        ICIMoreGroup *group0 = [[ICIMoreGroup alloc] init];
        group0.headerTitle = @"基本信息";
        group0.items = @[item00,item01,item02,item03];
        
        ICISurveyItem *item10 = [[ICISurveyItem alloc] initWithName:@"具体描述" value:nil];
        ICIMoreGroup *group1 = [[ICIMoreGroup alloc] init];
        group1.headerTitle = @"信息描述";
        group1.items = @[item10];
        
        ICIMoreGroup *group2 = [[ICIMoreGroup alloc] init];
        group2.headerTitle = @"现场图像";
        
        _items = [NSMutableArray array];
        [_items addObject:group0];
        [_items addObject:group1];
        [_items addObject:group2];
    }
    return _items;
}

/**
 *  初始化附件列表
 *
 *  @return 附件列表
 */
- (NSMutableArray *)attachments
{
    if (_attachments == nil) {
        //
        
    }
    return _attachments;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ICISurveyCell" bundle:nil] forCellReuseIdentifier:SurveyBasicCellID];
    self.tableView.tableFooterView = [ICISurveyFooterView footerView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return _attachments.count;
            break;
            
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    if (section == 0 || section == 1) {
        ICISurveyCell *cell = [tableView dequeueReusableCellWithIdentifier:SurveyBasicCellID
                               ];
        ICIMoreGroup *group = self.items[indexPath.section];
        cell.surveyItem = group.items[indexPath.row];
        return cell;
    }else{
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ICIMoreGroup *group = self.items[section];
    return  group.headerTitle;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
