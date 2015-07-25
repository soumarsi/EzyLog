//
//  ELDriveSummaryController.m
//  EzyLog
//
//  Created by Somenath on 16/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELDriveSummaryController.h"
#import "ELActivityLogViewController.h"
#import "ELWelcomeScreen.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SupervisorSignupViewController.h"
#import "SummaryAwardsViewController.h"
#import "EL_settingsViewController.h"

#import "RS_JsonClass.h"
#import "AppDelegate.h"

@interface ELDriveSummaryController ()<SlideDelegate>
{
    BOOL menuslide;
    LeftMenu *leftview;
    
    //Dynamic drive data(s)....
    
    IBOutlet UILabel *driveHourLbl;
    
    
    IBOutlet UILabel *totalNoDrive;
    
    
    IBOutlet UILabel *dayHourLbl;
    
    
    IBOutlet UILabel *nightHourLbl;
    
    IBOutlet UILabel *monthYearLbl;
    
    
    RS_JsonClass *globalOBJ;
    
    NSMutableDictionary *resultArr;
    
    AppDelegate *app;
    
    
    
    
}

@end


@implementation ELDriveSummaryController
@synthesize mainview;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    menuslide = 0;
    
    resultArr=[[NSMutableDictionary alloc]init];
    
    globalOBJ=[[RS_JsonClass alloc]init];
    
    app=[[UIApplication sharedApplication]delegate];
    
    [self getData];
    
    
    
    
    
}

-(void)getData
{


    globalOBJ=[[RS_JsonClass alloc]init];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@total_drives.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"Driver id is %@",app.userID);
    
    NSString *postData = [NSString stringWithFormat:@"driver_id=%@",app.userID];//,app.userID
    
    NSLog(@"Post data....%@",postData);
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",request);
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [globalOBJ GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if(![[[result valueForKey:@"details"] valueForKey:@"total_drives"] isEqualToString:@"0"])
        {
        
        
            resultArr=(NSMutableDictionary *)[result mutableCopy];
            
            NSLog(@"Drive summary array..... %@",resultArr);
            
            driveHourLbl.text=[NSString stringWithFormat:@"%.2f",[[[resultArr valueForKey:@"details"] valueForKey:@"final_drive_duration"] floatValue]/60 ];
            driveHourLbl.adjustsFontSizeToFitWidth=YES;
            totalNoDrive.text=[NSString stringWithFormat:@"%@",[[resultArr valueForKey:@"details"] valueForKey:@"total_drives"]];
            dayHourLbl.text=[NSString stringWithFormat:@"%.2f",[[[resultArr valueForKey:@"details"] valueForKey:@"final_drive_day_duration"] floatValue]/60 ];
            if([dayHourLbl.text length]==4)
                dayHourLbl.text=[NSString stringWithFormat:@"0%@", [NSString stringWithFormat:@"%.2f",[[[resultArr valueForKey:@"details"] valueForKey:@"final_drive_day_duration"] floatValue]/60 ]];
            
            
            
            nightHourLbl.text=[NSString stringWithFormat:@"%.2f",[[[resultArr valueForKey:@"details"] valueForKey:@"final_drive_night_duration"] floatValue]/60 ];
            if([nightHourLbl.text length]==4)
                nightHourLbl.text=[NSString stringWithFormat:@"0%@", [NSString stringWithFormat:@"%.2f",[[[resultArr valueForKey:@"details"] valueForKey:@"final_drive_night_duration"] floatValue]/60 ]];
            
            
            monthYearLbl.text=[[resultArr valueForKey:@"details"] valueForKey:@"month"];
            
            NSLog(@"Night label text length %ld",[nightHourLbl.text length]);
            
            
            
        
        }
        
        
        
    }];

    

}

- (IBAction)leftmenuclk:(id)sender
{
    if (menuslide == 0)
    {
        leftview = [LeftMenu LeftView];
        

        leftview.frame = CGRectMake(0, 0,self.view.frame.size.width*.75, self.mainview.frame.size.height);
        leftview.SlideDelegate = self;
        [mainview setFrame:CGRectMake(self.mainview.frame.size.width*.75,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];

//        [leftView leftmenumethod];
//        leftView.leftDelegate = self;
        
        [self.view addSubview:leftview];
        menuslide = 1;
    }
    else
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
           [mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
            
            leftview.frame = CGRectMake(-leftview.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/2+60, self.view.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            
            [leftview removeFromSuperview];
            [UIView commitAnimations];
        }];

        
//        [leftview removeFromSuperview];
//        [mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        menuslide = 0;
    }
}

-(void)action_method:(NSInteger)sender
{
    
    if(sender==0)
    {
        NSLog(@"########%ld",(long)sender);
        ELDriveSummaryController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if(sender==1)
    {
        NSLog(@"########%ld",(long)sender);
        ELActivityLogViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"activity"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if(sender==4)
    {
        NSLog(@"########%ld",(long)sender);
        EL_settingsViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"settings_new"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if(sender==100)
    {
        NSLog(@"Btn tag ...100....");
        
        SummaryAwardsViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"summaryawards"];
        [self.navigationController pushViewController:obj animated:YES];
    }

    
   else if(sender==5)
    {
        NSLog(@"########%ld",(long)sender);
        
         [[FBSession activeSession] closeAndClearTokenInformation];
        
        NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        
        [userData removeObjectForKey:@"status"];
        
        
        ELWelcomeScreen *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"welcome"];
        [self.navigationController pushViewController:obj animated:YES];
    }

}

- (IBAction)begindriveclk:(id)sender
{
    ELActivityLogViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Setup"];
    [self.navigationController pushViewController:obj animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
