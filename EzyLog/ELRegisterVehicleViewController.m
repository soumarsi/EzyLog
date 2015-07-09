//
//  ELRegisterVehicleViewController.m
//  EzyLog
//
//  Created by ios on 26/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELRegisterVehicleViewController.h"
#import "ELDriveSummaryController.h"
#import "ELCarRegistrationViewController.h"

@interface ELRegisterVehicleViewController ()

@end

@implementation ELRegisterVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backtoprev:(id)sender
{
    ELDriveSummaryController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
    [self.navigationController pushViewController:login animated:YES];
}
- (IBAction)moveforregister:(id)sender
{
    ELCarRegistrationViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"carregistration"];
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
