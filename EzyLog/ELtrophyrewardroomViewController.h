//
//  ELtrophyrewardroomViewController.h
//  EzyLog
//
//  Created by Rahul Singha Roy on 19/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELtrophyrewardroomViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableviewtrophyroom;
@property (weak, nonatomic) IBOutlet UILabel *titlelabeltrophyroom;

@end
