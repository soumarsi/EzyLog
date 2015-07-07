//
//  ELRoadViewController.m
//  EzyLog
//
//  Created by Rahul Singha Roy on 18/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELRoadViewController.h"

#import "ELActivityLogViewController.h"
#import "UIView+Facade.h"

@interface ELRoadViewController ()

{

    CGRect mainFrame;
     BOOL _tracking;


}

@property (strong, nonatomic) IBOutlet UIView *parkingView;

@property (strong, nonatomic) IBOutlet UIView *trafficView;

@property (strong, nonatomic) IBOutlet UIView *signalView;

@property (strong, nonatomic) IBOutlet UIButton *sigbtn;

@end

@implementation ELRoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
     mainFrame=_signalView.frame;
    
    
    _parkingView.frame=_signalView.frame;
    
//    _trafficView.hidden=YES;
//    
//    _signalView.hidden=YES;
    
    CGRect tempFrame=_trafficView.frame;
    
    tempFrame.origin.x=[UIScreen mainScreen].bounds.size.width;
    tempFrame.origin.y=mainFrame.origin.y;
    
  _trafficView.frame=tempFrame;
    
    _signalView.frame=tempFrame;
    
    _sigbtn.userInteractionEnabled=YES;
    
    
    
    
    
    
    // Do any additional setup after loading the view.
    self.mapview.delegate=self;
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    
    if (screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
    _quietstreetlabel.frame=CGRectMake(80, 505, 400, 35);
    [_quietstreetlabel setFont:[UIFont fontWithName:@"OpenSans" size:20] ];
    }

   else if (screenBounds.size.height >= 667 && screenBounds.size.width >= 375)
    {
        _quietstreetlabel.frame=CGRectMake(90, 560, 400, 35);
        [_quietstreetlabel setFont:[UIFont fontWithName:@"OpenSans" size:22] ];
    }
    
///////// ---------  /////////////
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:13/255.0 green:14/255.0 blue:20/255.0 alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.follower = [Follower new];
    self.follower.delegate = self;
    
    self.driver_map.delegate = self;
    self.driver_map.showsUserLocation = YES;
    
    
    self.maskView = [UIView new];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    [self.driver_map addSubview:self.maskView];
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _tracking = YES;
    [self.follower beginRouteTracking];
}


- (IBAction)backtoprev:(id)sender
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ELActivityLogViewController *activityVC=(ELActivityLogViewController *)[story instantiateViewControllerWithIdentifier:@"activity"];
    
    [self.navigationController pushViewController:activityVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signalBtn:(id)sender
{
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ELActivityLogViewController *activityVC=(ELActivityLogViewController *)[story instantiateViewControllerWithIdentifier:@"activity"];
    
    [self.navigationController pushViewController:activityVC animated:YES];
    
    
    
    
}


- (IBAction)trafficBtn:(id)sender
{
    
    
    //Animation appearence
    
    [UIView animateWithDuration:0.8 animations:^
     {
         _trafficView.hidden=YES;
         
         
         _signalView.frame=mainFrame;
         
         
         
     } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:3.0 animations:^
          {
          }];
     }];
    

    
}

- (IBAction)parkBtn:(id)sender
{
    
    
    //Animation appearence
    
     [UIView animateWithDuration:0.8 animations:^
     {
         _parkingView.hidden=YES;
         
         //_trafficView.hidden=NO;

         
         _trafficView.frame=mainFrame;
         
         
         
     } completion:^(BOOL finished)
    {
        [UIView animateWithDuration:3.0 animations:^
         {
                     }];
    }];
    

    
    
}


- (IBAction)animation:(id)sender
{

}

- (void)followerDidUpdate:(Follower *)follower {
    _speed.text = [NSString stringWithFormat:@"%.1f mph", [follower topSpeedWithUnit:SpeedUnitMilesPerHour]];
    _driver_avg_speed.text = [NSString stringWithFormat:@"%.1f mph", [follower averageSpeedWithUnit:SpeedUnitMilesPerHour]];
    
    _total_time.text = [follower routeDurationString];
    _driver_hours_driven.text = [follower routeDurationString];
    
    _total_distance.text = [NSString stringWithFormat:@"%.2f mi", [follower totalDistanceWithUnit:DistanceUnitMiles]];
    
     _driver_distance_driven.text = [NSString stringWithFormat:@"%.2f mi", [follower totalDistanceWithUnit:DistanceUnitMiles]];
    
//    self.averageAltitudeView.valueLabel.text = [NSString stringWithFormat:@"%.0f ft", [follower averageAltitudeWithUnit:DistanceUnitFeet]];
//    self.maxAltitudeView.valueLabel.text = [NSString stringWithFormat:@"%.0f ft", [follower maximumAltitudeWithUnit:DistanceUnitFeet]];
}


#pragma mark - Map view delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.fillColor = [UIColor colorWithRed:125.0/255.0 green:207.0/255.0 blue:25.0/255.0 alpha:1.0];
    renderer.strokeColor = [UIColor colorWithRed:125.0/255.0 green:207.0/255.0 blue:25.0/255.0 alpha:1.0];
    renderer.lineWidth = 7;
    return renderer;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (_tracking) {
        [mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(.0005, .0005)) animated:YES];
    }
}


#pragma mark - Utils

/*- (UILabel *)newLabelWithColor:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    return label;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)End_drive_action:(id)sender
{
    [self.follower endRouteTracking];
    
    [_driver_map addOverlay:self.follower.routePolyline];
    [_driver_map setRegion:self.follower.routeRegion animated:YES];
    
    [_drive_base_view setHidden:YES];
    
   // _driver_map.showsUserLocation = NO;
    
    Follower *mapControl=[[Follower alloc]init];
    NSString *cor = [mapControl stop_location_update];
    
    NSArray *Map_chunks = [cor componentsSeparatedByString: @"##"];
    
    NSLog(@"......%@",[Map_chunks objectAtIndex:0]);
    
    
}
@end
