//
//  FavoritsViewController.h
//  Expresso
//
//  Created by David Cortés Fulla on 09/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorits.h"
#import "Extra.h"
#import "ExpressoAppDelegate.h"



@interface FavoritsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSFetchedResultsController *aFetchedResultsController;
	
	IBOutlet UITableView *favoritsTableView;
	IBOutlet UILabel *noTensFavorits;
}

@property (nonatomic, retain) NSFetchedResultsController *aFetchedResultsController;
@property (nonatomic, retain) IBOutlet UITableView *favoritsTableView;

-(void) ConsultaFavorits;

@end
