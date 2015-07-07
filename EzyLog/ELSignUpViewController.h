//
//  SignUpViewController.h
//  EzyLog
//
//  Created by Soumen on 15/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELSignUpViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *signupscroller;
@property (strong, nonatomic) IBOutlet UITextField *fname;
@property (strong, nonatomic) IBOutlet UITextField *lname;
@property (strong, nonatomic) IBOutlet UITextField *phno;
@property (strong, nonatomic) IBOutlet UITextField *screennm;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *pass;
@property (strong, nonatomic) IBOutlet UITextField *learnerpermitno;
@property (strong, nonatomic) IBOutlet UITextField *postcode;
@property (weak, nonatomic) IBOutlet UILabel *daylbl;
@property (weak, nonatomic) IBOutlet UILabel *monthlbl;
@property (weak, nonatomic) IBOutlet UILabel *yearlbl;

@property (weak, nonatomic) IBOutlet UILabel *day2lbl;

@property (weak, nonatomic) IBOutlet UILabel *month2lbl;
@property (weak, nonatomic) IBOutlet UILabel *year2lbl;
@property (weak, nonatomic) IBOutlet UIButton *day1btn;
@property (weak, nonatomic) IBOutlet UIButton *month1btn;

@property (weak, nonatomic) IBOutlet UIButton *year1btn;
@property (weak, nonatomic) IBOutlet UIButton *day2btn;
@property (weak, nonatomic) IBOutlet UIButton *month2btn;
@property (weak, nonatomic) IBOutlet UIButton *year2btn;
@property (weak, nonatomic) IBOutlet UILabel *statelbl;//state label

//signup variables

@property(nonatomic,strong)NSURLConnection *connection;
@property (nonatomic,strong)NSMutableData *buffer;
@property (nonatomic ,strong) NSString *url;
@property(nonatomic,strong)NSString *dob;
@property(nonatomic ,strong)NSMutableDictionary *jsonResult;
@property(nonatomic ,strong)NSMutableURLRequest *request;
@property(nonatomic,strong)NSString *permitExp;


@end
