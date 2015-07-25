//
//  ELDirectLoginController.m
//  EzyLog
//
//  Created by Somenath on 15/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELDirectLoginController.h"
#import "RS_JsonClass.h"
#import "AppDelegate.h"

@interface ELDirectLoginController () <UITextFieldDelegate>

{

    AppDelegate *app;

}


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ELDirectLoginController

@synthesize spinner;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    spinner.hidden=YES;
    
    app=[[UIApplication sharedApplication]delegate];
    
    // Do any additional setup after loading the view.
    
    UIColor *color = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    self.id_txt.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    self.id_txt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"ID" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.password_txt.textColor = [UIColor colorWithRed:102.0f/102.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    self.password_txt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)Loginclk:(id)sender
{
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    if (globalobj.connectedToNetwork == YES)
    {
        
        if ([_id_txt.text isEqualToString:@""])
        {
            _id_txt.placeholder=@"Please enter email !";
        }
        else if (![ self NSStringIsValidEmail:_id_txt.text])
        {
            
            UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:nil message:@"Not a valid email !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [loginAlert show];
        }
        else if ([_id_txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
        {
            _id_txt.placeholder=@"Email should not have blank space !";
        }
        else if ([_password_txt.text isEqualToString:@""])
        {
            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Password can not be blank !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [Alert show];
            
        }
        else
        {
            spinner.hidden=NO;
            
            spinner.color=[UIColor greenColor];
            
            [spinner startAnimating];
            
            //_login_btn.userInteractionEnabled=NO;
            
            [_id_txt resignFirstResponder];
            [_password_txt resignFirstResponder];
            
            NSString *urlstring=[NSString stringWithFormat:@"http://www.esolz.co.in/lab9/ezylog/iosapp/login.php"];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
            
            [request setHTTPMethod:@"POST"];
            
            NSString *postData = [NSString stringWithFormat:@"email=%@&password=%@",_id_txt.text,_password_txt.text];
            
            NSLog(@"User ID: %@",_id_txt.text);
            NSLog(@"Password... %@",_password_txt.text);
            
            [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
            
            [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
             {
                 if(result)
                 {
                     NSLog(@"result...%@",[result objectForKey:@"status"]);
                     if([[result objectForKey:@"status"] isEqualToString:@"login success"])
                     {
                         NSMutableDictionary *get_result=[[result objectForKey:@"details" ]mutableCopy];
                         
                         NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
                         
                        [UserData setObject:[get_result objectForKey:@"id"] forKey:@"Login_User_id"];
                         
                        [UserData setObject:[get_result objectForKey:@"first_name"] forKey:@"User_name"];
                         [UserData setObject:[get_result objectForKey:@"phone"] forKey:@"user_phone"];
                         
                         [UserData setObject:[get_result objectForKey:@"dob"] forKey:@"user_dob"];
                         
                         
                         app.userID=[get_result objectForKey:@"id"];
                         
                         app.userName=[NSString stringWithFormat:@"%@ %@",[get_result objectForKey:@"first_name"],[get_result objectForKey:@"last_name"]];
                         app.emailID=[get_result objectForKey:@"email"];
                         app.screenName=[get_result objectForKey:@"screen_name"];
                         
                         NSLog(@"User id in appdelegate: %@",app.userID);
                        
                         [spinner stopAnimating];
                         
//                         [UserData setObject:[get_result objectForKey:@"business"] forKey:@"user_business"];
//                         [UserData setObject:[get_result objectForKey:@"about"] forKey:@"user_about"];
                         
                         [UserData synchronize];
//                         ViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Main_Page"];
//                         [self.navigationController pushViewController:Pushobj animated:YES];
                         
            ELDirectLoginController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
            [self.navigationController pushViewController:obj animated:YES];
                     }
                     else
                     {
                         spinner.hidden=YES;
                         
                         UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Login Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                         [Alert show];
                         
                         _login_btn.userInteractionEnabled=YES;
                         // _email.text = @"";
                         _password_txt.text = @"";
                     }
                 }
                 
             }];
            
            
            
        }
        
    }
    
    
    
}


- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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
