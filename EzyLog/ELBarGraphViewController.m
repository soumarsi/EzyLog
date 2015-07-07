//
//  ELBarGraphViewController.m
//  EzyLog
//
//  Created by IOS2 on 18/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ELBarGraphViewController.h"

@interface ELBarGraphViewController ()

//The view in which graph is represented

@property (strong, nonatomic) IBOutlet UIView *graphView;

//grids in the graph

@property (strong, nonatomic) IBOutlet UIImageView *bar0;

@property (strong, nonatomic) IBOutlet UIImageView *bar1;

@property (strong, nonatomic) IBOutlet UIImageView *bar2;

@property (strong, nonatomic) IBOutlet UIImageView *bar3;

@property (strong, nonatomic) IBOutlet UIImageView *bar4;

@property (strong, nonatomic) IBOutlet UIImageView *bar5;


//graph bars

@property (strong, nonatomic) IBOutlet UIImageView *graphBar1;


@end

@implementation ELBarGraphViewController
- (void)loadView
{
    [super loadView];
   }

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //
    
    

    
    _graphBar1.frame=CGRectMake(_graphBar1.frame.origin.x, _bar0.frame.origin.y, _graphBar1.bounds.size.width,0);
    
    _graphBar1.hidden=YES;
    
    
    
    //_graphBar1.frame=CGRectMake(_graphBar1.frame.origin.x, _bar4.frame.origin.y+_bar4.bounds.size.height, _graphBar1.bounds.size.width, _bar0.frame.origin.y-(_bar4.frame.origin.y+_bar4.bounds.size.height));
    
    [UIView animateWithDuration:3.0 animations:^{
        
        [self performSelector:@selector(myMethod) withObject:nil afterDelay:1.5f];
        
        _graphBar1.frame=CGRectMake(_graphBar1.frame.origin.x, _bar4.frame.origin.y+_bar4.bounds.size.height, _graphBar1.bounds.size.width, _bar0.frame.origin.y-(_bar4.frame.origin.y+_bar4.bounds.size.height));

      
        
        
    } completion:^(BOOL finished) {
        
         //_graphBar1.hidden=NO;
        
        
    }];
    
 
 
    
    self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    
   }

-(void)myMethod
{

     _graphBar1.hidden=NO;
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (IBAction)backtoprev:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
