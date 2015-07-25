//
//  ELSupervisorSignatureViewController.h
//  EzyLog
//
//  Created by ios on 01/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mySmoothLineView.h"

@interface ELSupervisorSignatureViewController : UIViewController
{
    mySmoothLineView * signView;
    
}


@property(nonatomic,strong) NSString *signUPData;


@end
