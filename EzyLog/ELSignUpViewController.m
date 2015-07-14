//
//  SignUpViewController.m
//  EzyLog
//
//  Created by Soumen on 15/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELSignUpViewController.h"
#import "RS_JsonClass.h"
#import "AppDelegate.h"
#import "ELLearnerSignatureViewController.h"

@interface ELSignUpViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIDatePicker* picker;
    UIView *myview;
    NSInteger flag1;
    NSArray *myarr;
    UIPickerView *mypicker;
    NSString *strday;
    NSString *strmon;
    NSString *stryear;
    NSString *ww;
    NSString *check;
    
    
    BOOL statePickerOpened;
    
    BOOL datePicked;
    
    UIButton *buttonForDatePicker;
    
    //buttons with picker
    
    UIButton *btn;
    
    UIButton *btn1;
    
}

@property (strong, nonatomic) IBOutlet UIButton *sgnUpBtn;

@property (strong, nonatomic) IBOutlet UIImageView *expDayBack;

@property (strong, nonatomic) IBOutlet UIImageView *expMnthBack;

@property (strong, nonatomic) IBOutlet UIImageView *expYrBack;

//

@property (strong, nonatomic) IBOutlet UIImageView *dayBack;

@property (strong, nonatomic) IBOutlet UIImageView *monthBack;

@property (strong, nonatomic) IBOutlet UIImageView *yearBack;







@property (strong, nonatomic) IBOutlet UIImageView *agreeTextFooter;
@end

@implementation ELSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    strday=@"";
    strmon=@"";
    stryear=@"";
    
    _signupscroller.delegate=self;
    
    statePickerOpened=NO;
    
    datePicked=NO;
    
    flag1=0;
    
    mypicker.delegate=self;
    mypicker.dataSource=self;
    
    [_signupscroller setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,938.0f)];
    UIColor *color = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    self.fname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.lname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    self.phno.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName: color}];
    self.screennm.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Screen Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.pass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.postcode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Post Code" attributes:@{NSForegroundColorAttributeName: color}];
    self.learnerpermitno.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Learner Permit Number" attributes:@{NSForegroundColorAttributeName: color}];
    _fname.delegate=self;
    _lname.delegate=self;
    _email.delegate=self;
    _phno.delegate=self;
    _screennm.delegate=self;
    _pass.delegate=self;
    _learnerpermitno.delegate=self;
    _postcode.delegate=self;
    
    
    //hiding the keyboard text suggestion
    _fname.autocorrectionType = UITextAutocorrectionTypeNo;
    _lname.autocorrectionType = UITextAutocorrectionTypeNo;
    _email.autocorrectionType = UITextAutocorrectionTypeNo;
    _phno.autocorrectionType = UITextAutocorrectionTypeNo;
    _screennm.autocorrectionType = UITextAutocorrectionTypeNo;
    _pass.autocorrectionType = UITextAutocorrectionTypeNo;
    _learnerpermitno.autocorrectionType = UITextAutocorrectionTypeNo;
    _postcode.autocorrectionType = UITextAutocorrectionTypeNo;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DatePickerDayBtn:(id)sender
{
    
    if(statePickerOpened==NO)
    {
    
    [_screennm resignFirstResponder];
    [_learnerpermitno resignFirstResponder];
    [_postcode resignFirstResponder];
    [_pass resignFirstResponder];
    [_email resignFirstResponder];
    [_fname resignFirstResponder];
    [_lname resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    _day1btn.tag=1;
        
        buttonForDatePicker=(UIButton *)(id)sender;
    [self OpenDatePicker];
        
    }
    
    
}


- (IBAction)DatePickerMonthBtn:(id)sender
{
    if(statePickerOpened==NO)
    {
    
    
    [_screennm resignFirstResponder];
    [_learnerpermitno resignFirstResponder];
    [_postcode resignFirstResponder];
    [_pass resignFirstResponder];
    [_email resignFirstResponder];
    [_fname resignFirstResponder];
    [_lname resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    _month1btn.tag=1;
        buttonForDatePicker=(UIButton *)(id)sender;
    [self OpenDatePicker];
   }
}

- (IBAction)DatePickerYearBtn:(id)sender
{
    if(statePickerOpened==NO)
    {
    
    
    [_screennm resignFirstResponder];
    [_learnerpermitno resignFirstResponder];
    [_postcode resignFirstResponder];
    [_pass resignFirstResponder];
    [_email resignFirstResponder];
    [_fname resignFirstResponder];
    [_lname resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    _year1btn.tag=1;
        buttonForDatePicker=(UIButton *)(id)sender;
    [self OpenDatePicker];
        
    }
}

- (IBAction)DatePickerDayBtn2:(id)sender
{
    if(statePickerOpened==NO)
    {
    
    
    [_screennm resignFirstResponder];
    [_learnerpermitno resignFirstResponder];
    [_postcode resignFirstResponder];
    [_pass resignFirstResponder];
    [_email resignFirstResponder];
    [_fname resignFirstResponder];
    [_lname resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    _day2btn.tag=1;
        buttonForDatePicker=(UIButton *)(id)sender;
    [self OpenDatePicker];
        
        
    }
    
    
}
- (IBAction)DatePickerMonthBtn2:(id)sender
{
    
    if(statePickerOpened==NO)
    {
    [_screennm resignFirstResponder];
    [_learnerpermitno resignFirstResponder];
    [_postcode resignFirstResponder];
    [_pass resignFirstResponder];
    [_email resignFirstResponder];
    [_fname resignFirstResponder];
    [_lname resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    _month2btn.tag=1;
        buttonForDatePicker=(UIButton *)(id)sender;
    [self OpenDatePicker];
    }
    
}
- (IBAction)DatePickerYearBtn2:(id)sender
{
    
    if(statePickerOpened==NO)
    {
    [_screennm resignFirstResponder];
    [_learnerpermitno resignFirstResponder];
    [_postcode resignFirstResponder];
    [_pass resignFirstResponder];
    [_email resignFirstResponder];
    [_fname resignFirstResponder];
    [_lname resignFirstResponder];
    [picker resignFirstResponder];
    [myview removeFromSuperview];
    _year2btn.tag=1;
        buttonForDatePicker=(UIButton *)(id)sender;
    [self OpenDatePicker];
    }
    
}


-(void)OpenDatePicker
{
   if(statePickerOpened==NO)
   {
       
       NSLog(@"Open date picker...");
    
    myview = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-(self.view.bounds.size.height/2.47),self.view.bounds.size.width,self.view.bounds.size.height/2.47)];
    
    [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
       
       [self.view addSubview:myview];
    
   // [_signupscroller addSubview:myview];
    
    
    
   //[myview setBackgroundColor:[UIColor blackColor]];
    
    
    picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,myview.bounds.size.height-42)];
    [myview addSubview:picker];
    
    //[picker setBackgroundColor:[UIColor clearColor]];
    //[picker setBackgroundColor: [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1]];
    
    picker.datePickerMode=UIDatePickerModeDate;
    //    picker.hidden=NO;
    picker.date=[NSDate date];
    
    
    
    btn=[[UIButton alloc]initWithFrame:CGRectMake(0,myview.bounds.size.height-42,self.view.bounds.size.width/2,42)];
    
    btn.backgroundColor=[UIColor colorWithRed:(100.0f/255.0f) green:(179.0f/255.0f) blue:(25.0f/255.0f) alpha:1];
    
    [btn setTitle: @"OK" forState: UIControlStateNormal];
    [myview addSubview:btn];
    
    btn1=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2,myview.frame.size.height-42,self.view.bounds.size.width/2,42)];
    btn1.backgroundColor=[UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:1];
    [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
    [myview addSubview:btn1];
    
 /*
    if([[UIScreen mainScreen] bounds].size.height==667)
    
       [_signupscroller setContentOffset:CGPointMake(0.0f,myview.frame.origin.y-myview.bounds.size.height-67) animated:YES];

    else if([[UIScreen mainScreen] bounds].size.height==568)
        
        [_signupscroller setContentOffset:CGPointMake(0.0f,myview.frame.origin.y-myview.bounds.size.height-48) animated:YES];
    
    else if([[UIScreen mainScreen] bounds].size.height==480)
        
        [_signupscroller setContentOffset:CGPointMake(0.0f,myview.frame.origin.y-myview.bounds.size.height-32) animated:YES];
    

   */
       
       
    
    [_signupscroller setContentOffset:CGPointMake(0.0f,buttonForDatePicker.frame.origin.y-30) animated:YES];
       
       _signupscroller.scrollEnabled=NO;
    
    
    
    
    
    
    if(_day1btn.tag==1 || _month1btn.tag==1 || _year1btn.tag==1)
    {
        _day1btn.tag=0;
        _month1btn.tag=0;
        _year1btn.tag=0;
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [btn1 addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
    }
    if(_day2btn.tag==1 || _month2btn.tag==1 || _year2btn.tag==1)
    {
        _day2btn.tag=0;
        _month2btn.tag=0;
        _year2btn.tag=0;
        [picker addTarget:self action:@selector(LabelTitle2:) forControlEvents:UIControlEventValueChanged];
        [btn1 addTarget:self action:@selector(buttoncross2:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonInfo4:) forControlEvents:UIControlEventTouchUpInside];
    }
       
   }
    
}


-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MMM/dd/yyyy"];
    strday=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strmon=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    stryear=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strday = [strday substringWithRange:NSMakeRange(4,2)];
    strmon = [strmon substringWithRange:NSMakeRange(0,3)];
    stryear = [stryear substringWithRange:NSMakeRange(7,4)];
    
    datePicked=YES;
    
    //NSLog(@"Date....%@",strday);
    
    //[picker removeFromSuperview];
}

-(void)LabelTitle2:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MMM/dd/yyyy"];
    strday=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strmon=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    stryear=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strday = [strday substringWithRange:NSMakeRange(4,2)];
    strmon = [strmon substringWithRange:NSMakeRange(0,3)];
    stryear = [stryear substringWithRange:NSMakeRange(7,4)];
    
    datePicked=YES;
    
    
}


-(void)buttonInfo:(id)sender
{
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
                         
                             
                             _daylbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _daylbl.text=strday;
                             
                             _monthlbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _monthlbl.text=strmon;
                             
                             _yearlbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _yearlbl.text=stryear;

                         
                         
                         }
                         else
                         {
                         
                         _daylbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _daylbl.text=strday;
                         
                         _monthlbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _monthlbl.text=strmon;
                         
                         _yearlbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _yearlbl.text=stryear;
                             
                         }
                         
                         [_signupscroller setContentOffset:CGPointMake(0.0f,220.0f)];
                     }
                     completion:^(BOOL finished){
                         
                         [self month];
                         
                         _dob = [NSString stringWithFormat:@"%@-%@-%@",strmon,strday,stryear];
                         NSLog(@"dob.....%@",_dob);
                         
                         
                     }
     ];
    
    datePicked=NO;
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    _signupscroller.scrollEnabled=YES;
    
}

-(void)buttonInfo4:(id)sender
{
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
                             
                             
                             _day2lbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _day2lbl.text=strday;
                             
                             _month2lbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _month2lbl.text=strmon;
                             
                             _year2lbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                             _year2lbl.text=stryear;
                             
                              [_signupscroller setContentOffset:CGPointMake(0.0f,220.0f)];
                             
                             
                             
                         }
                         else
                         {
                         
                         _day2lbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _day2lbl.text=strday;
                         
                         _month2lbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _month2lbl.text=strmon;
                         
                         _year2lbl.font = [UIFont fontWithName:@"OpenSans" size:14];
                         _year2lbl.text=stryear;
                         check = strmon;
                         [_signupscroller setContentOffset:CGPointMake(0.0f,220.0f)];
                             
                         }
                     }
                     completion:^(BOOL finished){
                         
                         [self month];
                         
                         _permitExp = [NSString stringWithFormat:@"%@-%@-%@",stryear,strmon,strday];
                         NSLog(@"Permit.....%@",_permitExp);
                         
                     }
     ];
    
    datePicked=NO;
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    _signupscroller.scrollEnabled=YES;
    
}

-(void)buttoncross:(id)sender
{
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [_signupscroller setContentOffset:CGPointMake(0.0f,220.0f)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
//    _daylbl.text=NULL;
//    _monthlbl.text=NULL;
//    _yearlbl.text=NULL;
    
    datePicked=NO;
    
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
    [btn removeFromSuperview];
    [btn1 removeFromSuperview];
    _signupscroller.scrollEnabled=YES;
    
}
-(void)buttoncross2:(id)sender
{
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [_signupscroller setContentOffset:CGPointMake(0.0f,220.0f)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
//    _day2lbl.text=NULL;
//    _month2lbl.text=NULL;
//    _year2lbl.text=NULL;
    
    
    datePicked=NO;
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
    [btn removeFromSuperview];
    [btn1 removeFromSuperview];
    _signupscroller.scrollEnabled=YES;
    
}

- (IBAction)OpenStateName:(id)sender
{
    
    
    
    
    
    myarr=[NSMutableArray arrayWithObjects:@"CHICAGO",@"NEWYORK CITY",@"CALIFORNIA",@"MINIAPOLIS",@"LOSANGELS",@"LASVEGAS",@"SAN FRANSISCO",@"MIAMI",@"WASHINGTON DC",nil];
    
     // [_signupscroller setContentOffset:CGPointMake(0.0f,_signupscroller.contentSize.height-myview.bounds.size.height-32) animated:YES];

    
   // _signupscroller.scrollEnabled=NO;
    
    
    if(statePickerOpened==NO)
    {
    
    
    myview = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-(self.view.bounds.size.height/2.47),self.view.bounds.size.width,self.view.bounds.size.height/2.47)];
    [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
    
   // myview.backgroundColor=[UIColor blackColor];
    [self.view addSubview:myview];
    //[_signupscroller addSubview:myview];
    
    mypicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,myview.bounds.size.width,self.view.bounds.size.height/2.47)];
    [mypicker setBackgroundColor: [UIColor colorWithRed:(245.0f/255.0f) green:(245.0f/255.0f) blue:(245.0f/255.0f) alpha:1]];
    [myview addSubview:mypicker];//picker as sub view of selfView
    
    btn=[[UIButton alloc]initWithFrame:CGRectMake(0,myview.bounds.size.height-48,self.view.bounds.size.width/2,48)];//(0,228,187,48)
    btn.backgroundColor=[UIColor colorWithRed:(100.0f/255.0f) green:(179.0f/255.0f) blue:(25.0f/255.0f) alpha:1];
    [btn setTitle: @"OK" forState: UIControlStateNormal];
    [myview addSubview:btn];//myview
    
    btn1=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2,myview.bounds.size.height-48,self.view.bounds.size.width/2,48)];//(187,228,188,48)
    btn1.backgroundColor=[UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:1];
    [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
    [myview addSubview:btn1];//myview
    
    mypicker.delegate = self;
    mypicker.dataSource=self;
    
    
    //
    /*
    if([[UIScreen mainScreen] bounds].size.height==667)
        
        [_signupscroller setContentOffset:CGPointMake(0.0f,myview.frame.origin.y-myview.bounds.size.height-67) animated:YES];
    
    else if([[UIScreen mainScreen] bounds].size.height==568)
        
        [_signupscroller setContentOffset:CGPointMake(0.0f,myview.frame.origin.y-myview.bounds.size.height-48) animated:YES];
    
    else if([[UIScreen mainScreen] bounds].size.height==480)
        
        [_signupscroller setContentOffset:CGPointMake(0.0f,myview.frame.origin.y-myview.bounds.size.height-32) animated:YES];*/
    
    
  [_signupscroller setContentOffset:CGPointMake(0.0f,_sgnUpBtn.frame.origin.y-self.view.bounds.size.height/2.5) animated:YES];
    _signupscroller.scrollEnabled=NO;
        
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    
        
    }

    
    statePickerOpened=YES;
    
}

-(void)buttonInfo2:(id)sender
{
    
    NSLog(@"Btn OK...");
    
    NSUInteger num = [[mypicker dataSource] numberOfComponentsInPickerView:mypicker];
    //NSMutableString *text = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [mypicker selectedRowInComponent:i];
        ww = [[mypicker delegate] pickerView:mypicker titleForRow:selectRow forComponent:i];
        
        _statelbl.text=ww;
        _statelbl.font = [UIFont fontWithName:@"Helvetica Neue Light" size:16];
    }
    [UIView animateWithDuration:0.4f
                     animations:^{
                         _signupscroller.scrollEnabled=YES;
                         
                         if([UIScreen mainScreen].bounds.size.height==568)
                         
                         [_signupscroller setContentOffset:CGPointMake(0.0f,[[UIScreen mainScreen]bounds ].size.height/1.32) animated:YES];
                         
                         
                        else if([UIScreen mainScreen].bounds.size.height==667)
                          [_signupscroller setContentOffset:CGPointMake(0.0f,331) animated:YES];
                         
                        else if([UIScreen mainScreen].bounds.size.height==480)
                            [_signupscroller setContentOffset:CGPointMake(0.0f,518) animated:YES];

                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
    [btn1 removeFromSuperview];
    [btn removeFromSuperview];
    
    
    [myview removeFromSuperview];
    
    statePickerOpened=NO;
    
}

-(void)buttonInfo3:(id)sender
{
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         _signupscroller.scrollEnabled=YES;
                         if([UIScreen mainScreen].bounds.size.height==568)
                             
                             [_signupscroller setContentOffset:CGPointMake(0.0f,[[UIScreen mainScreen]bounds ].size.height/1.32) animated:YES];
                         
                         
                         else if([UIScreen mainScreen].bounds.size.height==667)
                             [_signupscroller setContentOffset:CGPointMake(0.0f,331) animated:YES];
                         
                         else if([UIScreen mainScreen].bounds.size.height==480)
                             [_signupscroller setContentOffset:CGPointMake(0.0f,518) animated:YES];
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    self.navigationItem.rightBarButtonItem=nil;
    //_statelbl.text=NULL;
    
    [btn1 removeFromSuperview];
    [btn removeFromSuperview];

    
    [myview removeFromSuperview];
    
    
    statePickerOpened=NO;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

   NSLog(@"scroll offset value....%f",_signupscroller.contentOffset.y) ;
    
    NSLog(@"Screen height...%f",self.view.bounds.size.height);

}


- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //NSLog(@"ok");
    return [myarr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    //NSLog(@"ok");
    return [myarr objectAtIndex:row];
}


- (IBAction)SignUpclk:(id)sender
{
    
//    ELSignUpViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Signature_Page"];
//    [self.navigationController pushViewController:obj animated:YES];
    
    
    NSString *rawString = [_fname text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] < 1) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You must enter a first name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    
    
    else if ([_lname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1)
        
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You must enter a last name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    
    else if (![self checkforNumeric:[_phno text]])
        
    {
        // NSString *numberinvalid=[NSString stringWithFormat:@"Phone must be 10 digit..\n You have Enter %lu digits",(unsigned long)[_phno.text length]];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter valid Phone no" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    else if ([_screennm.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1)
        
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You must enter a screen name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    else  if (![ self NSStringIsValidEmail:[_email text]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Enter a valid email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    
    else if ([_pass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1)
        
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You must enter a password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if ([_daylbl.text isEqual:@"Day"] || [_monthlbl.text isEqual:@"Month"] || [_yearlbl.text isEqual:@"Year"])//strday==NULL
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"DOB field is incomplete" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if ([_day2lbl.text isEqual:@"Day"] || [_month2lbl.text isEqual:@"Month"] || [_year2lbl.text isEqual:@"Year"])//strday==NULL
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Expiry date field is incomplete" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    else if ([_learnerpermitno.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1)
        
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter a Learner Permit number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
//    else if (check==NULL)
//    {
//        
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Learner Permit Date can't be blank" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
    else if ([_postcode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You must enter a valid postal code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (ww ==NULL)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You must enter your state" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    else
    {
    
        [self Requstdata];
       }
    
    
}
- (IBAction)loginclk:(id)sender {
    ELSignUpViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"directlogin"];
    [self.navigationController pushViewController:login animated:YES];
}
- (IBAction)backclk:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField==_postcode)
    {
        [self.signupscroller setContentOffset:CGPointMake(0.0f,220.0f) animated:YES];
    }
    else
    {
        [self.signupscroller setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [btn1 removeFromSuperview];
    [btn removeFromSuperview];
    
    
    if(textField==self.fname)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [self.signupscroller setContentOffset:CGPointMake(0.0f,100.0f) animated:YES];
    }
    if(textField==self.lname)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [self.signupscroller setContentOffset:CGPointMake(0.0f,100.0f) animated:YES];
    }
    if(textField==self.phno)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [self.signupscroller setContentOffset:CGPointMake(0.0f,100.0f) animated:YES];
    }
    if(textField==self.screennm)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [self.signupscroller setContentOffset:CGPointMake(0.0f,100.0f) animated:YES];
    }
    if(textField==self.email)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [self.signupscroller setContentOffset:CGPointMake(0.0f,100.0f) animated:YES];
    }
    if(textField==self.pass)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [self.signupscroller setContentOffset:CGPointMake(0.0f,200.0f) animated:YES];
    }
    if(textField==self.learnerpermitno)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        
        [self.signupscroller setContentOffset:CGPointMake(0.0f,300.0f) animated:YES];
    }
    if(textField==self.postcode)
    {
        [picker resignFirstResponder];
        [myview removeFromSuperview];
        [self.signupscroller setContentOffset:CGPointMake(0.0f,450.0f) animated:YES];
    }
    
    
    
}







/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
- (BOOL) checkforNumeric:(NSString*) numericstr
{
    NSString *strMatchnumeric=@"\\b([0-9%_.+\\-]+)\\b";
    NSPredicate *numerictest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", strMatchnumeric];
    if(![numerictest evaluateWithObject:_phno.text])
    {
        //////NSLog(@"Invalid email address found");
        //[objAlertnumber release];
        return FALSE;
    }
    return TRUE;
}
- (BOOL) NumericNameFieldcheck:(NSString*) numericname
{
    NSString *NameMatchnumeric=@"[A-Za-z]+";
    NSPredicate *checknumeric=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", NameMatchnumeric];
    if(![checknumeric evaluateWithObject:_fname.text])
    {
        //////NSLog(@"Invalid email address found");
        UIAlertView *objAlertforName = [[UIAlertView alloc] initWithTitle:@"NameField alert!!" message:@"Please enter valid text." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
        [objAlertforName show];
        //[objAlertnumber release];
        return FALSE;
    }
    return TRUE;
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



-(void)month
{
    if ([strmon isEqualToString:@"Jan"]) {
        strmon=@"1";
    }
    else if ([strmon isEqualToString:@"Feb"])
    {
        strmon=@"2";
    }
    else if ([strmon isEqualToString:@"Mar"])
    {
        strmon=@"3";
    }
    else if ([strmon isEqualToString:@"Apr"])
    {
        strmon=@"4";
    }
    else if ([strmon isEqualToString:@"May"])
    {
        strmon=@"5";
    }
    else if ([strmon isEqualToString:@"Jun"])
    {
        strmon=@"6";
    }
    else if ([strmon isEqualToString:@"Jul"])
    {
        strmon=@"7";
    }
    else if ([strmon isEqualToString:@"Aug"])
    {
        strmon=@"8";
    }
    else if ([strmon isEqualToString:@"Sep"])
    {
        strmon=@"9";
    }
    else if ([strmon isEqualToString:@"Oct"])
    {
        strmon=@"10";
    }
    else if ([strmon isEqualToString:@"Nov"])
    {
        strmon=@"11";
    }
    else if ([strmon isEqualToString:@"Dec"])
    {
        strmon=@"12";
    }
    
}





//NSURL CONNECTION..............

-(void)Requstdata
{
   RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSString *urlstring=[NSString stringWithFormat:@"http://www.esolz.co.in/lab9/ezylog/iosapp/driver_registration.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"first_name=%@&last_name=%@&phone=%@&screen_name=%@&email=%@&password=%@&permit_no=%@&permit_expiry=%@&post_code=%@&state=%@&dob=%@",[_fname text],[_lname text],[_phno text],[_screennm text],[_email text],[_pass text],[_learnerpermitno text],_permitExp,[_postcode text],[_statelbl text], _dob];
    
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
             
             AppDelegate *app=[[UIApplication sharedApplication]delegate];
             
             app.userID=[NSString stringWithFormat:@"%@",[get_result objectForKey:@"id"]];
             
             
             //ELLearnerSignatureViewController
             
             ELLearnerSignatureViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Signature_Page_learner"];
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
    
//    NSString *post =[[NSString alloc] initWithFormat:@"first_name=%@&last_name=%@&phone=%@&screen_name=%@&email=%@&password=%@&permit_no=%@&permit_expiry=%@&post_code=%@&state=%@&dob=%@",[_fname text],[_lname text],[_phno text],[_screennm text],[_email text],[_pass text],[_learnerpermitno text],_permitExp,[_postcode text],[_statelbl text], _dob];
//    NSLog(@"PostData: %@",post);
//    
//    NSURL *url=[NSURL URLWithString:@"http://www.esolz.co.in/lab9/ezylog/iosapp/driver_registration.php?"];
//    _request = [NSMutableURLRequest requestWithURL:url];
//    _connection = [[NSURLConnection alloc ]initWithRequest:_request delegate:self];
//    
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    
//    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
//    
//    // NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [_request setURL:url];
//    [_request setHTTPMethod:@"POST"];
//    [_request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [_request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [_request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [_request setHTTPBody:postData];
    
    
}
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    
//    
//    
//    
//    self.connection = nil;
//    self.buffer     = nil;
//    
//    NSLog(@"Error: %@",[error localizedDescription]);
//    NSLog(@"Connection failed! Error - %@ %@",
//          [error localizedDescription],
//          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
//    NSLog(@"connectionssssssss...lost");
//    
//    
//    
//}



//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    [self.buffer setLength:0];
//    NSLog(@"didReceiveResponse");
//}



//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    
//    
//    [self.buffer appendData:data];
//    
//    NSLog(@"Data Loading....wait");
//    
//}
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    NSLog(@"connectionDidFinishLoading");
//    NSError *error = [[NSError alloc] init];
//    NSHTTPURLResponse *response = nil;
//    NSData *urlData=[NSURLConnection sendSynchronousRequest:_request returningResponse:&response error:&error];
//    
//    NSLog(@"Response code: %ld", (long)[response statusCode]);
//    if ([response statusCode] >=200 && [response statusCode] <300)
//    {
//        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
//        NSLog(@"Response ==> %@", responseData);
//        _jsonResult = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];
//        NSLog(@"jsonresult...............%@",_jsonResult);
//        
//        //Signup Checking...............
//        
//        if ([[_jsonResult valueForKey:@"status"] isEqualToString:@"success"])
//        {
//            ELSignUpViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"supervisorregis"];
//            [self.navigationController pushViewController:obj animated:YES];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[_jsonResult valueForKey:@"status"] message:[_jsonResult valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK"
//                                                 otherButtonTitles:nil];
//            
//            [alert show];
//        }
//        
//        
//        
//        
//    }
//}


@end
