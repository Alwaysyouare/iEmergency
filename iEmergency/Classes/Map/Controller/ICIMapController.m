//
//  ICIMapController.m
//  iEmergency
//
//  Created by ICI on 15-8-13.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMapController.h"
#import "ICIMoreEvents.h"
#import "ICIMoreEventsTool.h"
#import "ICICommonTool.h"
#import "MBProgressHUD+NJ.h"
#import "EventPopView.h"

@interface ICIMapController ()
{
    BMKLocationService* _locService;
    BMKPointAnnotation* _eventAnnotation;
    BMKAnnotationView* _eventAnnotationView;
    ICIMoreEvents* _currentEvent;
}

@end

@implementation ICIMapController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent = NO;
    _mapView.zoomLevel = 12.0;
    _mapView.showMapScaleBar = YES;
    _mapView.mapScaleBarPosition = CGPointMake(_mapView.frame.size.width - 70, _mapView.frame.size.height - 40);
    _locService = [[BMKLocationService alloc] init];
    [self startLocation];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
    
}


- (void)dealloc
{
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  放大操作
 *
 *  @param sender 按钮
 */
- (IBAction)zoomInOperate:(UIButton *)sender {
    float fCurrentZoomLevel = _mapView.zoomLevel;
    if (fCurrentZoomLevel < 18.0) {
        _mapView.zoomLevel = fCurrentZoomLevel + 1;
    }else
    {
        _mapView.zoomLevel = 19.0;
    }
    //设置enable为NO的话，会出现点击事件到地图上的问题。

}

/**
 *  缩小
 *
 *  @param sender <#sender description#>
 */
- (IBAction)zoomOutOperate:(UIButton *)sender {
    float fCurrentZoomLevel = _mapView.zoomLevel;
    if (fCurrentZoomLevel > 4.0) {
        _mapView.zoomLevel = fCurrentZoomLevel - 1;
    }else
    {
        _mapView.zoomLevel = 3.0;
    }


}

/**
 *  事件位置
 *
 *  @param sender <#sender description#>
 */
- (IBAction)eventPositionOperate:(UIButton *)sender {
    
    if (_eventAnnotation != nil) {
        [_mapView removeAnnotation:_eventAnnotation];
    }
    
    _currentEvent= [ICIMoreEventsTool event];
    if (_currentEvent == nil) {
        [MBProgressHUD showError:@"没有选择事件"];
        return;
    }
    //更新事件位置
    [self updateEventAnnotation:_currentEvent];
}

/**
 *  我的位置
 *
 *  @param sender
 */
- (IBAction)myPositionOperate:(UIButton *)sender {
    [self startLocation];
}

/**
 *  开始定位
 */
- (void)startLocation
{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = YES;
}

/**
 *  更新事件位置标注
 *
 *  @param event 事件数据
 */
- (void)updateEventAnnotation:(ICIMoreEvents *)event
{
    if (event == nil || event.DzEventId == nil) {
        return;
    }
    if (_eventAnnotation == nil) {
        _eventAnnotation = [[BMKPointAnnotation alloc] init];
    }
    CLLocationCoordinate2D coor;
    coor.latitude = [event.DzLat floatValue];
    coor.longitude = [event.DzLon floatValue];
    _eventAnnotation.coordinate = coor;
    _eventAnnotation.title = event.DzEventName;
    [_mapView addAnnotation:_eventAnnotation];
    [_mapView setCenterCoordinate:coor animated:YES];
    
}


#pragma mark BMKMapViewDelegate

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSString* showmeg = [NSString stringWithFormat:@"地图区域发生了变化(x=%d,y=%d,\r\nwidth=%d,height=%d).\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d",(int)_mapView.visibleMapRect.origin.x,(int)_mapView.visibleMapRect.origin.y,(int)_mapView.visibleMapRect.size.width,(int)_mapView.visibleMapRect.size.height,(int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    ICILog(@"%@",showmeg);
}

/**
 *  根据annotation生成对应的View
 *
 *  @param mapView    mapView description
 *  @param annotation annotation description
 *
 *  @return return value description
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if (annotation == _eventAnnotation) {
        NSString *AnnotationViewID = @"eventMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            //设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            annotationView.animatesDrop = YES;
            annotationView.canShowCallout = YES;
        }
        
        UIView *viewForImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        [imageView setImage:[UIImage imageNamed:@"map_event_lv1"]];
        [viewForImage addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        label.text=_currentEvent.DzLevel;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.backgroundColor = [UIColor clearColor];
        [viewForImage addSubview:label];
        annotationView.image = [ICICommonTool imageFromView:viewForImage];
        
        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 100, 100)];
        popView.backgroundColor = [UIColor whiteColor];
        [popView.layer setMasksToBounds:YES];
        [popView.layer setCornerRadius:3.0];
        popView.alpha = 0.9;
        
        //自定义气泡的内容，添加子控件在popView上
        UILabel *eventName = [[UILabel alloc]initWithFrame:CGRectMake(8, 4, 160, 30)];
        eventName.text = _currentEvent.DzEventName;
        eventName.numberOfLines = 0;
        eventName.backgroundColor = [UIColor clearColor];
        eventName.font = [UIFont systemFontOfSize:15];
        eventName.textColor = [UIColor blackColor];
        eventName.textAlignment = NSTextAlignmentLeft;
        [popView addSubview:eventName];
        
        UILabel *eventLevel = [[UILabel alloc]initWithFrame:CGRectMake(8, 30, 180, 20)];
        eventLevel.text = [NSString stringWithFormat:@"级别：%@级",_currentEvent.DzLevel];
        eventLevel.backgroundColor = [UIColor clearColor];
        eventLevel.font = [UIFont systemFontOfSize:11];
        eventLevel.textColor = [UIColor lightGrayColor];
        eventLevel.textAlignment = NSTextAlignmentLeft;
        [popView addSubview:eventLevel];
        
        UILabel *eventPos = [[UILabel alloc]initWithFrame:CGRectMake(8, 50, 180, 20)];
        eventPos.text = [NSString stringWithFormat:@"地点：%@",_currentEvent.DzPos];
        eventPos.backgroundColor = [UIColor clearColor];
        eventPos.font = [UIFont systemFontOfSize:11];
        eventPos.textColor = [UIColor lightGrayColor];
        eventPos.textAlignment = NSTextAlignmentLeft;
        [popView addSubview:eventPos];
        
        UILabel *eventTime = [[UILabel alloc]initWithFrame:CGRectMake(8, 70, 180, 20)];
        eventTime.text = [NSString stringWithFormat:@"时间：%@",_currentEvent.DzStartTime];
        eventTime.backgroundColor = [UIColor clearColor];
        eventTime.font = [UIFont systemFontOfSize:11];
        eventTime.textColor = [UIColor lightGrayColor];
        eventTime.textAlignment = NSTextAlignmentLeft;
        [popView addSubview:eventTime];
        
        if (annotation.subtitle != nil) {
            UIButton *searchBn = [[UIButton alloc]initWithFrame:CGRectMake(170, 0, 50, 60)];
            [searchBn setTitle:@"查看路线" forState:UIControlStateNormal];
            //searchBn.backgroundColor = mainColor;
            searchBn.titleLabel.numberOfLines = 0;
            //[searchBn addTarget:self action:@selector(searchLine)];
            [popView addSubview:searchBn];
        }

        BMKActionPaopaoView* paopaoView =[[BMKActionPaopaoView alloc] initWithCustomView:popView];
        paopaoView.frame = CGRectMake(0, 0, ScreenWidth - 100, 100);
        annotationView.paopaoView =paopaoView;
        
        return annotationView;
    }
    return nil;
}


#pragma mark BMKLocationServiceDelegate

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
	ICILog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    ICILog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    ICILog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude) animated:YES];
    [_locService stopUserLocationService];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    ICILog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    ICILog(@"location error");
}


@end
