//
//  ELRoadViewController.m
//  EzyLog
//
//  Created by Rahul Singha Roy on 18/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELRoadViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ELActivityLogViewController.h"
#import "UIView+Facade.h"
#import "AppDelegate.h"
#import "RS_JsonClass.h"

@interface ELRoadViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

{
    RS_JsonClass *globalOBJ;
    
     CGRect mainFrame;
    
     BOOL _tracking;
    
    //url related parameters
    
    NSString *driveDistance;
    
    NSString *driveSpeed;
    
    NSString *startTime;
    
    NSDate* dateStart;
    
    NSString *endTime;
    
    NSDate* dateEnd;
    
    NSString *totalHours;
    
    NSString *dayHours;
    
    NSString *nightHours;
    
    NSString *driverID;
    
    NSString *supID;
    
    NSString *carID;
    
    NSString *startLat;
    
    NSString *startLong;
    
    NSString *endLat;
    
    NSString *endLong;
    
    AppDelegate *app;
    
    //Strings to store which button pressed
    
    NSString *parkingStrng,*trafficStrng,*roadStrng;
    
    //Drive ID after end drive...
    
    NSString *driveID;
    
    
    NSArray *total,*day,*night;
    
    int t,d,n;
    
    
    //timer variables
    
    IBOutlet UILabel *hourLbl;
    
    
    IBOutlet UILabel *minLbl;
    
    
    IBOutlet UILabel *secLbl;
    
    float hour,min,sec;
    

    


}

@property (strong, nonatomic) IBOutlet UIButton *parkBtn1;

@property (strong, nonatomic) IBOutlet UIButton *parkBtn2;


@property (strong, nonatomic) IBOutlet UILabel *view3Lbl;

@property (strong, nonatomic) IBOutlet UILabel *view2Lbl;

@property (strong, nonatomic) IBOutlet UILabel *view1Lbl;



@property (strong, nonatomic) IBOutlet MKMapView *mapDrive;

//Buttons in mapsPage

@property (strong, nonatomic) IBOutlet UIButton *sealedBtn;


@property (strong, nonatomic) IBOutlet UIButton *unsealedBtn;


@property (strong, nonatomic) IBOutlet UIButton *homeBtn;


@property (strong, nonatomic) IBOutlet UIButton *busyBtn;


@property (strong, nonatomic) IBOutlet UIButton *multiLaneBtn;


@property (strong, nonatomic) IBOutlet UIButton *twoCarBtn;


@property (strong, nonatomic) IBOutlet UIButton *fourCarBtn;


@property (strong, nonatomic) IBOutlet UIButton *sixCarBtn;





@property (strong, nonatomic) IBOutlet UIView *parkingView;

@property (strong, nonatomic) IBOutlet UIView *trafficView;

@property (strong, nonatomic) IBOutlet UIView *signalView;

@property (strong, nonatomic) IBOutlet UIButton *sigbtn;

@end

@implementation ELRoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    hour=.00;
    min=.00;
    //min=.59;
    sec=.00;
    
    total=[[NSArray alloc]init];
    day=[[NSArray alloc]init];
    night=[[NSArray alloc]init];
    
    t=d=n=0;
    
    dayHours=@"";
    nightHours=@"";
    
    app=[[UIApplication sharedApplication] delegate];
    
    driverID=app.userID;
    supID=app.superID;
    carID=app.carID;
    
    _mapDrive.delegate=self;
    [_mapDrive setShowsUserLocation:TRUE];
    
  CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
//    if(locationManager.locationServicesEnabled)
//    {
        [locationManager startUpdatingLocation];
//    }
    
    

    NSLog(@"Current location....%.2f",_mapDrive.userLocation.coordinate.latitude);
    
    
    //url fire related data
    
    startLat=[NSString stringWithFormat:@"0"];
    startLong=[NSString stringWithFormat:@"0"];;
    
    
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
    
    
    
    //timer start
    
     [self startTimer];
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _tracking = YES;
    [self.follower beginRouteTracking];
    
    
    dateStart = [NSDate date];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH.mm"];
    
    NSString *strCurrentTime = [dateFormatter stringFromDate:[NSDate date]];
    
   // NSLog(@" Beginning current time: %.2f",[strCurrentTime floatValue]);
    
    NSLog(@" Beginning current time: %f",[strCurrentTime floatValue]);
    
    if ([strCurrentTime floatValue] >= 18.00 || [strCurrentTime floatValue]  <= 6.00){
        NSLog(@"It's night time");
    }else{
        NSLog(@"It's day time");
    }
    
    
    startTime=strCurrentTime;
    
}


- (IBAction)backtoprev:(id)sender
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ELActivityLogViewController *activityVC=(ELActivityLogViewController *)[story instantiateViewControllerWithIdentifier:@"activity"];
    
    [self.navigationController pushViewController:activityVC animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    NSLog(@"Current location lat....%f",newLocation.coordinate.latitude);
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signalBtn:(id)sender
{
    UIButton *tappedBtn=(UIButton *)(id)sender;
    
    if([tappedBtn isEqual:_sealedBtn])
    {
        _view3Lbl.text=@"I drove in Sealed Street";
    
        _unsealedBtn.hidden=YES;
        _homeBtn.hidden=YES;
        _busyBtn.hidden=YES;
        _multiLaneBtn.hidden=YES;
        
        roadStrng=@"S";
        
    
    }
    else     if([tappedBtn isEqual:_unsealedBtn])
    {
        _view3Lbl.text=@"I drove in Unsealed street";
        _sealedBtn.hidden=YES;
        _homeBtn.hidden=YES;
        _busyBtn.hidden=YES;
        _multiLaneBtn.hidden=YES;
        
        roadStrng=@"U";
        
        
    }
    else     if([tappedBtn isEqual:_homeBtn])
    {
        _view3Lbl.text=@"I drove in Quiet street";
        
        _sealedBtn.hidden=YES;
        _unsealedBtn.hidden=YES;
        _busyBtn.hidden=YES;
        _multiLaneBtn.hidden=YES;
        
        roadStrng=@"Q";
        
        
    }
    else     if([tappedBtn isEqual:_busyBtn])
    {
        _view3Lbl.text=@"I drove in Busy street";
        _sealedBtn.hidden=YES;
        _homeBtn.hidden=YES;
        _unsealedBtn.hidden=YES;
        _multiLaneBtn.hidden=YES;
        
        roadStrng=@"B";
        
        
    }
    else     if([tappedBtn isEqual:_multiLaneBtn])
    {
        
        _view3Lbl.text=@"I drove in Multi-Lane street";//Multi-Lane
        
        _sealedBtn.hidden=YES;
        _homeBtn.hidden=YES;
        _busyBtn.hidden=YES;
        _unsealedBtn.hidden=YES;
        
        roadStrng=@"M";
        
        
    }
    
    
     [self performSelector:@selector(signalAction) withObject:nil afterDelay:1.5];
    
    
    
    
}


-(void)signalAction
{

    
    globalOBJ=[[RS_JsonClass alloc]init];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@end_drive.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"Driver id is %@",app.userID);
    
    NSString *postData = [NSString stringWithFormat:@"drive_id=%@&parking=%@&traffic=%@&road_condition=%@",driveID,parkingStrng,trafficStrng,roadStrng];//,app.userID
    
    NSLog(@"Post data....%@",postData);
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",request);
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [globalOBJ GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if(result)
        {
        
            NSLog(@"Result after ending drive.....%@",result);
        
        }
        
        
        
    }];

    

    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ELActivityLogViewController *activityVC=(ELActivityLogViewController *)[story instantiateViewControllerWithIdentifier:@"activity"];
    
    [self.navigationController pushViewController:activityVC animated:YES];
    

    

}


- (IBAction)trafficBtn:(id)sender
{
    
    
    UIButton *tappedBtn=(UIButton *)(id)sender;
    
    if([tappedBtn isEqual:_twoCarBtn])
    {
        
        _view2Lbl.text=@"I drove in light traffic";
        _fourCarBtn.hidden=YES;
        _sixCarBtn.hidden=YES;
        
        trafficStrng=@"L";
        
    }
    else     if([tappedBtn isEqual:_fourCarBtn])
    {
        _view2Lbl.text=@"I drove in medium Traffic";
        _twoCarBtn.hidden=YES;
        _sixCarBtn.hidden=YES;
        
        trafficStrng=@"M";
        
        
    }
    else     if([tappedBtn isEqual:_sixCarBtn])
    {
        _view2Lbl.text=@"I drove in heavy Traffic";
        _twoCarBtn.hidden=YES;
        _fourCarBtn.hidden=YES;
        
        trafficStrng=@"H";
        
        
    }

    
    [self performSelector:@selector(traficAction) withObject:nil afterDelay:1.5];
    

    
}

-(void)traficAction
{

    [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:10 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _trafficView.hidden=YES;
        
        _signalView.frame=mainFrame;
        
        
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    


}

- (IBAction)parkBtn:(id)sender
{
    
 

    UIButton *tapped=(UIButton *)(id)sender;
    
    if([tapped isEqual:_parkBtn1])
    {
        _parkBtn2.hidden=YES;
        
        _view1Lbl.text=@"I practiced my parking";
        
        parkingStrng=@"T";
        
        
        
    }
    else if ([tapped isEqual:_parkBtn2])
    {
        _parkBtn1.hidden=YES;
         _view1Lbl.text=@"I didn't practice parking";
        
        parkingStrng=@"F";
        
    }
    
     [self performSelector:@selector(parkAction) withObject:nil afterDelay:1.5];
    
    
    
}


-(void)parkAction
{
    
    [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:10 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _parkingView.hidden=YES;
        
        //_trafficView.hidden=NO;
        
        
        _trafficView.frame=mainFrame;
        
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}


- (void)followerDidUpdate:(Follower *)follower
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        
       _speed.text = [NSString stringWithFormat:@"%.1f mph", [follower topSpeedWithUnit:SpeedUnitMilesPerHour]];
    _driver_avg_speed.text = [NSString stringWithFormat:@"%.1f mph", [follower averageSpeedWithUnit:SpeedUnitMilesPerHour]];
    
    driveSpeed=[NSString stringWithFormat:@"%f", [follower averageSpeedWithUnit:SpeedUnitMilesPerHour]];

    
    _total_time.text = [follower routeDurationString];
    
   //_driver_hours_driven.text = [follower routeDurationString];
        
       // [self startTimer];
        
        secLbl.adjustsFontSizeToFitWidth=YES;
        
    
    _total_distance.text = [NSString stringWithFormat:@"%.2f mi", [follower totalDistanceWithUnit:DistanceUnitMiles]];
    
    driveDistance=[NSString stringWithFormat:@"%.2f", [follower totalDistanceWithUnit:DistanceUnitMiles]*1.60];
    
     _driver_distance_driven.text = [NSString stringWithFormat:@"%.2f mi", [follower totalDistanceWithUnit:DistanceUnitMiles]];
    
//    self.averageAltitudeView.valueLabel.text = [NSString stringWithFormat:@"%.0f ft", [follower averageAltitudeWithUnit:DistanceUnitFeet]];
//    self.maxAltitudeView.valueLabel.text = [NSString stringWithFormat:@"%.0f ft", [follower maximumAltitudeWithUnit:DistanceUnitFeet]];
        
    });

}


-(void)startTimer
{

     NSArray *secArr=[[NSArray alloc]init];
     NSArray *minArr=[[NSArray alloc]init];
     NSArray *hourArr=[[NSArray alloc]init];
    
    
    
    sec+=.01;
    
    NSString *tempSec=[NSString stringWithFormat:@"%.2f",sec];
    
    sec=[tempSec floatValue];
    
    NSLog(@"Sec: %@",tempSec);
    
    if([tempSec isEqualToString:@"0.60"])
    {
        sec=.00;
        
        min+=.01;
        
        NSString *tempMin=[NSString stringWithFormat:@"%.2f",min];
        
        min=[tempMin floatValue];
        
        
        
        if([tempMin isEqualToString:@"0.60"])
        {
        
            NSLog(@"Minute............: %@",tempMin);
        
            min=.00;
            
            hour+=.01;
            
            hourArr=[[NSString stringWithFormat:@"%.2f",hour] componentsSeparatedByString:@"."];
            
             hourLbl.text=[hourArr objectAtIndex:1];
            
            minArr=[[NSString stringWithFormat:@"%.2f",min] componentsSeparatedByString:@"."];
            
            minLbl.text=[minArr objectAtIndex:1];
            
            secArr=[[NSString stringWithFormat:@"%.2f",sec] componentsSeparatedByString:@"."];
            secLbl.text=[secArr objectAtIndex:1];

        
        }

        else
        {
            
       // minArr=[[NSString stringWithFormat:@"%.2f",min] componentsSeparatedByString:@"."];
        
        secArr=[[NSString stringWithFormat:@"%.2f",sec] componentsSeparatedByString:@"."];
        
       // minLbl.text=[minArr objectAtIndex:1];
        
            secLbl.text=[secArr objectAtIndex:1];
        }
        
    }
    else
    {
    
        minArr=[[NSString stringWithFormat:@"%.2f",min] componentsSeparatedByString:@"."];
        
        minLbl.text=[minArr objectAtIndex:1];
   
        
    secArr=[[NSString stringWithFormat:@"%.2f",sec] componentsSeparatedByString:@"."];
    
    secLbl.text=[secArr objectAtIndex:1];
        
    }
    
    [self performSelector:@selector(startTimer) withObject:nil afterDelay:1.0];


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
        
        
        if([startLat isEqualToString:@"0"] && [startLong isEqualToString:@"0"])
        {
        
            startLat=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
            startLong=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
            
                    NSLog(@"home latitude... %@",startLat);
            
                   NSLog(@"home longitude... %@",startLong);

        
        
        }

        
        [mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(.0005, .0005)) animated:YES];
    }
}




- (IBAction)End_drive_action:(id)sender
{
    [self.follower endRouteTracking];
    
    [_driver_map addOverlay:self.follower.routePolyline];
    [_driver_map setRegion:self.follower.routeRegion animated:YES];
    
    [_drive_base_view setHidden:YES];
    
   // _driver_map.showsUserLocation = NO;
    
    Follower *mapControl=[[Follower alloc]init];
    NSString *cor = [mapControl stop_location_update];
    
    NSLog(@"Cor : %@",cor);
    
    NSArray *Map_chunks = [cor componentsSeparatedByString: @"##"];
    
    NSLog(@"......%@",[Map_chunks objectAtIndex:0]);
    
    endLat=[NSString stringWithFormat:@"%@",[Map_chunks objectAtIndex:0]];
    
    endLong=[NSString stringWithFormat:@"%@",[Map_chunks objectAtIndex:1]];;
    
    //totalHours=[NSString stringWithFormat:@"@%",_total_time.text];
    //
    
    dateEnd = [NSDate date];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH.mm"];
    
    endTime = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"current time: %.2f",[endTime floatValue]);
    
    totalHours=[NSString stringWithFormat:@"%.2f",[endTime floatValue]-[startTime floatValue]];

    NSLog(@"Driving hours.... %f",[totalHours floatValue]);
    
    
    if ([startTime floatValue] >= 18.00)
    {
        NSLog(@"Night drive.....");
        
        if ([endTime floatValue]>=6.00) {
            
            double dif=12-([startTime floatValue]-18.00)+[endTime floatValue]-6.00;
            
            dayHours=[NSString stringWithFormat:@"%.2f",[endTime floatValue]-6.00];
            nightHours=[NSString stringWithFormat:@"%.2f",12-([startTime floatValue]-18.00)];
            
            //day
            
            day=[dayHours componentsSeparatedByString:@"."];
            d=(int)([day[0]integerValue]*60)+(int)[day[1]integerValue];
            dayHours=[NSString stringWithFormat:@"%d",d];
            
            
            //night
            
            night=[nightHours componentsSeparatedByString:@"."];
            n=(int)([night[0]integerValue]*60)+(int)[night[1]integerValue];
            dayHours=[NSString stringWithFormat:@"%d",n];

            
            
            
           //total
            totalHours=[NSString stringWithFormat:@"%.2f",dif];
            
            total=[totalHours componentsSeparatedByString:@"."];
            
            t=(int)([total[0] integerValue]*60)+(int)[total[1]integerValue];
            
            totalHours=[NSString stringWithFormat:@"%d",t];
            
        }
        else
        {
        
            double dif=[endTime floatValue]-[startTime floatValue];
            
            totalHours=[NSString stringWithFormat:@"%.2f",dif];
            
            total=[totalHours componentsSeparatedByString:@"."];
            
            t=(int)([total[0] integerValue]*60)+(int)[total[1]integerValue];
            
            totalHours=[NSString stringWithFormat:@"%d",t];

            
            nightHours=totalHours;
        
        }

        
    }
    else if([startTime floatValue]>=6.00 && [startTime floatValue]<=18.00)
    {
        NSLog(@"Day drive .....");
        
        
        if ([endTime floatValue]>=18.00) {
            
            double dif=12-([startTime floatValue]-6.00)+[endTime floatValue]-18.00;
            
            totalHours=[NSString stringWithFormat:@"%.2f",dif];
            
            dayHours=[NSString stringWithFormat:@"%.2f",12-([startTime floatValue]-6.00)];
            
            nightHours=[NSString stringWithFormat:@"%.2f",[endTime floatValue]-18.00];
            
            //total
            total=[totalHours componentsSeparatedByString:@"."];
            
            t=(int)([total[0] integerValue]*60)+(int)[total[1]integerValue];
            
            totalHours=[NSString stringWithFormat:@"%d",t];
            
            
            //day
            
            day=[dayHours componentsSeparatedByString:@"."];
            d=(int)([day[0]integerValue]*60)+(int)[day[1]integerValue];
            dayHours=[NSString stringWithFormat:@"%d",d];
            
            
            //night
            
            night=[nightHours componentsSeparatedByString:@"."];
            n=(int)([night[0]integerValue]*60)+(int)[night[1]integerValue];
            dayHours=[NSString stringWithFormat:@"%d",n];


            
            
        }
        else
        {
            
            double dif=[endTime floatValue]-[startTime floatValue];
            
            totalHours=[NSString stringWithFormat:@"%.2f",dif];
            
            total=[totalHours componentsSeparatedByString:@"."];
            
            t=(int)([total[0] integerValue]*60)+(int)[total[1]integerValue];
            
            totalHours=[NSString stringWithFormat:@"%d",t];
            
            dayHours=totalHours;
            
        }
        
        NSLog(@"You have drived total....> %@",totalHours);

        
    }
    
    if(![driveDistance isEqualToString:@""])
    
          [self fireURL];
    else
    {
    
        UIAlertView *driveAlert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"You have not completed any drive." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
        [driveAlert show];
        
    }
    
    
}


-(void)fireURL
{

    NSLog(@"Driver ID: %@ \n Super ID: %@ \n Car ID: %@ \n Drive distance: %@ \n Drive speed: %@ \n Start lat: %@ \n Start long: %@ \n End lat: %@ \n End long: %@ \n",driverID,supID,carID,driveDistance,driveSpeed,startLat,startLong,endLat,endLong);
    
    globalOBJ=[[RS_JsonClass alloc]init];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@drive_summary.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"Driver id is %@",app.userID);
    
    NSString *postData = [NSString stringWithFormat:@"driver_id=%@&supervisor_id=%@&car_id=%@&total_drive_hr=%@&drive_day_hr=%@&drive_night_hr=%@&drive_km=%@&avg_speed=%@&start_lat=%@&start_long=%@&end_lat=%@&end_long=%@",driverID,supID,carID,totalHours,dayHours,nightHours,driveDistance,driveSpeed,startLat,startLong,endLat,endLong];//,app.userID
    
    NSLog(@"Post data....%@",postData);
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",request);
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    

    [globalOBJ GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if(result)
        {
        
            NSLog(@"Result....%@",result);
            
            driveID=[NSString stringWithFormat:@"%@",[result valueForKey:@"id"]];
            
            NSLog(@"**--DRIVE ID--** %@",driveID);
        
        }
        
        
        
    }];
    

}

@end
