//
//  DriveSetup2ViewController.m
//  EzyLog
//
//  Created by Rahul Singha Roy on 01/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "DriveSetup2ViewController.h"

@interface DriveSetup2ViewController ()

{

    NSTimer *countDown;

}

@property (strong, nonatomic) IBOutlet UIButton *iAgreeBtn;

@property (strong, nonatomic) IBOutlet UIVisualEffectView *timerBackView;


@property (strong, nonatomic) IBOutlet UILabel *countLbl;




@end

@implementation DriveSetup2ViewController

@synthesize iAgreeBtn,timerBackView,countLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    timerBackView.hidden=YES;
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

- (IBAction)Back_button_action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)I_Agree_action:(id)sender
{
    
    NSLog(@"I agree tapped.....");
    
    
    
    
    timerBackView.hidden=NO;
    
    timerBackView.layer.cornerRadius=timerBackView.frame.size.width/2;
    
    timerBackView.clipsToBounds=YES;

    
   [self performSelector:@selector(countDown) withObject:nil afterDelay:1.0];
    
}


-(void)countDown
{
    
    if([countLbl.text isEqualToString:@"3"])
    {
    
      countLbl.text=@"2";
        
        [self performSelector:@selector(countDown) withObject:nil afterDelay:1];
        
    
    }
    else
        if([countLbl.text isEqualToString:@"2"])
        {
            
            countLbl.text=@"1";
            
            [self performSelector:@selector(countDown) withObject:nil afterDelay:1];
            
            
        }
    else
        if([countLbl.text isEqualToString:@"1"])
        {
            countLbl.adjustsFontSizeToFitWidth=YES;
            
            countLbl.text=@"GO";
            
            
            [self performSelector:@selector(goToDrivePage) withObject:nil afterDelay:1.2];
            
            
        }


    
    
    
    
}

-(void)goToDrivePage
{

    timerBackView.hidden=YES;

    DriveSetup2ViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"drive_recording_page"];
    
    [self.navigationController pushViewController:obj animated:YES];



}


@end
