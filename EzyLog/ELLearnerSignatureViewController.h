//
//  ELLearnerSignatureViewController.h
//  EzyLog
//
//  Created by ios on 26/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SmoothLineView.h"
#import "mySmoothLineView.h"

@interface ELLearnerSignatureViewController : UIViewController
{
    mySmoothLineView * signView;
}
@property (weak, nonatomic) IBOutlet UIImageView *signatureimg;
@property (weak, nonatomic) IBOutlet UIView *baseview;

@property(nonatomic,strong) NSString *signUPData;

- (IBAction)Signature_submit:(id)sender;
- (IBAction)Cleare_Screen:(id)sender;
@end
