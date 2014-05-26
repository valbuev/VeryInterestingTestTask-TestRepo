//
//  AppDelegate.h
//  VeryInterestingTestTask
//
//  Created by Valeriy Buev on 26.05.14.
//  Copyright (c) 2014 bva. All rights reserved.
//

#define JSON_DATA_URL @"http://m.saritasa.com/testtask/places.json"

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
