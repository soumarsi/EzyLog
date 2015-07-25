//
//  ELLearnerSignatureViewController.m
//  EzyLog
//
//  Created by ios on 26/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELLearnerSignatureViewController.h"
#import "SupervisorSignupViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "mySmoothLineView.h"
#import "RS_JsonClass.h"
#import "AppDelegate.h"

@interface ELLearnerSignatureViewController ()

{
  
    RS_JsonClass *globalOBJ;
    
    BOOL fiveCheck;
    
    AppDelegate *app;

}

@property (strong, nonatomic) IBOutlet UIImageView *signatureBox;


@property (strong, nonatomic) IBOutlet UIImageView *screenshotImgView;


@end

@implementation ELLearnerSignatureViewController

@synthesize screenshotImgView,signatureBox,signUPData;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    NSLog(@"URL data.....%@",signUPData);
    
     self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    [self.view setMultipleTouchEnabled:YES];
    
    globalOBJ=[[RS_JsonClass alloc]init];
    
    app=[[UIApplication sharedApplication]delegate];
    
    
    [signView removeFromSuperview];
    // Do any additional setup after loading the view.
    if(self.view.frame.size.height==320 || fiveCheck== YES)
    {
        NSLog(@"Iphone 5 ....");
        
//    signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(108,123,353,89)];
        
         signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(signatureBox.frame.origin.x+33,128,423,78)];
        
       // signView=[[mySmoothLineView alloc]initWithFrame:_signatureBox.frame];
        
        [signView setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview: signView];
        
        fiveCheck=YES;
    }
    else
    {
         NSLog(@"Iphone 5 s....");
        
        
        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(82,150,493,88)];
        
        
       // signView=[[mySmoothLineView alloc]initWithFrame:_signatureBox.frame];
        
        [signView setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview: signView];
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

- (IBAction)Signature_submit:(id)sender
{
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect rect = CGRectMake(signatureBox.frame.origin.x,signatureBox.frame.origin.y ,signatureBox.frame.size.width, signatureBox.frame.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], rect);
    
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    
 //  screenshotImgView.image=img;
    
    NSData *signImageData=[NSData dataWithData:UIImageJPEGRepresentation(img, 1.0f)];
    
    
    NSLog(@"Signature data----->%@",signImageData);
    
    CGImageRelease(imageRef);
 
    
    NSString *urlstring=[NSString stringWithFormat:@"%@driver_registration.php?%@",App_Domain_Url,signUPData];
    
    
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
            
            app=[[UIApplication sharedApplication]delegate];
            
            app.userID=[NSString stringWithFormat:@"%@",[get_result objectForKey:@"id"]];
            
            
            
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

    
    
    
//    SupervisorSignupViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"supervisorregis"];
//    [self.navigationController pushViewController:obj animated:YES];
    
    
}

- (IBAction)Cleare_Screen:(id)sender
{
    [self.view setMultipleTouchEnabled:YES];
    
    [signView removeFromSuperview];
    
    
    if(self.view.frame.size.height==320 || fiveCheck==YES)
    {
        NSLog(@"Iphone 5 ....");
        
        //    signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(108,123,353,89)];
        
        signView=[[ mySmoothLineView alloc] initWithFrame:CGRectMake(signatureBox.frame.origin.x+33,128,423,78)];
        
        // signView=[[mySmoothLineView alloc]initWithFrame:_signatureBox.frame];
        
        [signView setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview: signView];
    }
    else
    {
        NSLog(@"Iphone 5 s....");
        
        
        signView= [[ mySmoothLineView alloc] initWithFrame:CGRectMake(82,150,493,88)];
        
        
       // signView=[[mySmoothLineView alloc]initWithFrame:_signatureBox.frame];
        
        [signView setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview: signView];
    }


}
@end
