//
//  DrivingDistanceAwardViewController.h
//  EzyLog
//
//  Created by ios on 19/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrivingDistanceAwardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *distanceTableview;
@property(strong,nonatomic) NSMutableArray *imageColorArray;
@property (strong,nonatomic) NSMutableArray *bigcolorarray;
@property(strong,nonatomic) UIImage *bigcolorimage;
@property (strong,nonatomic)IBOutlet UIImageView *bigcolorImageview;
@property(strong,nonatomic) NSArray *level,*hours;
@property (strong, nonatomic) IBOutlet UILabel *digitlabel;
@property (strong, nonatomic) IBOutlet UILabel *colornameLabel;
@property (strong, nonatomic) IBOutlet UILabel *smaillabel;
@property (strong, nonatomic) IBOutlet UIImageView *smailimageview;

@end
