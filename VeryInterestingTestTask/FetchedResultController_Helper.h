//
//  FetchedResultController_Helper.h
//  VeryInterestingTestTask
//
//  Created by Valeriy Buev on 28.05.14.
//  Copyright (c) 2014 bva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol FetchedResultController_Helper_Delegate <NSObject>

- (void)configureCell:(UITableViewCell *)cell managedObject:(NSManagedObject *)object;

@end

@interface FetchedResultController_Helper : NSObject
<NSFetchedResultsControllerDelegate>

// properties similar to PlacesListViewController

@property (nonatomic,retain) id<FetchedResultController_Helper_Delegate> delegate;

@property (nonatomic,retain) NSMutableArray *citiesAndPlacesList;

@property (nonatomic,retain) NSFetchedResultsController *citiesController;
@property (nonatomic,retain) NSFetchedResultsController *placesController;
@property (nonatomic,retain) NSManagedObjectContext *context;

@property (nonatomic,retain) IBOutlet UITableView* tableView;

-(void) reloadData;
- (NSIndexPath *) getCityIndexPathInTableView: (NSIndexPath *) indexPath;

-(void) clickButton;

@end
