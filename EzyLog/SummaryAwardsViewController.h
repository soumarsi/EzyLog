//
//  SummaryAwardsViewController.h
//  EzyLog
//
//  Created by ios on 18/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummaryAwardsTableViewCell.h"
#import "LeftMenu.h"

@interface SummaryAwardsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *summaryawardstabview;

@property (weak, nonatomic) IBOutlet UIScrollView *summaryscroll;

@property (weak, nonatomic) IBOutlet UIView *mainview;

@property (weak, nonatomic) IBOutlet UIButton *leftmenubutton;

@end
