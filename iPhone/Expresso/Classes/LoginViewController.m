////  LoginViewController.m//  Expresso////  Created by David Cortés Fulla on 01/12/10.//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.//#import "ExpressoAppDelegate.h"#import "LoginViewController.h"#import "XML2NSDictionary.h"//#import "MerdaViewController.h"@implementation LoginViewController@synthesize nombre;@synthesize contrasena;@synthesize inicia;#pragma mark -#pragma mark Controlador de l'inici de sessió- (IBAction)iniciaSessio{	NSLog(@"Botó apretat");	NSString *nom = [nombre text];	NSString *pass = [contrasena text];		NSLog(@"%@",nom);	NSLog(@"%@",pass);		responseData = [[NSMutableData data] retain];		NSMutableURLRequest *request = [NSMutableURLRequest                                     requestWithURL:[NSURL URLWithString:@"http://expresso.webservice/orders/ident_client"]];		NSString *params = [[[NSString alloc] initWithFormat:@"user=%@&pass=%@",nom,pass] autorelease];	NSLog(@"%@",params);	[request setHTTPMethod:@"POST"];	[request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];	[[NSURLConnection alloc] initWithRequest:request delegate:self];		//[params release];	}#pragma mark -#pragma mark Delegat del NSURLConnection- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{		NSString *datos = [[[NSString alloc]  initWithBytes:[data bytes]												length:[data length] encoding: NSUTF8StringEncoding] autorelease];	NSLog(@"%@",datos);		/**************		DEMO XML2Dictionary		*****************/	//Inicialitzem el parserDelegate i les dades de l'acces url	XML2NSDictionary* parseDelegate = [[XML2NSDictionary alloc] init];	NSURL *url = [[NSURL alloc] initWithString:@"http://expresso.webservice/orders/get_carta"];	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];		//Establim l'XML2Dictionary com a delegate	parser.delegate = parseDelegate;		//Parsejem	[parser parse];	//Naveguem pel resultat del parseig	NSLog(@"%@",[parseDelegate.result class]);	NSMutableDictionary *carta = parseDelegate.result;	NSObject *unrecognizedObject = [[[parseDelegate.result valueForKey:@"carta"] 									valueForKey:@"productes"] 									objectAtIndex:0];		NSArray *arrResult = [(NSMutableDictionary*)unrecognizedObject allValues];	NSLog(@"Keys: %@", [arrResult componentsJoinedByString:@" "]);		[url release];	[parser release];	[carta release];	[unrecognizedObject release];//	[arrResult release]; AQUEST NO CAL	[parseDelegate release];	/*********************************************************/		/*************	A descomentar quan hi hagi algo amb que navegar *****************	ExpressoAppDelegate *appDelegate = (ExpressoAppDelegate*)[[UIApplication sharedApplication] delegate];		MerdaViewController *merdaVC = [[MerdaViewController alloc] initWithNibName:@"MerdaViewController" bundle:nil];	[appDelegate.navigationController pushViewController:merdaVC animated:YES];	/********************************************************************************/		//En cas de ser un login correcte	[self dismissModalViewControllerAnimated:YES];	//ExpressoAppDelegate *appDelegate = (ExpressoAppDelegate*)[[UIApplication sharedApplication] delegate];	//[appDelegate.navigationController dismissModalViewControllerAnimated:YES];}- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{	NSLog(@"%@",error);}/* // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad. - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil { if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) { // Custom initialization } return self; } */#pragma mark -#pragma mark View Controller Lifecycle // Implement viewDidLoad to do additional setup after loading the view, typically from a nib. - (void)viewDidLoad { [super viewDidLoad];	 //self.navigationItem.title = @"Puta!";	 NSLog(@"arriba aqui"); } /* // Override to allow orientations other than the default portrait orientation. - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { // Return YES for supported orientations return (interfaceOrientation == UIInterfaceOrientationPortrait); } */- (void)didReceiveMemoryWarning {    // Releases the view if it doesn't have a superview.    [super didReceiveMemoryWarning];        // Release any cached data, images, etc that aren't in use.}- (void)viewDidUnload {    [super viewDidUnload];    // Release any retained subviews of the main view.    // e.g. self.myOutlet = nil;}- (void)dealloc {    [super dealloc];}@end