//
//  ICIMapController.h
//  iEmergency
//
//  Created by ICI on 15-8-13.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
@interface ICIMapController : UIViewController <BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *zoomOut;
@property (weak, nonatomic) IBOutlet UIButton *zoomIn;

- (IBAction)zoomInOperate:(UIButton *)sender;
- (IBAction)zoomOutOperate:(UIButton *)sender;
- (IBAction)eventPositionOperate:(UIButton *)sender;
- (IBAction)myPositionOperate:(UIButton *)sender;

@end
