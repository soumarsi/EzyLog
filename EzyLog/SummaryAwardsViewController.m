//
//  SummaryAwardsViewController.m
//  EzyLog
//
//  Created by ios on 18/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "SummaryAwardsViewController.h"
#import "LeftMenu.h"
#import "DrivingDistanceAwardViewController.h"
#import "ELRoadViewController.h"
#import "ELtrophyrewardroomViewController.h"
#import "SupervisorSignupViewController.h"
#import "ELActivityLogViewController.h"
#import "ELDriveSummaryController.h"
#import "ELWelcomeScreen.h"
#import "ELSettingsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface SummaryAwardsViewController ()<SlideDelegate,UIGestureRecognizerDelegate>
{
    BOOL menuslide;
    LeftMenu *leftview;
    BOOL flag;
   
}
//Rahul

@property (strong, nonatomic) IBOutlet UIImageView *nextBtn_imgview;

@property (strong, nonatomic) IBOutlet UIScrollView *bottomScroll;


@end

@implementation SummaryAwardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.summaryawardstabview.delegate=self;
    self.summaryawardstabview.dataSource=self;
    self.summaryawardstabview.scrollEnabled=YES;
    menuslide = 0;
    flag=YES;
    [self.summaryscroll setContentSize:CGSizeMake(750.0f,92.0f)];
    
    _bottomScroll.scrollEnabled=NO;
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *trophyRoom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToTrophy:)];
    
    trophyRoom.delegate=self;
    
    trophyRoom.numberOfTapsRequired=1;
    trophyRoom.numberOfTouchesRequired=1;
    
    _nextBtn_imgview.userInteractionEnabled=YES;
    
    
    [_nextBtn_imgview addGestureRecognizer:trophyRoom];
    
    
    
    
    
    
    
    
}


- (IBAction)leftmenuclk:(id)sender
{
    if(flag==YES)
    {
        flag=NO;
      leftview = [LeftMenu LeftView];
       leftview.SlideDelegate = self;
        
        leftview.frame = CGRectMake(0, 0,self.view.frame.size.width*.7, self.mainview.frame.size.height);
//
        
        [UIView animateWithDuration:0.5 animations:^{


    leftview.frame = CGRectMake(0, 0,self.view.frame.size.width*.7, self.mainview.frame.size.height);
            
//    _mainview.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width*0.7f),_mainview.frame.origin.y,_mainview.frame.size.width,_mainview.frame.size.height);
//                     [self.view addSubview:leftview];
            
            }];
        
        _mainview.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width*0.7f),_mainview.frame.origin.y,_mainview.frame.size.width,_mainview.frame.size.height);
        [self.view addSubview:leftview];

        
        
    }
    else
    {
        flag=YES;
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            [_mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
            
            leftview.frame = CGRectMake(-leftview.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/2, self.view.frame.size.height);
            

            
            
            
        }];
        
        
        
//        [UIView animateWithDuration:0.5 animations:^{
//            
//        
//            [_mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
//            
//            leftview.frame = CGRectMake(-leftview.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/2, self.view.frame.size.height);
//            
        
//        } completion:^(BOOL finished) {
//            
////            [leftview removeFromSuperview];
////            [UIView commitAnimations];
//        }];
        
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
        SupervisorSignupViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"supervisorregis"];
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
    else if(sender==100)
    {
        NSLog(@"Btn tag ...100....");
        
        SummaryAwardsViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"summaryawards"];
        [self.navigationController pushViewController:obj animated:YES];
    }

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SummaryAwardsTableViewCell *cell=(SummaryAwardsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"awardsview"];
    if(indexPath.row==1)
    {
    
        UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:2];
        
        label2.textAlignment=NSTextAlignmentLeft;
        
        [label2 setText:[NSString stringWithFormat:@"FARTHEST DRIVE"]];
        
        label2.adjustsFontSizeToFitWidth=YES;
        
        UILabel *label3 = (UILabel *)[cell.contentView viewWithTag:3];
        
        [label3 setText:[NSString stringWithFormat:@"21 May 2015"]];
        
        //label3.adjustsFontSizeToFitWidth=YES;
        
        UILabel *label4 = (UILabel *)[cell.contentView viewWithTag:4];
        
        [label4 setText:[NSString stringWithFormat:@"12.7KM"]];
        
        //label4.adjustsFontSizeToFitWidth=YES;
        
        UIImageView *cellImg=(UIImageView *)[cell.contentView viewWithTag:1];
        
        cellImg.image=[UIImage imageNamed:@"Screen Shot 2015-07-03 at 10.20.34 am.png"];
        
        
    
    }
    
    
    
    if(indexPath.row==2)
    {
        
        UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:2];
        
        label2.textAlignment=NSTextAlignmentLeft;
        
        [label2 setText:[NSString stringWithFormat:@"LONGEST DRIVE"]];
        
        label2.adjustsFontSizeToFitWidth=YES;
        
        UILabel *label3 = (UILabel *)[cell.contentView viewWithTag:3];
        
        [label3 setText:[NSString stringWithFormat:@"21 May 2015"]];
        
        //label3.adjustsFontSizeToFitWidth=YES;
        
        UILabel *label4 = (UILabel *)[cell.contentView viewWithTag:4];
        
        [label4 setText:[NSString stringWithFormat:@"98.2 HOURS"]];
        
        //label4.adjustsFontSizeToFitWidth=YES;
        
        UIImageView *cellImg=(UIImageView *)[cell.contentView viewWithTag:1];
        
        cellImg.image=[UIImage imageNamed:@"long.png"];
        
        
        
    }

    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if(indexPath.row==0)
    {
    
        DrivingDistanceAwardViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"drivingdistance"];
        [self.navigationController pushViewController:obj animated:YES];

        
    
    }
    
 /*   if(indexPath.row==1)
    {
        
         ELtrophyrewardroomViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"roadview"];
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
        
    } */
        
        
}


-(void)goToTrophy:(id)sender
{
    NSLog(@"Tapped...");
    
    ELtrophyrewardroomViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"trophyroom"];
    
   
    
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController: obj animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    
    
    
    //
    
    
    
    
    
}


- (IBAction)startdrive:(id)sender
{
    SummaryAwardsViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"roadview"];
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
