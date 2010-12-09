//
//  FavoritsViewController.h
//  Expresso
//
//  Created by David Cortés Fulla on 09/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorits.h"
#import "ExpressoAppDelegate.h"


@interface FavoritsViewController : UITableViewController {
	NSFetchedResultsController *aFetchedResultsController;
}

@property (nonatomic,retain)NSFetchedResultsController *aFetchedResultsController;
-(void) ConsultaFavorits;

@end
