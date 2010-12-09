////  ProducteViewController.m//  Expresso////  Created by Arol Viñolas Martinez on 08/12/10.//  Copyright 2010 FIB (UPC). All rights reserved.//#import "ExpressoAppDelegate.h"#import "ProducteViewController.h"#import "SubproducteViewController.h"#import "FavoritsViewController.h"@implementation ProducteViewController@synthesize tableView;#pragma mark -#pragma mark View Controller lifecycle// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad./*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];    if (self) {        // Custom initialization.    }    return self;}*/// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.- (void)viewDidLoad {    [super viewDidLoad];	[tableView setBackgroundColor:[UIColor clearColor]];}/*// Override to allow orientations other than the default portrait orientation.- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {    // Return YES for supported orientations.    return (interfaceOrientation == UIInterfaceOrientationPortrait);}*/- (void)didReceiveMemoryWarning {    // Releases the view if it doesn't have a superview.    [super didReceiveMemoryWarning];        // Release any cached data, images, etc. that aren't in use.}- (void)viewDidUnload {    [super viewDidUnload];    // Release any retained subviews of the main view.    // e.g. self.myOutlet = nil;}- (void)dealloc {    [super dealloc];}#pragma mark -#pragma mark UITableViewDelegate operations-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	NSLog(@"%i",indexPath.section);			UITableViewCell *cell = [[[UITableViewCell alloc] 							  initWithStyle:UITableViewCellStyleDefault 							  reuseIdentifier:@"celdaProducte"] autorelease];		if (indexPath.section==0){		ExpressoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];		NSString *nameAtIndexPath = [[[NSString alloc] initWithString:									 [[[[[appDelegate carta] valueForKey:@"carta"] valueForKey:@"productes"] 									   objectAtIndex:[indexPath row]] valueForKey:@"nom"]									 ] autorelease];						NSString *path = [[NSBundle mainBundle] pathForResource:@"cafe" ofType:@"png"];		UIImage *theImage = [UIImage imageWithContentsOfFile:path];				cell.textLabel.text = nameAtIndexPath;		cell.imageView.image = theImage;		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];				[cell setSelectionStyle:UITableViewCellSelectionStyleBlue];			}	else{		cell.textLabel.text = @"Veure favorits";			}	return cell;}- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {	return 2;}-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	if (section==0){		ExpressoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];		return [[[[appDelegate carta] valueForKey:@"carta"] valueForKey:@"productes"] count];	}	else {		return 1;	}}-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{	if (section==0){		NSLog(@"Productes");		return @"Productes";	}	else if (section==1) {		NSLog(@"Favorits");		return @"Favorits";	}}- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{	// create the parent view that will hold header Label	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];		// create the button object	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];	headerLabel.backgroundColor = [UIColor clearColor];	headerLabel.opaque = NO;	headerLabel.textColor = [UIColor colorWithRed:0.28 green:0.41 blue:0.32 alpha:1];	headerLabel.highlightedTextColor = [UIColor whiteColor];	headerLabel.font = [UIFont boldSystemFontOfSize:17];	headerLabel.frame = CGRectMake(20.0, 0.0, 300.0, 44.0);		// If you want to align the header text as centered	// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);				if (section==0){		headerLabel.text = @"Productes"; // i.e. array element	}	else if (section==1) {		headerLabel.text = @"Favorits"; // i.e. array element	}		headerLabel.shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];	[customView addSubview:headerLabel];		return customView;}- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{	return 44.0;}-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	if (indexPath.section==0){		ExpressoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];		[appDelegate setProducte:[indexPath row]];				SubproducteViewController* subproducteVC = 			[[[SubproducteViewController alloc] initWithNibName:@"SubproducteViewController" 														bundle:nil] autorelease];				[subproducteVC setProducte:[[[appDelegate.carta valueForKey:@"carta"] valueForKey:@"productes"]									objectAtIndex:[indexPath row]]];				[appDelegate.navigationController pushViewController:subproducteVC animated:YES];	}	else{		FavoritsViewController *favoritVC = [[FavoritsViewController alloc] initWithNibName:@"FavoritsViewController" bundle:nil];		ExpressoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];				[appDelegate.navigationController pushViewController:favoritVC animated:YES];		}}@end