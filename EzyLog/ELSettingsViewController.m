//
//  ELSettingsViewController.m
//  EzyLog
//
//  Created by IOS2 on 06/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELSettingsViewController.h"
#import "ELPrivacyViewController.h"
#import "SummaryAwardsViewController.h"

@interface ELSettingsViewController ()


@property (strong, nonatomic) IBOutlet UILabel *priVacyLbl;

@property (strong, nonatomic) IBOutlet UIButton *priVacyBtn;

@end

@implementation ELSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_priVacyBtn addTarget:self action:@selector(goToPrivacyPage) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)goToPrivacyPage
{

    ELPrivacyViewController *privacyVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"privacy"];
    
    [self.navigationController pushViewController:privacyVC animated:YES];
    

}

//summaryawards


- (IBAction)back:(id)sender
{
    
    
    SummaryAwardsViewController *summaryVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"summaryawards"];
    
    [self.navigationController pushViewController:summaryVC animated:YES];

    
    
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
