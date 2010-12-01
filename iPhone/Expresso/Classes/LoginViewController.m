//
//  LoginViewController.m
//  Expresso
//
//  Created by David Cortés Fulla on 01/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import "LoginViewController.h"


@implementation LoginViewController


#pragma mark -
#pragma mark Controlador de l'inici de sessió

- (IBAction)iniciaSessio{
	NSLog(@"Botó apretat");
	NSString *nom = [nombre text];
	NSString *pass = [contrasena text];
	
	NSLog(@"%@",nom);
	NSLog(@"%@",pass);
	
	responseData = [[NSMutableData data] retain];
	
	NSMutableURLRequest *request = [NSMutableURLRequest 
                                    requestWithURL:[NSURL URLWithString:@"http://expresso.webservice/orders/ident_client"]];
	
	NSString *params = [[NSString alloc] initWithFormat:@"user=%@&pass=%@",nom,pass];
	NSLog(@"%@",params);
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	[params release];
	
}

#pragma mark -
#pragma mark Delegat del NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	
	NSString *datos = [[NSString alloc]  initWithBytes:[data bytes]
												length:[data length] encoding: NSUTF8StringEncoding];
	NSLog(@"%@",datos);
	
	[datos release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"%@",error);
}



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
	 NSLog(@"arriba aqui");
 }
 

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
