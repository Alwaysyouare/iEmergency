//
//  ICIAboutViewController.m
//  iEmergency
//
//  Created by ICI on 15-8-17.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIAboutViewController.h"

@interface ICIAboutViewController ()

@end

@implementation ICIAboutViewController

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
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    // Do any additional setup after loading the view.
    _version.text = [NSString stringWithFormat:@"Version %@",ver];
    self.edgesForExtendedLayout = UIRectEdgeTop;
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
