//
//  LeftMenu.m
//  EzyLog
//
//  Created by Somenath on 16/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "LeftMenu.h"
#import "ELDriveSummaryController.h"

@implementation LeftMenu
@synthesize tableview;
@synthesize SlideDelegate;


+ (id)LeftView
{
    LeftMenu *leftView = [[[NSBundle mainBundle] loadNibNamed:@"LeftMenu" owner:nil options:nil] lastObject];
    
    // make sure customView is not nil or the wrong class!
    if ([leftView isKindOfClass:[LeftMenu class]])
        return leftView;
    else
        return nil;
}

- (IBAction)Profile_Page:(id)sender
{
     [SlideDelegate action_method:100];
}

//-(id)initWithFrame:(CGRect)frame
//{
//    self=[super initWithFrame:frame];
//    if (self)
//    {
//        self=[[[NSBundle mainBundle] loadNibNamed:@"LeftMenu" owner:self options:nil]objectAtIndex:0];
//    }
//    return self;
//}


- (void)drawRect:(CGRect)rect {
    
    imgarr = [NSArray arrayWithObjects:[UIImage imageNamed:@"home" ], [UIImage imageNamed:@"activity" ], [UIImage imageNamed:@"friends" ], [UIImage imageNamed:@"profile" ], [UIImage imageNamed:@"settings" ], [UIImage imageNamed:@"logout" ], nil];
    lblarr = [NSArray arrayWithObjects:@"Home", @"Activity", @"Friends", @"Profile", @"Settings", @"Logout", nil];
    [tableview reloadData];
    
    tableview.dataSource = self;
    tableview.delegate = self;
    
    tableview.scrollEnabled = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imgarr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellid";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell = [[[NSBundle mainBundle]loadNibNamed:@"LeftMenuCell" owner:self options:nil] objectAtIndex:0];
    if (indexPath.row == 0)
    {
        UIImageView *div = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 1)];
        div.image = [UIImage imageNamed:@"divider"];
        cell.imgview.image = [imgarr objectAtIndex:indexPath.row];
        cell.txtlbl.text = [lblarr objectAtIndex:indexPath.row];
        [cell addSubview:div];
    }
    
    cell.imgview.image = [imgarr objectAtIndex:indexPath.row];
    cell.txtlbl.text = [lblarr objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@" index path row=%ld",(long)indexPath.row);
    [SlideDelegate action_method:indexPath.row];
    
    
}
@end
