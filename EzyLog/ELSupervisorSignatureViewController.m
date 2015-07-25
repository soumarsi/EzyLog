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
#import "RS_JsonClass.h"
#import "AppDelegate.h"

@interface ELSupervisorSignatureViewController ()


{

    BOOL fiveCheck;
    
    AppDelegate *app;
    
    RS_JsonClass *globalOBJ;
    
    
    
}

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;


@property (strong, nonatomic) IBOutlet UIImageView *signatureBox;

@end

@implementation ELSupervisorSignatureViewController

@synthesize submitBtn,signUPData;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    app=[[UIApplication sharedApplication]delegate];
    
    globalOBJ=[[RS_JsonClass alloc]init];
    
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
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect rect = CGRectMake(_signatureBox.frame.origin.x,_signatureBox.frame.origin.y ,_signatureBox.frame.size.width, _signatureBox.frame.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], rect);
    
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    
    //   screenshotImgView.image=img;
    
    
    
    NSData *signImageData=[NSData dataWithData:UIImageJPEGRepresentation(img, 1.0f)];
    
    
    NSLog(@"Signature data----->%@",signImageData);

    
    CGImageRelease(imageRef);
    
    NSString *urlstring=[NSString stringWithFormat:@"%@supervisor_registration.php?%@",App_Domain_Url,signUPData];
    
    
    [globalOBJ GlobalDict_image:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Globalstr_image:@"array" globalimage:signImageData Withblock:^(id result, NSError *error) {
        
        
        
        NSLog(@"result...%@",[result objectForKey:@"status"]);
        
        if ([[result valueForKey:@"status"] isEqualToString:@"success"])
        {
            
            
            
            NSMutableDictionary *get_result=[[result objectForKey:@"details" ]mutableCopy];
            
            NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
            
            [UserData setObject:[get_result objectForKey:@"id"] forKey:@"Login_User_id"];
            
            [UserData setObject:[get_result objectForKey:@"first_name"] forKey:@"User_name"];
            [UserData setObject:[get_result objectForKey:@"phone"] forKey:@"user_phone"];
            
            [UserData setObject:[get_result objectForKey:@"state"] forKey:@"user_state"];
            
            [UserData synchronize];
            
            
            app.superID=[get_result objectForKey:@"id"];
            
            NSLog(@"Supervisor ID...%@",app.superID);
            
            
            
            if([[result valueForKey:@"status"] isEqualToString:@"success"])
            {
                
                SupervisorSignupViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"supervisorregis"];
                [self.navigationController pushViewController:obj animated:YES];
                
                
                
            }
            else
            {
                
                
                
                
                
            }
            
            
            
        }
        
        
        
    }];
    

    
    
    
    
//    SupervisorSignupViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Supervisor_Sign_up"];
//    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)submit:(id)sender
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect rect = CGRectMake(_signatureBox.frame.origin.x,_signatureBox.frame.origin.y ,_signatureBox.frame.size.width, _signatureBox.frame.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], rect);
    
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    
    //   screenshotImgView.image=img;
    
    
    
    NSData *signImageData=[NSData dataWithData:UIImageJPEGRepresentation(img, 1.0f)];
    
    
    NSLog(@"Signature data----->%@",signImageData);

    
    
    
    CGImageRelease(imageRef);
    
    
    
    NSString *urlstring=[NSString stringWithFormat:@"%@supervisor_registration.php?%@",App_Domain_Url,signUPData];
    
    
    [globalOBJ GlobalDict_image:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Globalstr_image:@"array" globalimage:signImageData Withblock:^(id result, NSError *error) {
        
        
        
        NSLog(@"result...%@",[result objectForKey:@"status"]);
        
        if ([[result valueForKey:@"status"] isEqualToString:@"success"])
        {
            
            
            
            NSMutableDictionary *get_result=[[result objectForKey:@"details" ]mutableCopy];
            
            NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
            
            [UserData setObject:[get_result objectForKey:@"id"] forKey:@"Login_User_id"];
            
            [UserData setObject:[get_result objectForKey:@"first_name"] forKey:@"User_name"];
            [UserData setObject:[get_result objectForKey:@"phone"] forKey:@"user_phone"];
            
            [UserData setObject:[get_result objectForKey:@"state"] forKey:@"user_state"];
            
            [UserData synchronize];
            
            
            app.superID=[get_result objectForKey:@"id"];
            
            NSLog(@"Supervisor ID...%@",app.superID);
            
            
            
            if([[result valueForKey:@"status"] isEqualToString:@"success"])
            {
                    ELRegisterVehicleViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registervehicle"];
                    [self.navigationController pushViewController:obj animated:YES];
                
                
                
            }
            else
            {
                
                
                
                
                
            }
            
            
            
        }
        
        
        
    }];

    
    
    
    
    
    
//    ELRegisterVehicleViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registervehicle"];
//    [self.navigationController pushViewController:obj animated:YES];

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
