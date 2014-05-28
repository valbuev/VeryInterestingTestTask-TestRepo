//
//  PlacesListViewController.h
//  VeryInterestingTestTask
//
//  Created by Valeriy Buev on 27.05.14.
//  Copyright (c) 2014 bva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PlacesListViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>

@property (nonatomic,retain) IBOutlet UITableView* placesTableView;
@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;

-(void) performFetch;

@end
