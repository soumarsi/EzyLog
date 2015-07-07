//
//  ELLearnerSignatureViewController.m
//  EzyLog
//
//  Created by ios on 26/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELLearnerSignatureViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "mySmoothLineView.h"

@interface ELLearnerSignatureViewController ()

@end

@implementation ELLearnerSignatureViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    
}



//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    // Remove old red circles on screen
////    NSArray *subviews = [self.view subviews];
////    for (UIView *view in subviews) {
////        [view removeFromSuperview];
////    }
//    
//    // Enumerate over all the touches and draw a red dot on the screen where the touches were
//    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
//        // Get a single touch and it's location
//        UITouch *touch = obj;
//        CGPoint touchPoint = [touch locationInView:self.view];
//        
//        // Draw a red circle where the touch occurred
//        UIView *touchView = [[UIView alloc] init];
//        [touchView setBackgroundColor:[UIColor blackColor]];
//        touchView.frame = CGRectMake(touchPoint.x, touchPoint.y, 8, 8);
//        //touchView.layer.cornerRadius = 15;
//        [self.view addSubview:touchView];
//        //[touchView release];
//    }];
//}




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
    ELLearnerSignatureViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"supervisorregis"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)Cleare_Screen:(id)sender
{
    [self viewDidLoad];

}
@end
