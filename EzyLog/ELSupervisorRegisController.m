//
//  ELSupervisorRegisController.m
//  EzyLog
//
//  Created by Somenath on 15/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELSupervisorRegisController.h"

@interface ELSupervisorRegisController ()

@end

@implementation ELSupervisorRegisController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RegisterNowclk:(id)sender {
    ELSupervisorRegisController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Supervisor_Sign_up"];
    [self.navigationController pushViewController:obj animated:YES];
}
- (IBAction)RegisterLaterclk:(id)sender {
    ELSupervisorRegisController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Setup"];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (IBAction)registerlaterclk:(id)sender
{
    ELSupervisorRegisController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registervehicle"];
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
