//
//  ELTourTheAppViewController.m
//  EzyLog
//
//  Created by Soumen on 17/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELTourTheAppViewController.h"

@interface ELTourTheAppViewController ()
{
    NSArray *imageArray;
}

@end

@implementation ELTourTheAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray = [[NSArray alloc] initWithObjects:@"Tour_the_app2", @"Tour_the_app1", @"Tour_the_app3",@"Tour_the_app4", nil];
    [self.baseview addSubview:self.pagecontroller];
    [self.tourtheappscroller setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*[imageArray count], 470)];
    for (int i=0; i<[imageArray count]; i++)
    {
        CGRect frame=CGRectMake(self.tourtheappscroller.frame.size.width*i, self.tourtheappscroller.frame.origin.y, self.tourtheappscroller.frame.size.width, self.tourtheappscroller.frame.size.height);
        UIImageView *img=[[UIImageView alloc]initWithFrame:frame];
        img.image=[UIImage imageNamed:[imageArray objectAtIndex:i]];
        img.contentMode=UIViewContentModeScaleAspectFill;
        [self.tourtheappscroller addSubview:img];
    }
    self.pagecontroller.userInteractionEnabled=YES;
    self.pagecontroller.numberOfPages=imageArray.count;
    [self.tourtheappscroller setShowsHorizontalScrollIndicator:NO];
    [self.tourtheappscroller setShowsVerticalScrollIndicator:NO];
    // Do any additional setup after loading the view.
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.tourtheappscroller.frame.size.width;
    int page = floor((self.tourtheappscroller.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pagecontroller.currentPage = page;
}

- (IBAction)backtoprev:(id)sender
{
    ELTourTheAppViewController *obj=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"logindriver"];
    [self.navigationController pushViewController:obj animated:YES];
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
