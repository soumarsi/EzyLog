//
//  ELDriveSetUpViewController.m
//  EzyLog
//
//  Created by Soumen on 16/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELDriveSetUpViewController.h"
#import "RS_JsonClass.h"

@interface ELDriveSetUpViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

{

    RS_JsonClass *globalOBJ;
    
    NSString *pickerValue;

}

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
    // Do any additional setup after loading the view.
    
    pickerbackView.hidden=YES;
    
    superVisorPicker.delegate=self;
    
    superVisorPicker.dataSource=self;
    
    get_result_arr=[[NSMutableArray alloc]init];
    
    get_result_dic=[[NSMutableDictionary alloc]init];
    
   
    
    [superBtn addTarget:self action:@selector(superList) forControlEvents:UIControlEventTouchUpInside];
    
    [pickSelectBtn addTarget:self action:@selector(selectPickValue) forControlEvents:UIControlEventTouchUpInside];
    
    
}



-(void)selectPickValue
{


    pickerbackView.hidden=YES;
    
    NSLog(@"Lisence number for selected supervisor is %@",pickerValue);

}


-(void)superList
{
    
     globalOBJ=[[RS_JsonClass alloc]init];
    

   // driver_id=@"1";

    NSString *urlstring=[NSString stringWithFormat:@"%@supervisor_listing.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"driver_id=1"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",request);
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
  [globalOBJ GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        NSLog(@"url firing...");
        
     //   NSLog(@"Result....%@",result);
        
        get_result_dic=[result mutableCopy];
        
        get_result_arr=[get_result_dic valueForKey:@"supervisor"];
        
        NSLog(@"Result array......%@",get_result_arr);
      
      pickerbackView.hidden=NO;
      
      [superVisorPicker reloadAllComponents];
        
        
        
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
    
    NSString *superName=[NSString stringWithFormat:@"%@ %@ \n %@",[[get_result_arr objectAtIndex:row] valueForKey:@"first_name"],[[get_result_arr objectAtIndex:row] valueForKey:@"last_name"],[[get_result_arr objectAtIndex:row] valueForKey:@"licence_no"]];
    
    NSLog(@"Lisenece no......: %@",[[get_result_arr objectAtIndex:row] valueForKey:@"licence_no"]);

    return superName;

}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{


    pickerValue=[[get_result_arr objectAtIndex:row] valueForKey:@"licence_no"];

}


- (IBAction)backclk:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Startclk:(id)sender {
    ELDriveSetUpViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drivesetup2_Page"];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)registercarclk:(id)sender
{
    ELDriveSetUpViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registervehicle"];
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
