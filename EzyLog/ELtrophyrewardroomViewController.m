//
//  ELtrophyrewardroomViewController.m
//  EzyLog
//
//  Created by Rahul Singha Roy on 19/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELtrophyrewardroomViewController.h"
#import "ELtrophyrewardroomcellTableViewCell.h"
#import "ELtrophyrewardroom2TableViewCell.h"
#import "SummaryAwardsViewController.h"

@interface ELtrophyrewardroomViewController ()
{
    CGRect screenBounds;
}

@end

@implementation ELtrophyrewardroomViewController

- (IBAction)backBtn:(id)sender
{
    
    SummaryAwardsViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"summaryawards"];
    
    
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController: obj animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
     screenBounds=[[UIScreen mainScreen] bounds];
    
    
//    
//    if (screenBounds.size.height == 667 && screenBounds.size.width == 375)
//    {
//        _titlelabeltrophyroom.frame=CGRectMake(77, 28, 250, 21);
//        [_titlelabeltrophyroom setFont:[UIFont fontWithName:@"OpenSans-Bold" size:20] ];
//    }
//    
//    else if (screenBounds.size.height >= 667 && screenBounds.size.width >= 375)
//    {
//        _titlelabeltrophyroom.frame=CGRectMake(90, 560, 400, 35);
//        [_titlelabeltrophyroom setFont:[UIFont fontWithName:@"OpenSans" size:22] ];
//    }

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
    
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 145.0f;
    }
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        ELtrophyrewardroomcellTableViewCell *cell = (ELtrophyrewardroomcellTableViewCell *)[_tableviewtrophyroom dequeueReusableCellWithIdentifier:@"trophycell"];
        _tableviewtrophyroom.separatorStyle=UITableViewCellSelectionStyleNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    ELtrophyrewardroom2TableViewCell *cell = (ELtrophyrewardroom2TableViewCell *)[_tableviewtrophyroom dequeueReusableCellWithIdentifier:@"trophy2"];
    
    if (screenBounds.size.height == 667 && screenBounds.size.width == 375)
            {
                cell.labelcelebrity.frame=CGRectMake(6, 12, 60, 24);
                [cell.labelcelebrity setFont:[UIFont fontWithName:@"Oswald-Regular" size:11] ];
                
                cell.labelsneakerhead.frame=CGRectMake(64, 12, 80, 24);
                [cell.labelsneakerhead setFont:[UIFont fontWithName:@"Oswald-Regular" size:11] ];
                
                cell.labelunclesam.frame=CGRectMake(135, 12, 60, 24);
                [cell.labelunclesam setFont:[UIFont fontWithName:@"Oswald-Regular" size:11] ];
                
                
                cell.labeldoubleup.frame=CGRectMake(195, 12, 55, 24);
                [cell.labeldoubleup setFont:[UIFont fontWithName:@"Oswald-Regular" size:11] ];
                
            
                cell.labeljack.frame=CGRectMake(228, 12, 85, 24);
                [cell.labeljack setFont:[UIFont fontWithName:@"Oswald-Regular" size:11] ];
                
            }
    else if (screenBounds.size.height >= 667 && screenBounds.size.width >= 375)
    {
        
        cell.labelcelebrity.frame=CGRectMake(5, 12, 65, 24);
        [cell.labelcelebrity setFont:[UIFont fontWithName:@"Oswald-Regular" size:12] ];
        
        cell.labelsneakerhead.frame=CGRectMake(60, 12, 93, 24);
        [cell.labelsneakerhead setFont:[UIFont fontWithName:@"Oswald-Regular" size:12] ];
        
        cell.labelunclesam.frame=CGRectMake(130, 12, 73, 24);
        [cell.labelunclesam setFont:[UIFont fontWithName:@"Oswald-Regular" size:12] ];
        
        
        cell.labeldoubleup.frame=CGRectMake(194, 12, 69, 24);
        [cell.labeldoubleup setFont:[UIFont fontWithName:@"Oswald-Regular" size:12] ];
        
       
        cell.labeljack.frame=CGRectMake(216, 12, 100, 24);
        [cell.labeljack setFont:[UIFont fontWithName:@"Oswald-Regular" size:12] ];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    _tableviewtrophyroom.separatorStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
