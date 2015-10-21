//
//  ICISimpleSurveyEditController.m
//  iEmergency
//
//  Created by ICI on 15-8-31.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICISimpleSurveyEditController.h"
#import "ICISurveyItem.h"
#import "ICISurveyGroup.h"
#import "ICISurveyCell.h"
#import "ICISurveyFooterView.h"
#import "ICISurveyTable.h"
#import "ICISurveyTableResponse.h"
#import "ICIHttpTool.h"
#import "MBProgressHUD+NJ.h"

@interface ICISimpleSurveyEditController ()<ICISurveyFooterViewDelegate,UITextFieldDelegate,
        ICISurveyCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/**
 *  调查表名称
 */
@property (nonatomic,copy) NSString *surveyTableName;

/**
 *  调查表结构
 */
@property (nonatomic,strong) ICISurveyTable *surveyTable;

/**
 *  字段列表
 */
@property (nonatomic, strong) NSArray *items;
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
- (NSArray *)items
{
    if (_items == nil) {
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"simpleSurvey" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        _items = [NSMutableArray array];
        NSMutableArray *itemsArray = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            ICISurveyGroup *group = [ICISurveyGroup groupWithDict:dict];
            [itemsArray addObject:group];
        }
        _items = itemsArray;
        
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
    
    UITapGestureRecognizer * mytap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_gestureRecognizer:)];
    [self.view addGestureRecognizer:mytap];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ICISurveyCell" bundle:nil] forCellReuseIdentifier:SurveyBasicCellID];
    ICISurveyFooterView *footView = [ICISurveyFooterView footerView];
    footView.delegate = self;
    self.tableView.tableFooterView = footView;
    
    
    ICILog(@"%@",_surveyTableName);
}

/**
 *  文本框编辑结束事件，在该事件中获取文本的值
 *
 *  @param textField
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //[textField resignFirstResponder];
    NSInteger nTag = textField.tag;
    NSString *strValue = textField.text;
    //从数组中查找是哪一个条目的文本值修改完毕
    for (ICISurveyGroup *itemGroup in _items) {
        for (ICISurveyItem *item in itemGroup.items) {
            //
            if (item.nTag == nTag) {
                item.value = strValue;
            }
        }
    }
    
}

/**
 *  使用手势来关闭键盘，因为UITableView不能接受touchesBegan消息
 *
 *  @param tap_gest <#tap_gest description#>
 */
-(void)tap_gestureRecognizer:(UITapGestureRecognizer *)tap_gest
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
        ICISurveyGroup *group = self.items[indexPath.section];
        cell.surveyItem = group.items[indexPath.row];
        cell.delegate = self;
        cell.value.delegate = self;
        return cell;
    }else{
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ICISurveyGroup *group = self.items[section];
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

- (void)ICISurveyViewDidClickBtn:(ICISurveyFooterClick)btnType
{
    switch (btnType) {
        case ICISurveyFooterClickAddAttach:
            [self addSurveyAttachment];
            break;
        case ICISurveyFooterClickSave:
            ICILog(@"点击了保存按钮");
            break;
        case ICISurveyFooterClickReport:
            [self reportSurveyTable];
            break;
        case ICISurveyFooterClickCancel:
            //
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

/**
 *  增加附件操作
 */
- (void)addSurveyAttachment
{
    ICILog(@"添加附件");
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"现场图像"
                                                                   message:@"选择现场图像"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* takePhotoAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self openCamera];
                                                          }];
    
    [alert addAction:takePhotoAction];
    UIAlertAction* imageAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self openAlbum];
                                                          }];
    [alert addAction:imageAction];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * action) {
                                                            
                                                        }];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 *  进行拍摄
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  图片选择结束
 *
 *  @param picker <#picker description#>
 *  @param info   <#info description#>
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //取出图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //TODO: 处理图片进行显示
}

/**
 *  取消选择
 *
 *  @param picker
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  上传调查表
 */
- (void)reportSurveyTable
{
    ICISurveyTable *surveyTable = [[ICISurveyTable alloc] init];
    surveyTable.tableName = _surveyTableName;
    NSMutableDictionary *attributesDict = [NSMutableDictionary dictionaryWithCapacity:5];
    for (ICISurveyGroup *itemGourp in _items) {
        for (ICISurveyItem *item in itemGourp.items) {
            if (item.value != nil) {
                [attributesDict setObject:item.value forKey:item.key];
            }else{
                [attributesDict setObject:@"" forKey:item.key];
            }
            
        }
    }
    
    surveyTable.attributesDict = attributesDict;
    
    //TODO:发送网络请求进行上报
    [MBProgressHUD showMessage:@"正在上报调查表..."];
    [ICIHttpTool postSurveyTable:surveyTable success:^(id responseObj) {
        //成功
        [MBProgressHUD hideHUD];
        if ([responseObj isKindOfClass:[ICISurveyTableResponse class]]) {
            ICISurveyTableResponse *response = (ICISurveyTableResponse *)responseObj;
            if ([response.resultCode isEqualToString:@"0"]) {
                //上报成功
                NSString *strCaseId = response.caseId;
                //TODO: 保存数据到数据库中
                
            }else{
                [MBProgressHUD showError:@"调查表上报失败"];
            }
        }else{
            [MBProgressHUD showError:@"调查表上报失败"];
        }
    } failure:^(NSError *error) {
        //失败
        [MBProgressHUD showError:@"调查表上报失败"];
    }];
}

/**
 *  点击了Cell的按钮
 */
- (void)ICISurveyCellClick
{
    ICILog(@"选择位置");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
