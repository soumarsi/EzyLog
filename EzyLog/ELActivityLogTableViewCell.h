//
//  ELActivityLogTableViewCell.h
//  EzyLog
//
//  Created by ios on 18/06/15.
//  Copyright (c) 2015 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELActivityLogTableViewCell : UITableViewCell


 //Labels


 @property (strong, nonatomic) IBOutlet UILabel *dateLbl;
    
 @property(nonatomic,strong)   IBOutlet UILabel *hoursLbl;
    
 @property(nonatomic,strong)    IBOutlet UILabel *driveDistanceLbl;
    
 @property(nonatomic,strong)   IBOutlet UILabel *avrgSpeedLbl;

    
//Imageview(s)

 @property(nonatomic,strong)   IBOutlet UIImageView *parkImageView;

 @property(nonatomic,strong)  IBOutlet UIImageView *trafficImageView;

 @property(nonatomic,strong)   IBOutlet UIImageView *roadImageView;
    
    


@end
