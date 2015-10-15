//
//  ICILoginController.h
//  iEmergency
//
//  Created by ICI on 15-7-28.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICILoginController : UIViewController
- (IBAction)onLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end
