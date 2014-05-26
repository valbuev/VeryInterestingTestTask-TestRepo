//
//  AppDelegate.m
//  VeryInterestingTestTask
//
//  Created by Valeriy Buev on 26.05.14.
//  Copyright (c) 2014 bva. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

/*** Code for CoreData ***/

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil){
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if(_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DemoApp.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if(_managedObjectContext != nil){
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil){
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    if(managedObjectContext != nil) {
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

/*** end Code for CoreData ***/

- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/* Getting data with json-request*/
- (void) getJsonData{
    NSString *url = [NSString stringWithFormat:JSON_DATA_URL];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *responce,
                                               NSData *data,
                                               NSError *error) {
                               if(data != nil){
                                   //NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   //NSLog(@"String from URL %@ is %@", url, str);
                                   [self saveJsonData:data];
                               }
                               else if (error != nil){
                                   NSLog(@"Json-download error: %@", error);
                               }
                           }];
}

-(void) saveJsonData: (NSData *) data{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error != nil){
        NSLog(@"Json-parsing error: %@", error);
    }
    else{
        NSArray *places = [dict objectForKey:@"places"];
        if (places == NULL || places == nil){
            NSLog(@"Json-parsing error: cant find tag 'places'");
            return;
        }
        if([places count] != 0){
            for(NSDictionary *place in places){
                if( ![self isJsonPlaceDictCorrect:place]){
                    NSLog(@"Incorrect json data: place does not have some fields");
                    continue;
                }
                NSManagedObject *city = [self saveCity:[place objectForKey:@"city"]];
                NSManagedObject *placeMO = [self savePlace:place ofCity:city];
                [self savePhoto:[place objectForKey:@"image"] ofPlace:placeMO];
            }
        }
    }

}

- (NSManagedObject *) saveCity: (NSString *) name{
    if(name == NULL)
        return nil;
    if([name isEqualToString:@"<null>"])
        return nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *city_entity = [NSEntityDescription entityForName:@"City" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name == %@", name];
    [request setPredicate:predicate];
    [request setEntity:city_entity];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if ((result != nil) && ([result count]) && (error == nil)){
        return [result objectAtIndex:0];
    }
    else{
    	NSManagedObject *city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:self.managedObjectContext];
        [city setValue:name forKey:@"name"];
        [self saveContext];
        return city;
    }
}
- (NSManagedObject *) savePlace: (NSDictionary *) place ofCity: (NSManagedObject *) city{
    NSManagedObject *placeMO = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    [placeMO setValue:[f numberFromString:[place objectForKey:@"latitude"]] forKey:@"latitude"];
    [placeMO setValue:[f numberFromString:[place objectForKey:@"longitude"]] forKey:@"longitude"];
    [placeMO setValue:[place objectForKey:@"text"] forKey:@"text"];
    [placeMO setValue:city forKey:@"city"];
    [self saveContext];
    return placeMO;
}
- (NSManagedObject *) savePhoto: (NSString *) url ofPlace: (NSManagedObject *) place{
    if( url == NULL)
        return nil;
    NSManagedObject *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
    [photo setValue:url forKey:@"url"];
    [self saveContext];
    return photo;
}

-(Boolean) isJsonPlaceDictCorrect: (NSDictionary *) place{
    if(
       [place objectForKey:@"latitude"] == NULL
       || [place objectForKey:@"longitude"] == NULL
       || [place objectForKey:@"text"] == NULL
       )
        return FALSE;
    return TRUE;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self getJsonData];
    
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
