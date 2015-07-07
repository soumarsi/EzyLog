//
//  DrivingDistanceAwardViewController.m
//  EzyLog
//
//  Created by ios on 19/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "DrivingDistanceAwardViewController.h"
#import "DrivingDistanceAwardTableViewCell.h"

@interface DrivingDistanceAwardViewController ()

@end

@implementation DrivingDistanceAwardViewController

@synthesize distanceTableview,imageColorArray,bigcolorarray,bigcolorimage,bigcolorImageview,level;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addobjectArray];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 667 && screenBounds.size.width == 375) {
        _smaillabel.frame = CGRectMake(204, 273.4f, 59, 21);
        
    }
    else if (screenBounds.size.height >=667 &&  screenBounds.size.width >= 375 ) {
        _smaillabel.frame = CGRectMake(220, 303.1f, 59, 21);
    }
    NSLog(@" %f",screenBounds.size.width);
    
    
}

//Array object ..........


-(void)addobjectArray
{
    imageColorArray = [[NSMutableArray alloc]initWithObjects:@"red.png",@"pink.png",@"orange.png",@"yellow.png",@"blue.png",@"indigo.png",@"green.png",nil];
    
    bigcolorarray =[[NSMutableArray alloc]initWithObjects:@"red_bg.png",@"black.jpeg",@"orange_bg.png",@"yellow_bg.png",@"blue_bg.png",@"indigo_bg.png",@"green_bg.png",nil];
    
    level= [[NSArray alloc]initWithObjects:@"RED LEVEL",@"PINK LEVEL",@"ORANGE LEVEL",@"YELLOW LEVEL",@"BLUE LEVEL",@"INDIGO LEVEL",@"GREEN LEVEL", nil];
    _hours = [[NSArray alloc]initWithObjects:@"0-10 HOURS",@"10 HOURS",@"20 HOURS",@"50 HOURS",@"80 HOURS", @"100 HOURS",@"120 HOURS",nil];
    
    
    
    
    
}




// Table view delegate and Data source moethods.........................

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.00f;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imageColorArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DrivingDistanceAwardTableViewCell *cell = (DrivingDistanceAwardTableViewCell *)[distanceTableview dequeueReusableCellWithIdentifier:@"DrivingDistanceAward"];
    distanceTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.cellimageview.image=[UIImage imageNamed:imageColorArray[indexPath.row]];
    cell.celllevel.text = level [indexPath.row];
    //NSLog(@"color %@ ",[imageColorArray valueForKey:@"red"]);
    cell.cellhourslbl.text=_hours[indexPath.row];
    //    #define cellHeight 65.f
    //    #define cellWidth 370
    //    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    //    //imageView.frame = CGRectMake(0, , cellWidth, 1);
    //    imgView.frame = CGRectMake( distanceTableview.frame.origin.x+17, cellHeight, distanceTableview.frame.origin.x+distanceTableview.bounds.size.width-35,1 );
    //    [cell addSubview:imgView];
    //cell.selectedBackgroundView.backgroundColor=[UIColor blackColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    bigcolorimage=[UIImage imageNamed:bigcolorarray [indexPath.row]];
    bigcolorImageview.image=bigcolorimage;
    _colornameLabel.text =level[indexPath.row];
    _smaillabel.text=level[indexPath.row];
    _smailimageview.image =[UIImage imageNamed:imageColorArray[indexPath.row]];
    
}

- (IBAction)backtoprev:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
