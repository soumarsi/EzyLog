//
//  SupervisorSignupViewController.m
//  EzyLog
//
//  Created by Soumen on 16/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "SupervisorSignupViewController.h"
#import "ELSupervisorSignatureViewController.h"
#import "RS_JsonClass.h"
#import "ELDriveSetUpViewController.h"
#import "AppDelegate.h"

@interface SupervisorSignupViewController ()<NSURLConnectionDelegate>
{
    UIView *myview;
    UIDatePicker* picker;
    NSString *dobday;
    NSString *dobmon;
    NSString *dobyear;
    int dob;
    int licen;
    NSString *licencedinst;
    //NSMutableURLRequest *request;
    NSURLConnection *connection;
    NSMutableData *buffer;
    NSMutableDictionary *finaldata;
    BOOL btncolor;
    NSString *chkingdata;
    int buttontap;
     NSString *finaldate;
     NSString *licence;
    //NSMutableDictionary *result;
    NSUserDefaults *defaults;
    
    
    NSString *strday;
    NSString *strmon;
    NSString *stryear;
    
    //
    UIButton *btn;
    
    UIButton *btn1;
    
    UIButton *buttonForDatePicker;
    
    //
    BOOL datePicked;
    
    //
    
    AppDelegate *app;
    
}

@end

@implementation SupervisorSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app=[[UIApplication sharedApplication]delegate];
    
    
    //
    
    datePicked=NO;
    
    
        
    NSLog(@"user id is %@...",app.userID);
    
    
    
    [_supervisorsignupscroller setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 959.0f)];
    
    _supervisorsignupscroller.delegate=self;
    UIColor *color = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    self.fname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.lname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    self.postcode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Post Code/Zip Code" attributes:@{NSForegroundColorAttributeName: color}];
    self.licenceno.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Licence Number" attributes:@{NSForegroundColorAttributeName: color}];
    self.insno.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Instructor Number" attributes:@{NSForegroundColorAttributeName: color}];
    self.postcode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Post Code" attributes:@{NSForegroundColorAttributeName: color}];

    _fname.delegate=self;
    _lname.delegate=self;
    _email.delegate=self;
    _postcode.delegate=self;
    _insno.delegate=self;
    _licenceno.delegate=self;
    
    //hiding the keyboard text suggestion
    _fname.autocorrectionType = UITextAutocorrectionTypeNo;
    _lname.autocorrectionType = UITextAutocorrectionTypeNo;
    _email.autocorrectionType = UITextAutocorrectionTypeNo;
    _postcode.autocorrectionType = UITextAutocorrectionTypeNo;
    _insno.autocorrectionType = UITextAutocorrectionTypeNo;
    _licenceno.autocorrectionType = UITextAutocorrectionTypeNo;
    dob=10;
    licen=20;
    buttontap=0;
    btncolor=false;
    //result=[[NSMutableDictionary alloc]init];
     defaults=[[NSUserDefaults alloc] init];
    
//    NSString *name=[[NSUserDefaults standardUserDefaults] objectForKey:@"first_name"];
//    NSLog(@"%@",name);
    
    
    // Do any additional setup after loading the view.
}



-(void)monthString
{
    if ([strmon isEqualToString:@"1"]) {
        strmon=@"Jan";
    }
    else if ([strmon isEqualToString:@"2"])
    {
        strmon=@"Feb";
    }
    else if ([strmon isEqualToString:@"3"])
    {
        strmon=@"Mar";
    }
    else if ([strmon isEqualToString:@"4"])
    {
        strmon=@"Apr";
    }
    else if ([strmon isEqualToString:@"5"])
    {
        strmon=@"May";
    }
    else if ([strmon isEqualToString:@"6"])
    {
        strmon=@"Jun";
    }
    else if ([strmon isEqualToString:@"7"])
    {
        strmon=@"Jul";
    }
    else if ([strmon isEqualToString:@"8"])
    {
        strmon=@"Aug";
    }
    else if ([strmon isEqualToString:@"9"])
    {
        strmon=@"Sep";
    }
    else if ([strmon isEqualToString:@"10"])
    {
        strmon=@"Oct";
    }
    else if ([strmon isEqualToString:@"11"])
    {
        strmon=@"Nov";
    }
    else if ([strmon isEqualToString:@"12"])
    {
        strmon=@"Dec";
    }
    
}


- (IBAction)Registerclk:(id)sender
{
    //ELSupervisorSignatureViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SuperSignature_Page"];
   // [self.navigationController pushViewController:obj animated:YES];
    [_insno resignFirstResponder];
    
    
    if ([self TarminateWhiteSpace:_fname.text].length==0)
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you can't left First Name field blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
    else if ([self TarminateWhiteSpace:_lname.text].length==0)
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you can't left Last Name field blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
    else if ([self Emailtest:_email.text])
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Enter proper mail-id" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
    else if (_postcode.text.length==0)
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you can't left Post Code field blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
    else if ([_dobday1.text isEqualToString:@""])
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you can't left Date of Birth field blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
    //_licencedaylabel
    
    else if ([_licencedaylabel.text isEqualToString:@""])
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you can't left Expiry Date of Lisence field blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
    
    
    
    
    else if (_licenceno.text.length==0)
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you can't left Licence Number field blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
//    else if (chkingdata==NULL)
//    {
//        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you can't left Expiry date Licence field blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alertreg show];
//    }
    else if (buttontap==0)
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please select Supevisor Driving Instructor  yes or no" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
    else if (_insno.text.length==0)
    {
        UIAlertView *alertreg=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you can't left  Instructor number field blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertreg show];
    }
    else
    {
        NSLog(@"%@",finaldate);
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        //NSURL *url=[NSURL URLWithString:@"http://www.esolz.co.in/lab9/ezylog/iosapp/supervisor_registration.php?"];
        NSString *urlstring=[NSString stringWithFormat:@"http://www.esolz.co.in/lab9/ezylog/iosapp/supervisor_registration.php?"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        [request setHTTPMethod:@"POST"];
        NSString *postData = [NSString stringWithFormat:@"driver_id=%@&first_name=%@&last_name=%@&dob=%@&email=%@&password=%d&post_code=%@&licence_no=%@&licence_expiry=%@&licenced_instructor=%@&instructor_no=%@",app.userID,[_fname text],[_lname text],finaldate,[_email text],344343,[_postcode text],[_licenceno text],licence,licencedinst,[_insno text]];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        
        [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             if(result)
             {
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
                     
                     
//                     ELDriveSetUpViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Setup"];
//                     [self.navigationController pushViewController:obj animated:YES];
                     
                     
                     
                     
                     ELSupervisorSignatureViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SuperSignature_Page"];
                      [self.navigationController pushViewController:obj animated:YES];
                     
                     
                 }
                 else
                 {
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"status"] message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                     
                     [alert show];
                 }
             }
         }];


//    
//        NSString *post =[[NSString alloc] initWithFormat:@"first_name=%@&last_name=%@&dob=%@&email=%@&password=%d&post_code=%@&licence_no=%@&licence_expiry=%@&licenced_instructor=%@&instructor_no=%@",[_fname text],[_lname text],finaldate,[_email text],344343,[_postcode text],[_licenceno text],licence,licencedinst,[_insno text]];
//        NSLog(@"PostData: %@",post);
//        
//        request = [NSMutableURLRequest requestWithURL:url];
//    
//        connection = [[NSURLConnection alloc ]initWithRequest:request delegate:self];
//    
//    
//    
//        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    
//    
//    
//        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
//    
//    
//    
//    // NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    
//        [request setURL:url];
//    
//        [request setHTTPMethod:@"POST"];
//    
//        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    
//        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    
//        [request setHTTPBody:postData];
//        
        
    }
    

    
}

//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//
//{
//    
//    connection= nil;
//    
//    buffer= nil;
//    NSLog(@"Error: %@",[error localizedDescription]);
//    NSLog(@"Connection failed! Error - %@ %@",
//          [error localizedDescription],
//    
//          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
//    
//    NSLog(@"connectionssssssss...lost");
//
//}
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//
//{
//    
//    [buffer setLength:0];
//    
//    NSLog(@"didReceiveResponse");
//    
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//
//{
//    
//    [buffer appendData:data];
//    NSLog(@"Data Loading....wait");
//}
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//
//{
//    
//    NSLog(@"connectionDidFinishLoading");
//    NSError *error = [[NSError alloc] init];
//    NSHTTPURLResponse *response = nil;
//    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSLog(@"Response code: %ld", (long)[response statusCode]);
//    
//    if ([response statusCode] >=200 && [response statusCode] <300)
//        
//    {
//        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
//        NSLog(@"Response ==> %@", responseData);
//        finaldata = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];
//        NSLog(@"jsonresult...............%@",finaldata);
//        result=[finaldata objectForKey:@"details"];
//        NSLog(@"%@",result);
//        [defaults setValue:[result valueForKey:@"dob"]  forKey:@"dob"];
//        [defaults setValue:[result valueForKey:@"email"] forKey:@"email"];
//        [defaults setValue:[result valueForKey:@"first_name"] forKey:@"first_name"];
//        [defaults setValue:[result valueForKey:@"id"] forKey:@"id"];
//        [defaults setValue:[result valueForKey:@"instructor_no"] forKey:@"instructor_no"];
//        [defaults setValue:[result valueForKey:@"last_name"] forKey:@"last_name"];
//        [defaults setValue:[result valueForKey:@"licence_expiry"] forKey:@"licence_expiry"];
//         [defaults setValue:[result valueForKey:@"licence_no"] forKey:@"licence_no"];
//        [defaults setValue:[result valueForKey:@"licenced_instructor"] forKey:@"licenced_instructor"];
//        [defaults setValue:[result valueForKey:@"post_code"] forKey:@"post_code"];
//        [defaults setValue:[result valueForKey:@"register_date"] forKey:@"register_date"];
//        NSLog(@"data store in userdefaults");
//        [defaults synchronize];
//    }
//    
//}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backclk:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    if(textField==_insno)
    {
        [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f, 200.0f) animated:YES];
    }
    
    
    return  YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==_licenceno)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f, 300.0f) animated:YES];
    }
    if(textField==_fname)
    {
        [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    }
    if(textField==_lname)
    {
        [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    }
    if(textField==_email)
    {
        [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    }
    if(textField==_postcode)
    {
        [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    }
    if(textField==_insno)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f, 400.0f) animated:YES];
    }
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{


    NSLog(@"Screen height...%f",[UIScreen mainScreen].bounds.size.height);
    NSLog(@"Scrool offset.y....%f",scrollView.contentOffset.y);
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)datebutton1day:(id)sender
{
    buttonForDatePicker=(UIButton *)(id)sender;
    
    [_postcode resignFirstResponder];
    [_licenceno resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    dob=1;
    [self OpenDatePicker];
}

- (IBAction)datebutton1month:(id)sender
{
    
    buttonForDatePicker=(UIButton *)(id)sender;
    [_postcode resignFirstResponder];
    [_licenceno resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    dob=1;
    [self OpenDatePicker];
}

- (IBAction)datebutton1year:(id)sender
{
    buttonForDatePicker=(UIButton *)(id)sender;
    
    [_postcode resignFirstResponder];
    [_licenceno resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    dob=1;
    [self OpenDatePicker];
}

-(void)OpenDatePicker
{
    [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,290.0f) animated:YES];
    
   // myview = [[UIView alloc] initWithFrame:CGRectMake(0,630,375,270)];
    
     myview = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-(self.view.bounds.size.height/2.47),self.view.bounds.size.width,self.view.bounds.size.height/2.47)];
    
     [self.view addSubview:myview];
    
    [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
    
    
    picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,myview.bounds.size.height-42)];
    [myview addSubview:picker];

    
    
    //UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,225,187,42)];
    
     btn=[[UIButton alloc]initWithFrame:CGRectMake(0,myview.bounds.size.height-42,self.view.bounds.size.width/2,42)];
    
    btn.backgroundColor=[UIColor colorWithRed:(100.0f/255.0f) green:(179.0f/255.0f) blue:(25.0f/255.0f) alpha:1];
    [btn setTitle: @"OK" forState: UIControlStateNormal];
    [myview addSubview:btn];
    
    btn1=[[UIButton alloc]initWithFrame:CGRectMake(187,225,188,42)];
    
    btn1=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2,myview.bounds.size.height-42,self.view.bounds.size.width/2,42)];
    
    btn1.backgroundColor=[UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:1];
    [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
    [myview addSubview:btn1];
    
   // [_supervisorsignupscroller addSubview:myview];
    
    
    [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,buttonForDatePicker.frame.origin.y-30) animated:YES];
    
    _supervisorsignupscroller.scrollEnabled=NO;
    
   
    
    //[picker setBackgroundColor: [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1]];
     picker.datePickerMode=UIDatePickerModeDate;
    picker.date=[NSDate date];
    if (dob==1) {
        dob=0;
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [btn1 addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (licen==2) {
        licen=0;
        [picker addTarget:self action:@selector(LabelTitle2:) forControlEvents:UIControlEventValueChanged];
        [btn1 addTarget:self action:@selector(buttoncross2:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonInfo4:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

-(void)buttoncross:(id)sender
{
    _supervisorsignupscroller.scrollEnabled=YES;
    
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         //[_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,220.0f)];
                         
                         
                         if([UIScreen mainScreen].bounds.size.height==568)
                             
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,235) animated:YES];
                         
                         
                         else if([UIScreen mainScreen].bounds.size.height==667)
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,160) animated:YES];
                         
                         else if([UIScreen mainScreen].bounds.size.height==480)
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,300) animated:YES];

                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
//    _dobday1.text=NULL;
//    _dobmonth1.text=NULL;
//    _dobyear1.text=NULL;
    
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    [picker resignFirstResponder];

    
}

-(void)buttonInfo:(id)sender
{
    _supervisorsignupscroller.scrollEnabled=YES;
    
    
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         
                         if(datePicked==NO)
                         {
                             
                             
                             NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
                             
                             NSInteger Day = [components day];
                             NSInteger month = [components month];
                             NSInteger year = [components year];
                             
                             strday=[NSString stringWithFormat:@"%ld",(long)Day];
                             strmon=[NSString stringWithFormat:@"%ld",(long)month];
                             [self monthString];
                             stryear=[NSString stringWithFormat:@"%ld",(long)year];
                             
                             NSLog(@"Day: %@ Month %@ Year %@",strday,strmon,stryear);
                             
                             //                            // strday = [strday substringWithRange:NSMakeRange(4,2)];
                             //                             strmon = [strmon substringWithRange:NSMakeRange(0,3)];
                             //                             stryear = [stryear substringWithRange:NSMakeRange(7,4)];
                             
                             
                             _dobday1.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _dobday1.text=strday;
                             
                             _dobmonth1.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _dobmonth1.text=strmon;
                             
                             _dobyear1.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _dobyear1.text=stryear;
                             
                             
                             
                             
                             
                         }
                         
                         
                         
                         
                         else{
                         _dobday1.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _dobday1.text=dobday;
                         
                         _dobmonth1.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _dobmonth1.text=dobmon;
                         
                         _dobyear1.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _dobyear1.text=dobyear;
                         }
                         
                        
                         if([UIScreen mainScreen].bounds.size.height==568)
                             
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,235) animated:YES];
                         
                         else if([UIScreen mainScreen].bounds.size.height==667)
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,160) animated:YES];
                         
                         else if([UIScreen mainScreen].bounds.size.height==480)
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,300) animated:YES];
                         
                         
                     
                         
                     
                     
                     
                     }
                     completion:^(BOOL finished){
                         
                         [self monthchk];
                         finaldate=[NSString stringWithFormat:@"%@-%@-%@",dobmon,dobday,dobyear];
                         NSLog(@"%@",finaldate);
                     }
     ];
    
    
    self.navigationItem.rightBarButtonItem=nil;
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    
}


-(void)monthchk
{
    if ([dobmon isEqualToString:@"Jan"]) {
        dobmon=@"1";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Feb"]) {
        dobmon=@"2";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Mar"]) {
        dobmon=@"3";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Apr"]) {
        dobmon=@"4";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"May"]) {
        dobmon=@"5";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Jun"]) {
        dobmon=@"6";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Jul"]) {
        dobmon=@"7";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Aug"]) {
        dobmon=@"8";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Sep"]) {
        dobmon=@"9";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Oct"]) {
        dobmon=@"10";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Nov"]) {
        dobmon=@"11";
        NSLog(@"%@",dobmon);
    }
    else if ([dobmon isEqualToString:@"Dec"]) {
        dobmon=@"12";
        NSLog(@"%@",dobmon);
    }
    
}


-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MMM/dd/yyyy"];
    dobday=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    dobmon=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    dobyear=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    dobday = [dobday substringWithRange:NSMakeRange(4,2)];
    dobmon = [dobmon substringWithRange:NSMakeRange(0,3)];
    dobyear = [dobyear substringWithRange:NSMakeRange(7,4)];
    
    datePicked=YES;
    
    //NSLog(@"Date....%@",strday);
    
    //[picker removeFromSuperview];
}



- (IBAction)licenceday:(id)sender
{
    buttonForDatePicker=(UIButton *)(id)sender;
    
    [_licenceno resignFirstResponder];
    [_insno resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    licen=2;
    [self OpenDatePicker];
}

- (IBAction)licencemonth:(id)sender
{
    buttonForDatePicker=(UIButton *)(id)sender;
    
    [_licenceno resignFirstResponder];
    [_insno resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    licen=2;
    [self OpenDatePicker];
}

- (IBAction)licenceyear:(id)sender
{
    buttonForDatePicker=(UIButton *)(id)sender;
    
    [_licenceno resignFirstResponder];
    [_insno resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    licen=2;
    [self OpenDatePicker];
}

-(void)LabelTitle2:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MMM/dd/yyyy"];
    dobday=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    dobmon=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    dobyear=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    dobday = [dobday substringWithRange:NSMakeRange(4,2)];
    dobmon = [dobmon substringWithRange:NSMakeRange(0,3)];
    dobyear = [dobyear substringWithRange:NSMakeRange(7,4)];
    
    datePicked=YES;
    
}


-(void)buttoncross2:(id)sender
{
    
    _supervisorsignupscroller.scrollEnabled=YES;
    
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                        
                         
                         if([UIScreen mainScreen].bounds.size.height==568)
                             
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,235) animated:YES];
                         
                         else if([UIScreen mainScreen].bounds.size.height==667)
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,160) animated:YES];
                         
                         else if([UIScreen mainScreen].bounds.size.height==480)
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,300) animated:YES];
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
//    _licencedaylabel.text=NULL;
//    _licencemonthlabel.text=NULL;
//    _licenceyearlabel.text=NULL;
    
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}

-(void)buttonInfo4:(id)sender
{
    
    _supervisorsignupscroller.scrollEnabled=YES;
    
    
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         
                         
                         if(datePicked==NO)
                         {
                         
                         
                             NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
                             
                             NSInteger Day = [components day];
                             NSInteger month = [components month];
                             NSInteger year = [components year];
                             
                             strday=[NSString stringWithFormat:@"%ld",(long)Day];
                             strmon=[NSString stringWithFormat:@"%ld",(long)month];
                             [self monthString];
                             stryear=[NSString stringWithFormat:@"%ld",(long)year];
                             
                             NSLog(@"Day: %@ Month %@ Year %@",strday,strmon,stryear);
                             
                             //                            // strday = [strday substringWithRange:NSMakeRange(4,2)];
                             //                             strmon = [strmon substringWithRange:NSMakeRange(0,3)];
                             //                             stryear = [stryear substringWithRange:NSMakeRange(7,4)];
                             
                             
                              _licencedaylabel.font = [UIFont fontWithName:@"OpenSans" size:14];
                              _licencedaylabel.text=strday;
                             
                             _licencemonthlabel.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _licencemonthlabel.text=strmon;
                             
                             _licenceyearlabel.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _licenceyearlabel.text=stryear;

                             
                             NSLog(@"Lisence Exp Day: %@ Month %@ Year %@",_licencedaylabel.text,_licencemonthlabel.text,_licenceyearlabel.text);
                         
                         
                         }
                         
                         
                         
                         else{
                         
                         
                         
                         _licencedaylabel.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _licencedaylabel.text=dobday;
                         
                         _licencemonthlabel.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _licencemonthlabel.text=dobmon;
                         
                         _licenceyearlabel.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _licenceyearlabel.text=dobyear;
                         
                         chkingdata=dobmon;
                             
                             
                         }
                         
                         //
                         
                         
                         if([UIScreen mainScreen].bounds.size.height==568)
                             
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,235) animated:YES];
                         
                         else if([UIScreen mainScreen].bounds.size.height==667)
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,160) animated:YES];
                         
                         else if([UIScreen mainScreen].bounds.size.height==480)
                             [_supervisorsignupscroller setContentOffset:CGPointMake(0.0f,300) animated:YES];
                         
                         
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         [self monthchk];
                         licence=[NSString stringWithFormat:@"%@-%@-%@",dobyear,dobmon,dobday];
                         NSLog(@"%@",licence);
                     }
     ];
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}





- (IBAction)drivinginstructoryes:(id)sender
{
    buttontap=1;
    if (btncolor==false)
    {
        licencedinst=@"Y";
        NSLog(@"%@",licencedinst);
        _drivinginstructoryes.backgroundColor=[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:34.0/255.0 alpha:1];
        btncolor=true;
        _drivinginstructorno.backgroundColor=[UIColor clearColor];
    }
    else
    {
        
        licencedinst=@"Y";
        NSLog(@"%@",licencedinst);
        _drivinginstructoryes.backgroundColor=[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:34.0/255.0 alpha:1];
        btncolor=true;
        _drivinginstructorno.backgroundColor=[UIColor clearColor];
    }
    
    
}

- (IBAction)drivinginstructorno:(id)sender
{
    buttontap=1;
    if (btncolor==false) {
        licencedinst=@"N";
        NSLog(@"%@",licencedinst);
        _drivinginstructorno.backgroundColor=[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:34.0/255.0 alpha:1];
        _drivinginstructoryes.backgroundColor=[UIColor clearColor];
        
    }
    else
    {
        licencedinst=@"N";
        NSLog(@"%@",licencedinst);
        _drivinginstructorno.backgroundColor=[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:34.0/255.0 alpha:1];
        _drivinginstructoryes.backgroundColor=[UIColor clearColor];
    }
    
}


-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}


-(BOOL)Emailtest:(NSString *)Email
{
    NSString *regex = @"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![emailPredicate evaluateWithObject:Email])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
