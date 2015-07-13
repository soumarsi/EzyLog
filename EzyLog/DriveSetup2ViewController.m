//
//  DriveSetup2ViewController.m
//  EzyLog
//
//  Created by Rahul Singha Roy on 01/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "DriveSetup2ViewController.h"

@interface DriveSetup2ViewController ()

@end

@implementation DriveSetup2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)Back_button_action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)I_Agree_action:(id)sender
{
    DriveSetup2ViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"drive_recording_page"];
    
    [self.navigationController pushViewController:obj animated:YES];
    
}
@end
