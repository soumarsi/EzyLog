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


{

    BOOL fiveCheck;
    
}

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;


@property (strong, nonatomic) IBOutlet UIImageView *signatureBox;

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
    if(self.view.frame.size.height==320 || fiveCheck==YES)
    {
//        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(108,123,353,89)];
        
        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(_signatureBox.frame.origin.x+35,121,419,75)];

        [signView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview: signView];
        fiveCheck=YES;
    }
    else
    {
        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(82,142,492,87)];
        [signView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview: signView];
    }

    // Do any additional setup after loading the view.
}

- (IBAction)clearscreen:(id)sender
{
    
    
    [self.view setMultipleTouchEnabled:YES];
    
    [signView removeFromSuperview];
    // Do any additional setup after loading the view.
    if(self.view.frame.size.height==320 || fiveCheck==YES)
    {
        //        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(108,123,353,89)];
        
        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(_signatureBox.frame.origin.x+8,121,418,75)];
        
        [signView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview: signView];
        //fiveCheck=YES;
    }
    else
    {
        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(82,142,492,87)];
        [signView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview: signView];
    }

    
    
    
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
