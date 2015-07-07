//
//  ELWelcomeScreen.m
//  EzyLog
//
//  Created by Somenath on 15/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELWelcomeScreen.h"
#import "ELLoginController.h"

@interface ELWelcomeScreen ()

@end

@implementation ELWelcomeScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getstartedclk:(id)sender
{
    ELLoginController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"logindriver"];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)tourtheappclk:(id)sender
{
    ELLoginController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"tourapp"];
    [self.navigationController pushViewController:login animated:YES];
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
