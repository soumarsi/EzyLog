//
//  ELSupervisorSignatureViewController.m
//  EzyLog
//
//  Created by ios on 01/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELSupervisorSignatureViewController.h"
#import "ELRegisterVehicleViewController.h"
#import "SupervisorSignupViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "mySmoothLineView.h"

@interface ELSupervisorSignatureViewController ()

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation ELSupervisorSignatureViewController

@synthesize submitBtn;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    submitBtn.userInteractionEnabled=YES;
    
    self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self.view setMultipleTouchEnabled:YES];
    
    [signView removeFromSuperview];
    // Do any additional setup after loading the view.
    if(self.view.frame.size.width==320)
    {
        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(108,123,353,89)];
        [signView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview: signView];
    }
    else
    {
        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(82,150,483,96)];
        [signView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview: signView];
    }

    // Do any additional setup after loading the view.
}

- (IBAction)clearscreen:(id)sender
{
    [self viewDidLoad];
}

- (IBAction)submit__register:(id)sender
{
    SupervisorSignupViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Supervisor_Sign_up"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)submit:(id)sender
{
    ELRegisterVehicleViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registervehicle"];
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
