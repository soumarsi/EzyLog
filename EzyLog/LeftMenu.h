//
//  LeftMenu.h
//  EzyLog
//
//  Created by Somenath on 16/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuCell.h"

@protocol SlideDelegate<NSObject>
@optional
-(void)action_method:(NSInteger )sender;
@end

@interface LeftMenu : UIView <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *imgarr, *lblarr;
    LeftMenuCell *cell;
}

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property(assign)id<SlideDelegate>SlideDelegate;

+ (id)LeftView;
- (IBAction)Profile_Page:(id)sender;

@end
