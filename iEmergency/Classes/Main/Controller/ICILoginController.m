//
//  ICILoginController.m
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICILoginController.h"
#import "MBProgressHUD+NJ.h"
#import "ICITabBarControllerViewController.h"
#import "ICIHttpTool.h"
#import "GDataXmlNode.h"
#import "ICIloginParam.h"
#import "ICIAccount.h"


@interface ICILoginController ()

@end

@implementation ICILoginController

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
    // Do any additional setup after loading the view.
    //隐藏顶部导航条
    [self.navigationController setNavigationBarHidden:YES];
    [self.btnLogin.layer setCornerRadius:6.0];
    ICIAccount *iciAccount = [ICIAccount account];
    NSString *trueAccountId = iciAccount.PuId;
    NSString *showId = [trueAccountId substringFromIndex:trueAccountId.length - 6];
    _account.text = showId;
    _pwd.text = iciAccount.Pwd;
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_account resignFirstResponder];
    [_pwd resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

/**
 *  登录按钮事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)onLogin:(id)sender {
    
    NSString *accountText = _account.text;
    NSString *pwdText = _pwd.text;
    if (accountText.length == 0) {
        [MBProgressHUD showError:@"账号不能为空"];
        return;
    }
    
    if (pwdText.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    [MBProgressHUD showMessage:@"正在登录..."];
    
    NSString * trueAccountId = PUPREFIX;
    trueAccountId = [trueAccountId stringByAppendingString:accountText];
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    ICILoginParam *params = [[ICILoginParam alloc] init];
    params.PuId = trueAccountId;
    params.Password = pwdText;
    params.DeviceImei = identifierForVendor;
    
    ICIAccount *iciAccount = [[ICIAccount alloc] init];
    iciAccount.PuId = trueAccountId;
    iciAccount.Pwd = pwdText;
    [ICIAccount save:iciAccount];
    [self performSegueWithIdentifier:@"SegueLogin" sender:sender];
    
    return;
    
    [ICIHttpTool post:METHORD_LOGIN params:params success:^(id responseObj) {
        [MBProgressHUD hideHUD];
        if ([responseObj isKindOfClass:[ICIAccount class]]) {
            ICIAccount *iciAccount = (ICIAccount *)responseObj;
            if ([iciAccount.ResultCode isEqualToString:RES_SUCCESS]) {
                iciAccount.PuId = trueAccountId;
                iciAccount.Pwd = pwdText;
                [ICIAccount save:iciAccount];
                [self performSegueWithIdentifier:@"SegueLogin" sender:sender];
            }
            else{
                [MBProgressHUD showError:iciAccount.ResultMsg];
            }
        }
        else
        {
            [MBProgressHUD showError:@"登录失败"];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[error localizedDescription]];
    }];

}
@end
