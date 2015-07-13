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

@interface ELDriveSummaryController ()<SlideDelegate>
{
    BOOL menuslide;
    LeftMenu *leftview;
}

@end


@implementation ELDriveSummaryController
@synthesize mainview;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    menuslide = 0;
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
        ELActivityLogViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
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
        ELActivityLogViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Setup"];
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
       
       ELActivityLogViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"summaryawards"];
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
