//
//  ELCarRegistrationViewController.m
//  EzyLog
//
//  Created by Soumen on 17/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELCarRegistrationViewController.h"
#import "ELDriveSummaryController.h"
#import "ELDriveSummaryController.h"
#import "RS_JsonClass.h"
#import "AppDelegate.h"

@interface ELCarRegistrationViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

{

     AppDelegate *app;

    RS_JsonClass *globalOBJ;
    
    NSMutableArray *resultArray;

}


@property (strong, nonatomic) IBOutlet UITextField *carText1;


@property (strong, nonatomic) IBOutlet UITextField *carText2;


@property (strong, nonatomic) IBOutlet UITextField *carText3;



@property (strong, nonatomic) IBOutlet UITextField *carText4;

@end

@implementation ELCarRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app=[[UIApplication sharedApplication]delegate];
    
    resultArray=[[NSMutableArray alloc]init];
    
    
    _carText1.delegate=self;
    _carText2.delegate=self;
    _carText3.delegate=self;
    _carText4.delegate=self;
    
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
    
    
    
     globalOBJ=[[RS_JsonClass alloc]init];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@vehicle_registration.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"car_registration_no=%@,%@,%@,%@&driver_id=%@",_carText1.text,_carText2.text,_carText3.text,_carText4.text,app.userID];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",request);
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    

    
    [globalOBJ GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        
        if(result)
        {
            NSLog(@"Car reg details: %@",(NSArray *)result);
        
            resultArray=[result mutableCopy];
            
            NSMutableArray *successCar=[[NSMutableArray alloc]init];
            
            NSMutableArray *duplicateCar=[[NSMutableArray alloc]init];
            
            for (int i=0; i<resultArray.count; i++) {
                
                if([[[resultArray objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"success"])
                {
                
                    [successCar addObject:[[resultArray objectAtIndex:i] valueForKey:@"car_registration_no"]];
                
                }
                
                else if([[[resultArray objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"duplicate entry"])
                {
                    
                    [duplicateCar addObject:[[resultArray objectAtIndex:i] valueForKey:@"car_registration_no"]];
                    
                }

                
            }
            
            NSLog(@"Success car: %@",successCar);
            NSLog(@"Duplicate car: %@",duplicateCar);
            
            NSString *sucCar=[successCar componentsJoinedByString:@","];

            NSLog(@"Success car %@",sucCar);
            
            NSString *dupCar=[duplicateCar componentsJoinedByString:@","];
            
            NSLog(@"Cuplicate car %@",dupCar);
            
            
            if(successCar.count>0 && duplicateCar.count==0)
            {
            
            UIAlertView *carAlert=[[UIAlertView alloc]initWithTitle:@"Car Registration details" message:[NSString stringWithFormat:@"Succesfully registerd car no: %@",sucCar] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [carAlert show];
                
                ELDriveSummaryController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
                [self.navigationController pushViewController:login animated:YES];
                
            }
            
            else if (successCar.count==0 && duplicateCar.count==0)
            {
            
                UIAlertView *carAlert=[[UIAlertView alloc]initWithTitle:@"Car Registration details" message:[NSString stringWithFormat:@"You have not registered any car"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [carAlert show];
                
            
            }
            else if (successCar.count>0 && duplicateCar.count>0)
            {
                
                UIAlertView *carAlert=[[UIAlertView alloc]initWithTitle:@"Car Registration details" message:[NSString stringWithFormat:@"Succesfully registerd car no: %@ & Duplicate car no: %@",sucCar,dupCar] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [carAlert show];
                
                ELDriveSummaryController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
                [self.navigationController pushViewController:login animated:YES];
                
                
            }
            if(successCar.count==0 && duplicateCar.count>0)
            {
                
                UIAlertView *carAlert=[[UIAlertView alloc]initWithTitle:@"Car Registration details" message:[NSString stringWithFormat:@"All the cars are already registered"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [carAlert show];
                
                ELDriveSummaryController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
                [self.navigationController pushViewController:login animated:YES];
                
            }
        
        
            
        }
        
        
        
    }];
    
    
    
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
