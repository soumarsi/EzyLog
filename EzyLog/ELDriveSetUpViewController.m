//
//  ELDriveSetUpViewController.m
//  EzyLog
//
//  Created by Soumen on 16/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELDriveSetUpViewController.h"

@interface ELDriveSetUpViewController ()

@end

@implementation ELDriveSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)backclk:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Startclk:(id)sender {
    ELDriveSetUpViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drivesetup2_Page"];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)registercarclk:(id)sender
{
    ELDriveSetUpViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registervehicle"];
    [self.navigationController pushViewController:login animated:YES];
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
