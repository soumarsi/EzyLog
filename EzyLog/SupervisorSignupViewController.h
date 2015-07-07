//
//  SupervisorSignupViewController.h
//  EzyLog
//
//  Created by Soumen on 16/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupervisorSignupViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *supervisorsignupscroller;
@property (strong, nonatomic) IBOutlet UITextField *fname;
@property (strong, nonatomic) IBOutlet UITextField *lname;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *postcode;
@property (strong, nonatomic) IBOutlet UITextField *licenceno;
@property (strong, nonatomic) IBOutlet UITextField *insno;
- (IBAction)datebutton1day:(id)sender;
- (IBAction)datebutton1month:(id)sender;
- (IBAction)datebutton1year:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dobday1;
@property (weak, nonatomic) IBOutlet UILabel *dobmonth1;
@property (weak, nonatomic) IBOutlet UILabel *dobyear1;
- (IBAction)licenceday:(id)sender;
- (IBAction)licencemonth:(id)sender;
- (IBAction)licenceyear:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *licencedaylabel;
@property (weak, nonatomic) IBOutlet UILabel *licencemonthlabel;
@property (weak, nonatomic) IBOutlet UILabel *licenceyearlabel;
- (IBAction)drivinginstructoryes:(id)sender;
- (IBAction)drivinginstructorno:(id)sender;

@property (weak,nonatomic) IBOutlet UIButton *drivinginstructoryes;
@property (weak,nonatomic) IBOutlet UIButton * drivinginstructorno;

@end
