//
//  ELTourTheAppViewController.h
//  EzyLog
//
//  Created by Soumen on 17/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELTourTheAppViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *tourtheappscroller;
@property (strong, nonatomic) IBOutlet UIPageControl *pagecontroller;
@property (strong, nonatomic) IBOutlet UIView *baseview;


@end
