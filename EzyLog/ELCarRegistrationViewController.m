//
//  ELCarRegistrationViewController.m
//  EzyLog
//
//  Created by Soumen on 17/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELCarRegistrationViewController.h"

@interface ELCarRegistrationViewController ()

@end

@implementation ELCarRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    self.carregno.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Car Registration Number" attributes:@{NSForegroundColorAttributeName: color}];
    self.carregno.delegate=self;
    self.carregno.autocorrectionType = UITextAutocorrectionTypeNo;
    // Do any additional setup after loading the view.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backtoprev:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registercar:(id)sender
{
    ELCarRegistrationViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
    [self.navigationController pushViewController:login animated:YES];

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
