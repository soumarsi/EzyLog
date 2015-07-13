//
//  AppDelegate.h
//  EzyLog
//
//  Created by Soumen on 15/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FacebookSDK/FacebookSDK.h>




@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property(nonatomic,strong)NSString *userID;

@property(nonatomic,strong)NSString *superID;

@property(nonatomic,strong)NSString *carID;

@property(nonatomic,strong)NSString *supName;



@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void)openActiveSessionWithPermissions:(NSArray *)permissions allowLoginUI:(BOOL)allowLoginUI;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

