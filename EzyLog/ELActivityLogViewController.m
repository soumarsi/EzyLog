//
//  ELActivityLogViewController.m
//  EzyLog
//
//  Created by ios on 18/06/15.
//  Copyright (c) 2015 ios. All rights reserved.
//

#import "ELActivityLogViewController.h"
#import "SummaryAwardsViewController.h"
#import "ELDriveSummaryController.h"
#import "SupervisorSignupViewController.h"
#import "ELWelcomeScreen.h"
#import <FacebookSDK/FacebookSDK.h>
#import "RS_JsonClass.h"
#import "AppDelegate.h"
#import "EL_settingsViewController.h"

@interface ELActivityLogViewController ()<SlideDelegate>
{
    BOOL menuslide;
    LeftMenu *leftview;
    
    // Variables for populating Activity table
    
   
    
    
    RS_JsonClass *globalOBJ;
    
    NSMutableArray *activityResult;
    
    AppDelegate *app;
    
    NSString *strmon;
    
    
    IBOutlet UIActivityIndicatorView *spinner;
    
    
    
    
    //Lazy loading
    
    
    int start,end;
    
    NSUInteger lastCell;
    
    BOOL isProcessing;
    
    
}
@end

@implementation ELActivityLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activitytabview.delegate=self;
    self.activitytabview.dataSource=self;
    menuslide = 0;
    
    
    
    start=0;
    end=10;
    
    // Do any additional setup after loading the view.
    
    globalOBJ=[[RS_JsonClass alloc]init];
    activityResult=[[NSMutableArray alloc]init];
    app=[[UIApplication sharedApplication]delegate];
    
    [spinner startAnimating];
    
    isProcessing=NO;
    
    [self getData];
    
}


-(void)getData
{

  

    globalOBJ=[[RS_JsonClass alloc]init];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@all_drives.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"Driver id is %@",app.userID);
    
    NSString *postData = [NSString stringWithFormat:@"driver_id=%@&start=%@&records=%@",app.userID,[NSString stringWithFormat:@"%d",start],[NSString stringWithFormat:@"%d",end]];//,app.userID
    
    NSLog(@"Post data....%@",postData);
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",request);
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [globalOBJ GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if(result)
        {
        
        
           // NSLog(@"Totale drives result.... %@",result);
            
            activityResult=[[NSMutableArray alloc]init];
            
            activityResult=(NSMutableArray *)[[result objectForKey:@"details"] mutableCopy];
            
           //  NSLog(@"Totale drives result.... %@",activityResult);
            
            
            if(end==10)
            
            [_activitytabview reloadData];
            
            else
            {
            
                
                [self insertNewRows];
            
            
            }
        
        
        }
        
        
    }];

    

}





- (IBAction)leftmenuclk:(id)sender
{
    if (menuslide == 0)
    {
        leftview = [LeftMenu LeftView];
        
        
        leftview.frame = CGRectMake(0, 0,self.view.frame.size.width*.75, self.mainview.frame.size.height);
        leftview.SlideDelegate = self;
        [_mainview setFrame:CGRectMake(self.mainview.frame.size.width*.75,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        
        //        [leftView leftmenumethod];
        //        leftView.leftDelegate = self;
        
        [self.view addSubview:leftview];
        menuslide = 1;
    }
    else
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            [_mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
            
            leftview.frame = CGRectMake(-leftview.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/2+60, self.view.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            
            [leftview removeFromSuperview];
            [UIView commitAnimations];
        }];
        
        
        //        [leftview removeFromSuperview];
        //        [mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        menuslide = 0;
    }
  
}

-(void)action_method:(NSInteger)sender
{
    if(sender==0)
    {
        NSLog(@"########%ld",(long)sender);
        ELDriveSummaryController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Drive_Summery"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if(sender==1)
    {
        NSLog(@"########%ld",(long)sender);
        ELActivityLogViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"activity"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if(sender==4)
    {
        NSLog(@"########%ld",(long)sender);
        EL_settingsViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"settings_new"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if(sender==100)
    {
        NSLog(@"Btn tag ...100....");
        
        SummaryAwardsViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"summaryawards"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if(sender==5)
    {
        NSLog(@"########%ld",(long)sender);
        
        [[FBSession activeSession] closeAndClearTokenInformation];
        
        NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        
        [userData removeObjectForKey:@"status"];
        
        
        ELWelcomeScreen *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"welcome"];
        [self.navigationController pushViewController:obj animated:YES];
    }

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Activity table rows.... %ld",activityResult.count);
    
    return activityResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ELActivityLogTableViewCell *cell=(ELActivityLogTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"activitylog"];
    
    NSArray *dateCompArr=[[NSArray alloc]init];
    
    dateCompArr=[[[activityResult objectAtIndex:indexPath.row] valueForKey:@"date"]componentsSeparatedByString:@"-"];
    
    strmon=[dateCompArr objectAtIndex:1];
    [self monthString];
    
    cell.dateLbl.text=[NSString stringWithFormat:@"%@ %@,%@",strmon,dateCompArr[2],dateCompArr[0]];
    
    
    cell.hoursLbl.text=[NSString stringWithFormat:@"%.2f",[[[activityResult objectAtIndex:indexPath.row] valueForKey:@"total_drive_hr"] floatValue]/60];
    
    if([cell.hoursLbl.text length]==4)
        cell.hoursLbl.text=[NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%.2f",[[[activityResult objectAtIndex:indexPath.row] valueForKey:@"total_drive_hr"] floatValue]/60]];
    
    cell.hoursLbl.adjustsFontSizeToFitWidth=YES;
    
    cell.driveDistanceLbl.text=[NSString stringWithFormat:@"%.2f KMS",[[[activityResult objectAtIndex:indexPath.row] valueForKey:@"drive_km"] floatValue]];
    cell.driveDistanceLbl.adjustsFontSizeToFitWidth=YES;
    
    cell.avrgSpeedLbl.text=[NSString stringWithFormat:@"%.2f KPH",[[[activityResult objectAtIndex:indexPath.row] valueForKey:@"avg_speed"] floatValue]];
    
    cell.parkImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[activityResult objectAtIndex:indexPath.row] valueForKey:@"parking"]]];
    
     cell.trafficImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@_traffic.png",[[activityResult objectAtIndex:indexPath.row] valueForKey:@"traffic"]]];
    
     cell.roadImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@_road.png",[[activityResult objectAtIndex:indexPath.row] valueForKey:@"road_condition"]]];
    
    
if(indexPath.row==(activityResult.count -1) && isProcessing==NO)
{


   // start=start+10;
   
    
    end+=10;
    
    lastCell=activityResult.count;
    
    NSLog(@"Last cell is %ld",lastCell);
    
    [self getData];

}
    
    
    return  cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ELActivityLogViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"activitygraph"];
    [self.navigationController pushViewController:obj animated:YES];
 
}



-(void)insertNewRows
{
    isProcessing=YES;
    
    
    [spinner stopAnimating];
    
    
    if(end!=10)
    {
        int count=(int)lastCell;
        
        int countLimit=(int)activityResult.count;
        
        
        
        //inserting
        
        [_activitytabview beginUpdates];
        
        
        for(int k=count; k<countLimit; k++)
        {
            
            
            NSLog(@"Inserting new rows....");
            
            
            
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:k
                                                        inSection:0];
            
            
            
            [_activitytabview insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationRight];
            
            
            
        }
        
        [_activitytabview endUpdates];
        
        [spinner stopAnimating];
        
 
        
        //  [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:breakArray.count-5 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        
    }
    

    isProcessing=NO;
    
     
    
    
}










-(void)monthString
{
    if ([strmon isEqualToString:@"01"]) {
        strmon=@"January";
    }
    else if ([strmon isEqualToString:@"02"])
    {
        strmon=@"February";
    }
    else if ([strmon isEqualToString:@"03"])
    {
        strmon=@"March";
    }
    else if ([strmon isEqualToString:@"04"])
    {
        strmon=@"April";
    }
    else if ([strmon isEqualToString:@"05"])
    {
        strmon=@"May";
    }
    else if ([strmon isEqualToString:@"06"])
    {
        strmon=@"June";
    }
    else if ([strmon isEqualToString:@"07"])
    {
        strmon=@"July";
    }
    else if ([strmon isEqualToString:@"08"])
    {
        strmon=@"August";
    }
    else if ([strmon isEqualToString:@"09"])
    {
        strmon=@"September";
    }
    else if ([strmon isEqualToString:@"10"])
    {
        strmon=@"October";
    }
    else if ([strmon isEqualToString:@"11"])
    {
        strmon=@"November";
    }
    else if ([strmon isEqualToString:@"12"])
    {
        strmon=@"December";
    }
    
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
