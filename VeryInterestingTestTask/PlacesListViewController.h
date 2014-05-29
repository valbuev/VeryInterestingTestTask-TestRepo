//
//  PlacesListViewController.h
//  VeryInterestingTestTask
//
//  Created by Valeriy Buev on 27.05.14.
//  Copyright (c) 2014 bva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FetchedResultController_Helper.h"

@interface PlacesListViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource, FetchedResultController_Helper_Delegate>{
    FetchedResultController_Helper *FRC_Helper;     // helps to process fetchedResultsController`s functions
}

@property (nonatomic,retain) NSMutableArray *citiesAndPlacesList;
                                                    // array, which uses cityFirstLetters as indexes and NSArrays
                                                    //of cities- and places- managedObjects by values

@property (nonatomic,retain) IBOutlet UITableView* placesTableView;
                                                    // tableView, which display cities and places
@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) NSFetchedResultsController *citiesFetchedResultsController;
                                                    // controller, whitch listen for changes of cities
@property (nonatomic,retain) NSFetchedResultsController *placesFetchedResultsController;
                                                    //controller, which lesten for changes of places

-(void) performFetch;

- (IBAction)clickButton:(id)sender;

@end
