////  LoginViewController.m//  Expresso////  Created by David Cortés Fulla on 01/12/10.//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.//#import "ExpressoAppDelegate.h"#import "LoginViewController.h"#import "XML2NSDictionary.h"//#import "MerdaViewController.h"@implementation LoginViewController@synthesize nombre;@synthesize contrasena;@synthesize inicia;#pragma mark -#pragma mark Controlador de l'inici de sessió- (IBAction)iniciaSessio{	NSLog(@"Botó apretat");	NSString *nom = [nombre text];	NSString *pass = [contrasena text];		NSLog(@"%@",nom);	NSLog(@"%@",pass);		responseData = [[NSMutableData data] retain];	   	NSMutableURLRequest *request = [NSMutableURLRequest                                     requestWithURL:[NSURL URLWithString:@"http://expresso.herokuapp.com/api/login"]];    /*      	NSMutableURLRequest *request = [NSMutableURLRequest                                     requestWithURL:[NSURL URLWithString:@"http://192.168.2.101:3000/api/login"]];    */    	NSString *params = [[[NSString alloc] initWithFormat:@"user=%@&pass=%@",nom,pass] autorelease];	NSLog(@"%@",params);	[request setHTTPMethod:@"POST"];	[request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];	[[NSURLConnection alloc] initWithRequest:request delegate:self];		//[params release];	}#pragma mark -#pragma mark Delegat del NSURLConnection- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{    NSLog(@"%@",data);        NSArray *result = [data yajl_JSON];        NSLog(@"%@",result);    	if ([[result valueForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:1]]){        		float   creditsInt = [[result valueForKey:@"credits"] floatValue];			NSString *idSessio = [result valueForKey:@"idSessio"];		NSLog(@"%@",idSessio);		NSLog(@"%@",result);		NSLog(@"%f",creditsInt);        		/*Descomentar per veure els credits en un alert *				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login OK" 														message:[NSString stringWithFormat: @"Molt bé, tens %.1f € per gastar",creditsInt]													   delegate:nil 											  cancelButtonTitle:@"Acceptar" 											  otherButtonTitles: nil];		[alert show];		 		*/				ExpressoAppDelegate *appDelegate = [ExpressoAppDelegate instance];		[appDelegate setCredits:[NSNumber numberWithFloat:creditsInt]];		[appDelegate setUsuari:[nombre text]];		[appDelegate setIdSessio:idSessio];						[appDelegate setContrasenya:[contrasena text]];		[appDelegate actualitzaVistes];				[self dismissModalViewControllerAnimated:YES];	}	else{				NSString *error = [result valueForKey:@"message"];		NSLog(@"ERROR!!:%@",error);								UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 														message:error													   delegate:nil 											  cancelButtonTitle:@"Acceptar" 											  otherButtonTitles: nil];		[alert show];		nombre.text = @"";		contrasena.text = @"";	}//[unrecognizedObjectLogin release];}- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{	NSLog(@"%@",error);		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 													message:[NSString stringWithFormat:@"%@",error]												   delegate:nil 										  cancelButtonTitle:@"Acceptar" 										  otherButtonTitles: nil];	[alert show];}- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];}- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])		//if ([[NSString stringWithFormat:@"%@",challenge.protectionSpace.host] isEqualToString:@"expresso.webservice"])			[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];		[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];}	/* // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad. - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil { if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) { // Custom initialization } return self; } */#pragma mark -#pragma mark View Controller Lifecycle // Implement viewDidLoad to do additional setup after loading the view, typically from a nib. - (void)viewDidLoad { [super viewDidLoad];	 self.navigationItem.title = @"First View!";	 NSLog(@"arriba aqui"); } /* // Override to allow orientations other than the default portrait orientation. - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { // Return YES for supported orientations return (interfaceOrientation == UIInterfaceOrientationPortrait); } */- (void)didReceiveMemoryWarning {    // Releases the view if it doesn't have a superview.    [super didReceiveMemoryWarning];        // Release any cached data, images, etc that aren't in use.}- (void)viewDidUnload {    [super viewDidUnload];    // Release any retained subviews of the main view.    // e.g. self.myOutlet = nil;}- (void)dealloc {    [super dealloc];}@end