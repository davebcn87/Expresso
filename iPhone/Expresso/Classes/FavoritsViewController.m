//
//  FavoritsViewController.m
//  Expresso
//
//  Created by David Cortés Fulla on 09/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import "FavoritsViewController.h"
#import "comandaRealitzadaViewController.h"



@implementation FavoritsViewController

@synthesize favoritsTableView;
@synthesize aFetchedResultsController;

#pragma mark -
#pragma mark View lifecycle


-(void) ConsultaFavorits
{
	ExpressoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorits" inManagedObjectContext:[appDelegate managedObjectContext]];
	
	NSFetchRequest *request = [[NSFetchRequest alloc]init];
	[request setEntity:entity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"usuari == %@", [appDelegate usuari]];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"nom_producte" ascending: NO];
	
	NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor,nil];
	
	[request setSortDescriptors:sortDescriptors];
	[request setPredicate:predicate];
	
	[sortDescriptor release];
	[predicate release];
	
	NSError *error;
	
	if (aFetchedResultsController == nil){
		aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[appDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
		//aFetchedResultsController.delegate = self;
	}	
	
	BOOL success = [aFetchedResultsController performFetch:&error];
	if (!success){
		NSLog(@"Error no tratado %@",error);
	}
	
	[request release];

	[favoritsTableView reloadData];
	
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self ConsultaFavorits];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	[favoritsTableView setBackgroundView:nil];
	[favoritsTableView setBackgroundColor:[UIColor clearColor]];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numberOfRows = 0;
	
    if ([[aFetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[aFetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
		NSLog(@"numberOfRows");
    }
	
	if (numberOfRows==0) [noTensFavorits setHidden:NO];
	else [noTensFavorits setHidden:YES	];
	
    return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Favorits *favorit = [aFetchedResultsController objectAtIndexPath:indexPath ];
	cell.textLabel.text = [favorit nom_producte];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Tamany: %@ Preu: %@ €",[favorit tamany],[favorit preu]];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	Favorits *favorit = [aFetchedResultsController objectAtIndexPath:indexPath];
	ExpressoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	   
	NSArray *extres = [[favorit extres] allObjects];
	NSMutableString *stringExtres = [[NSMutableString alloc] init];
	NSMutableArray *extresArray = [[NSMutableArray alloc] init];
	
	for (Extra *extra in [extres reverseObjectEnumerator]){
		NSLog(@"%@",[extra nomExtra]);		
		NSLog(@"%@",[extra Quantitat]);
		stringExtres = [NSString stringWithFormat:@"%@ %@",[extra nomExtra],[extra Quantitat]];
		[extresArray addObject:stringExtres];
	}

	
	appDelegate.extres = (NSArray *)extresArray;
	

	[extresArray release];
	[stringExtres release];
	
	appDelegate.nomProducte =  favorit.nom_producte;
	appDelegate.tamany = favorit.tamany;
	appDelegate.preu = favorit.preu;
	
	ComandaRealitzadaViewController *ComandaRealitzadaVC = [[ComandaRealitzadaViewController alloc] initWithNibName:@"ComandaRealitzadaViewController" bundle:nil];
	[self.navigationController pushViewController:ComandaRealitzadaVC animated:YES];
    [ComandaRealitzadaVC release];
	
	[favorit release];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

