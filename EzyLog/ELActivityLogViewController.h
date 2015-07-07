//
//  ELActivityLogViewController.h
//  EzyLog
//
//  Created by ios on 18/06/15.
//  Copyright (c) 2015 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELActivityLogTableViewCell.h"
#import "LeftMenu.h"



@interface ELActivityLogViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *activitytabview;

@property (weak, nonatomic) IBOutlet UIView *mainview;

@end
