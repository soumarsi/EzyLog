//
//  EL_settingsViewController.m
//  EzyLog
//
//  Created by IOS2 on 24/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "EL_settingsViewController.h"
#import "AppDelegate.h"

@interface EL_settingsViewController ()

{

    AppDelegate *app;

}


@property (strong, nonatomic) IBOutlet UILabel *userName;

@property (strong, nonatomic) IBOutlet UILabel *screenName;


@property (strong, nonatomic) IBOutlet UILabel *emailID;




@end

@implementation EL_settingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app=[[UIApplication sharedApplication]delegate];
    // Do any additional setup after loading the view.
    
    _emailID.adjustsFontSizeToFitWidth=YES;
    _userName.adjustsFontSizeToFitWidth=YES;
    _screenName.adjustsFontSizeToFitWidth=YES;
    
    _userName.text=app.userName;
    
    _screenName.text=app.screenName;
    
    _emailID.text=app.emailID;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backToPrev:(id)sender {
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
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
