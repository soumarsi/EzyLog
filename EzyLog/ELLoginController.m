//
//  ELLoginController.m
//  EzyLog
//
//  Created by Somenath on 15/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELLoginController.h"
#import "ELDirectLoginController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface ELLoginController ()

@end

@implementation ELLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
//    NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
//    
//    NSLog(@"user data....fb state %@",[userData valueForKey:@"state"]);
//    
//    if ([userData objectForKey:@"session"]) {
//        UIAlertView *facebookAlert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"You are already logged in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [facebookAlert show];
//    }
    
    

}



- (IBAction)facebookLogIn:(id)sender
{
    
    
    
    if ([FBSession activeSession].state != FBSessionStateOpen &&
       [FBSession activeSession].state != FBSessionStateOpenTokenExtended )


    {
        //[self UserInformation];
        
        NSLog(@"Facebook logging in....");
        
        AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
        
        [appDelegate openActiveSessionWithPermissions:@[@"public_profile", @"email"] allowLoginUI:YES];

        
        
    }
//    else
//    {
//        NSLog(@"Already logged in...");
//        
//        
//        UIAlertView *facebookAlert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"You are already logged in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [facebookAlert show];
//        
//        // Close an existing session.
//        
//        [[FBSession activeSession] closeAndClearTokenInformation];
//        
//        // Update the UI.
//        NSLog(@"close of existing session");
//
//        
//    }
    
}



- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ezylogclk:(id)sender
{
    ELDirectLoginController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"directlogin"];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)SignUpclk:(id)sender
{
    ELLoginController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Sign_Up"];
    [self.navigationController pushViewController:obj animated:YES];

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
