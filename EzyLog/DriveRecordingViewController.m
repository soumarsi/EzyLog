//
//  DriveRecordingViewController.m
//  EzyLog
//
//  Created by Rahul Singha Roy on 01/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "DriveRecordingViewController.h"

#import "ELRoadViewController.h"

@interface DriveRecordingViewController ()

@end

@implementation DriveRecordingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _Hours_driven.text=@"92.00";
    
    int record_check=[_Hours_driven.text intValue];
    
    if (record_check>120)
    {
        _Status_color.image=[UIImage imageNamed:@"green_mode"];
    }
    else if (record_check>100)
    {
        _Status_color.image=[UIImage imageNamed:@"purple_mode"];
    }
    else if (record_check>90)
    {
         _Status_color.image=[UIImage imageNamed:@"blue_mode"];
    }
    else
    {
         _Status_color.image=[UIImage imageNamed:@"red_mode"];
    }
    
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

- (IBAction)End_Drive_Action:(id)sender
{
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ELRoadViewController *roadMap=[story instantiateViewControllerWithIdentifier:@"roadview"];
    
    [self.navigationController pushViewController:roadMap animated:YES];
    
    
    
    
    //[self.navigationController popViewControllerAnimated:YES];
}
@end
