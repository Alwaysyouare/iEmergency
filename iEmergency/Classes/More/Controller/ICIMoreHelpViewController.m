//
//  ICIMoreHelpViewController.m
//  iEmergency
//
//  Created by ICI on 15-7-30.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMoreHelpViewController.h"
#import "MBProgressHUD+NJ.h"

@interface ICIMoreHelpViewController ()<UIWebViewDelegate>

@end

@implementation ICIMoreHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iemergency.htm" ofType:nil];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
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
