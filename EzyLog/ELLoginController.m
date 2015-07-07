//
//  ELLoginController.m
//  EzyLog
//
//  Created by Somenath on 15/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELLoginController.h"
#import "ELDirectLoginController.h"

@interface ELLoginController ()

@end

@implementation ELLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ezylogclk:(id)sender
{
    ELDirectLoginController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"directlogin"];
    [self.navigationController pushViewController:login animated:YES];
}
- (IBAction)SignUpclk:(id)sender {
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
