//
//  ELDriveSetUpViewController.m
//  EzyLog
//
//  Created by Soumen on 16/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELDriveSetUpViewController.h"
#import "RS_JsonClass.h"
#import "AppDelegate.h"

@interface ELDriveSetUpViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

{

    RS_JsonClass *globalOBJ;
    
    NSString *pickerValue;
    
    AppDelegate *app;
    
    BOOL supPickOpen,carPickOpen;

}

@property (strong, nonatomic) IBOutlet UIButton *carBtn;


@property (strong, nonatomic) IBOutlet UILabel *carRegLbl;


@property (strong, nonatomic) IBOutlet UILabel *superNameLbl;


@property (strong, nonatomic) IBOutlet UIVisualEffectView *pickerbackView;


@property (strong, nonatomic) IBOutlet UIPickerView *superVisorPicker;


@property (strong, nonatomic) IBOutlet UIButton *pickSelectBtn;


@property (strong, nonatomic) IBOutlet UIButton *pickCancelBtn;


@property (strong, nonatomic) IBOutlet UIButton *superBtn;

@property(nonatomic,strong)NSMutableDictionary *get_result_dic;

@property(nonatomic,strong)NSMutableArray *get_result_arr;

@end

@implementation ELDriveSetUpViewController

@synthesize get_result_dic,get_result_arr,pickCancelBtn,pickerbackView,pickSelectBtn,superBtn,superVisorPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    supPickOpen=NO;
    carPickOpen=NO;
    
    app=[[UIApplication sharedApplication]delegate];
    
    // Do any additional setup after loading the view.
    
    pickerbackView.hidden=YES;
    
    superVisorPicker.delegate=self;
    
    superVisorPicker.dataSource=self;
    
    get_result_arr=[[NSMutableArray alloc]init];
    
    get_result_dic=[[NSMutableDictionary alloc]init];
    
   
    
    [superBtn addTarget:self action:@selector(superList) forControlEvents:UIControlEventTouchUpInside];
    
    [_carBtn addTarget:self action:@selector(CarList) forControlEvents:UIControlEventTouchUpInside];
    
    [pickSelectBtn addTarget:self action:@selector(selectPickValue) forControlEvents:UIControlEventTouchUpInside];
    
    
}



-(void)selectPickValue
{

    

    pickerbackView.hidden=YES;
    
    
    if(supPickOpen==YES)
    {
        NSLog(@"Super name is %@",pickerValue);
        _superNameLbl.text=pickerValue;
    
    }
    else if(carPickOpen==YES)
    {
    
        NSLog(@"Car reg is %@",pickerValue);

        
        _carRegLbl.text=pickerValue;
    
    }
        
    
    supPickOpen=NO;
    
    carPickOpen=NO;
    
    NSLog(@"Lisence number for selected supervisor is %@",pickerValue);

}

- (IBAction)cancel:(id)sender
{
    supPickOpen=NO;
    
    carPickOpen=NO;

    
    [pickerbackView removeFromSuperview];
    
}




-(void)CarList
{


    globalOBJ=[[RS_JsonClass alloc]init];
    
    
    // driver_id=@"1";
    
    NSString *urlstring=[NSString stringWithFormat:@"%@supervisor_listing.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"Driver id is %@",app.userID);
    
    NSString *postData = [NSString stringWithFormat:@"driver_id=%@",app.userID];//,app.userID
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",request);
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [globalOBJ GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        NSLog(@"url firing...");
        
        //   NSLog(@"Result....%@",result);
        
        get_result_arr=[[NSMutableArray alloc]init];
        
        get_result_dic=[[NSMutableDictionary alloc]init];

        
        
        get_result_dic=[[result objectForKey:@"data"]mutableCopy];
        
        get_result_arr=[[get_result_dic objectForKey:@"vehicle"] mutableCopy];
        
        NSLog(@"Car array......%@",get_result_arr);
        
        if(get_result_arr.count>0)
        {
        
        pickerbackView.hidden=NO;
            
            carPickOpen=YES;
        
        [superVisorPicker reloadAllComponents];
            
            
            
        }
        
        else
        {
            
            UIAlertView *supAlert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"No vehicle found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [supAlert show];
            
        }

        
        
        
    }];

    
    

}





-(void)superList
{
    
     globalOBJ=[[RS_JsonClass alloc]init];
    

   // driver_id=@"1";

    NSString *urlstring=[NSString stringWithFormat:@"%@supervisor_listing.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"Driver id is %@",app.userID);
    
    NSString *postData = [NSString stringWithFormat:@"driver_id=%@",app.userID];//,
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",request);
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
  [globalOBJ GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        NSLog(@"url firing...");
        
     //   NSLog(@"Result....%@",result);
      
      get_result_arr=[[NSMutableArray alloc]init];
      
      get_result_dic=[[NSMutableDictionary alloc]init];
      
        get_result_dic=[[result objectForKey:@"data"]mutableCopy];
        
        get_result_arr=[[get_result_dic objectForKey:@"supervisor"] mutableCopy];
        
        NSLog(@"Supervisor array......%@",get_result_arr);
      
      if(get_result_arr.count>0)
      {
      
      pickerbackView.hidden=NO;
          
          supPickOpen=YES;
      
      [superVisorPicker reloadAllComponents];
          
      }
      
      else
      {
      
          UIAlertView *supAlert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"No supervisor found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
          
          [supAlert show];
      
      }
      
        
        
    }];
   
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    NSLog(@"Number of rows is %lu",(long)get_result_arr.count);
    
    return get_result_arr.count;

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{

   return 40;

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(supPickOpen==YES)
    {
    
    NSString *superName=[NSString stringWithFormat:@"%@ %@",[[get_result_arr objectAtIndex:row] valueForKey:@"first_name"],[[get_result_arr objectAtIndex:row] valueForKey:@"last_name"]];
    
    NSLog(@"Lisenece no......: %@",[[get_result_arr objectAtIndex:row] valueForKey:@"licence_no"]);

    return superName;
        
    }
    
    else if(carPickOpen==YES)
    {
    
    
    return [get_result_arr[row] objectForKey:@"car_registration_no"];
        
    }
    else
        return 0;

}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if(supPickOpen==YES)
    {
        pickerValue=[NSString stringWithFormat:@"%@ %@",[[get_result_arr objectAtIndex:row] valueForKey:@"first_name"],[[get_result_arr objectAtIndex:row] valueForKey:@"last_name"]];
        
        app.supName=pickerValue;
        
        app.superID=[[get_result_arr objectAtIndex:row] valueForKey:@"id"];
        
    }
    else if(carPickOpen==YES)
    {
        pickerValue=[get_result_arr[row] objectForKey:@"car_registration_no"];
        
        app.carID=[get_result_arr[row] objectForKey:@"car_id"];
        
    }
    

   

}


- (IBAction)backclk:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Startclk:(id)sender {
    ELDriveSetUpViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drivesetup2_Page"];
    [self.navigationController pushViewController:login animated:YES];
}

//- (IBAction)registercarclk:(id)sender
//{
//    ELDriveSetUpViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registervehicle"];
//    [self.navigationController pushViewController:login animated:YES];
//}


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
