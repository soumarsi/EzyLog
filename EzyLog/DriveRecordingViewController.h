//
//  DriveRecordingViewController.h
//  EzyLog
//
//  Created by Rahul Singha Roy on 01/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriveRecordingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Hours_driven;
@property (weak, nonatomic) IBOutlet UIImageView *Status_color;

- (IBAction)End_Drive_Action:(id)sender;


@end
