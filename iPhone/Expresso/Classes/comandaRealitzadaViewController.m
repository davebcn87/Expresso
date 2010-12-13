////  ComandaRealitzadaViewController.m//  Expresso////  Created by David Cortés Fulla on 08/12/10.//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.//#import "ComandaRealitzadaViewController.h"#import "Favorits.h"#import "Extra.h"#import "XML2NSDictionary.h"@implementation ComandaRealitzadaViewController@synthesize producte;@synthesize subproducte;@synthesize extres;@synthesize preu;@synthesize guardarBeguda;// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.#pragma mark -#pragma mark Accions de la vista- (IBAction) guardaBeguda{	NSLog(@"Guarda Fav");	Favorits *favorit = (Favorits *)[NSEntityDescription insertNewObjectForEntityForName:@"Favorits" inManagedObjectContext:[appDelegate managedObjectContext]];		NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];	[formater setNumberStyle:NSNumberFormatterDecimalStyle];		favorit.producte = 	[producte text];	favorit.subproducte = [subproducte text];	favorit.preu = [appDelegate preu];	favorit.tamany = [appDelegate tamany];	favorit.usuari = [appDelegate usuari];		Extra *extra;	for (int i=0; i<[[appDelegate extres] count]; i++) {		extra = (Extra *)[NSEntityDescription insertNewObjectForEntityForName:@"Extra" inManagedObjectContext:[appDelegate managedObjectContext]];		extra.nom = [[[appDelegate extres] allKeys] objectAtIndex:i];		extra.preu = [formater numberFromString:[[appDelegate extres] valueForKey:extra.nom]];		[favorit addExtresObject:extra];	}	NSError *error;		if (![[appDelegate managedObjectContext] save:&error]){		//no se ha podido guardar el resultado. Hacer un aviso al usuario o reiniciar la aplicacion.		NSLog(@"Error %@", error);	}	else{		NSLog(@"Agregada beguda!");	}		[guardarBeguda setAlpha:0.5];	[guardarBeguda setEnabled:NO];}- (IBAction) acceptarComanda{	NSLog(@"Acceptem la comanda");		NSLog(@"Credits:%@, Preu:%@",[appDelegate credits],[appDelegate preu]);		if ([[appDelegate preu] floatValue] <= [[appDelegate credits] floatValue]){		//NSMutableURLRequest *request = [NSMutableURLRequest 		//								requestWithURL:[NSURL URLWithString:@"https://expresso.webservice/orders/"]];				NSMutableURLRequest *request = [NSMutableURLRequest 										requestWithURL:[NSURL URLWithString:@"https://10.0.2.1/orders/"]];				NSLog(@"Contingut de la beguda: %@",[subproducte text]);		NSString *beguda = [NSString stringWithFormat:@"%@ %@",[producte text],[subproducte text]];		NSString *preuSt = [NSString stringWithFormat:@"%@", [appDelegate preu]];		NSLog(@"%@", preuSt);		NSString *nom =	[appDelegate usuari];		NSString *sessio = [appDelegate idSessio];		NSString *extresSt = [NSString stringWithFormat:@"%@",[[[appDelegate extres] allKeys] componentsJoinedByString:@", "]];		NSString *params = [[[NSString alloc] initWithFormat:@"data[Order][sessio]=%@&data[Order][preu]=%@&data[Order][product]=%@&data[Order][name]=%@&data[Order][complement1]=%@", 											  sessio,											  preuSt,											  beguda,											  nom,											  extresSt											  ] 										autorelease];		NSLog(@"%@",params);		[request setHTTPMethod:@"POST"];		[request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];		[[NSURLConnection alloc] initWithRequest:request delegate:self];				NSLog(@"Comanda enviada!");	}	else {		NSLog(@"Ets pobre! Recarga el saldo inútil!");		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No tens crèdits" 														message:@"No tens prous crèdits per realitzar la compra que has efectuat." 													   delegate:nil 											  cancelButtonTitle:@"Acceptar" 											  otherButtonTitles: nil];		[alert show];	}	}- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];    if (self) {        // Custom initialization.		f = [[NSNumberFormatter alloc] init];		[f setNumberStyle:NSNumberFormatterCurrencyStyle];		[f setCurrencySymbol:@"€ "];    }    return self;}#pragma mark -#pragma mark Delegat del NSURLConnection- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{	NSString *datos = [[[NSString alloc]  initWithBytes:[data bytes]												 length:[data length] encoding: NSUTF8StringEncoding] autorelease];	NSLog(@"%@",datos);		/**************     INICI DEL PARSER DE LOGIN     **************/		XML2NSDictionary* parseDelegateComanda = [[XML2NSDictionary alloc] init];	NSXMLParser *parserComanda = [[NSXMLParser alloc] initWithData:data];		//Establim l'XML2Dictionary com a delegate	parserComanda.delegate = parseDelegateComanda;		//Parsejem	[parserComanda parse];			NSLog(@"%@",[parseDelegateComanda.result class]);//	NSMutableDictionary *comanda = parseDelegateComanda.result;	NSString *result = [[NSString alloc] initWithFormat:@"%@",[[parseDelegateComanda.result valueForKey:@"add_action"]															   objectForKey:@"result"]];	//Login OK!	if ([result isEqualToString: @"1"]){		NSLog(@"Pagament OK!");				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Café preparant-se..." 														message:@"La teva comanda ha sigut processada correctament. Gràcies per utilitzar Expresso." 													   delegate:nil 											  cancelButtonTitle:@"Acceptar" 											  otherButtonTitles: nil];		[alert show];				NSNumber *creditsNous = [[NSNumber alloc] initWithFloat: [appDelegate.credits floatValue] - [appDelegate.preu floatValue]];		[appDelegate setCredits: creditsNous];		[[[[appDelegate navigationController] viewControllers] objectAtIndex:0] actualitzaVista];		[[appDelegate navigationController] popToRootViewControllerAnimated:YES ];	}    else{		NSString *error = (NSString*)[[parseDelegateComanda.result valueForKey:@"add_action"]									  objectForKey:@"message"];		NSLog(@"ERROR!!:%@",error);				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 														message:error													   delegate:nil 											  cancelButtonTitle:@"Acceptar" 											  otherButtonTitles: nil];		[alert show];    }		[parseDelegateComanda release];	[parserComanda release];}- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];}- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])		//if ([[NSString stringWithFormat:@"%@",challenge.protectionSpace.host] isEqualToString:@"expresso.webservice"])			[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];		[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];}	#pragma mark -#pragma mark View LifeCicle// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.- (void)viewDidLoad {	[super viewDidLoad];		appDelegate = (ExpressoAppDelegate*)[[UIApplication sharedApplication] delegate];	//Si venim de favorit			NSLog(@"Producte: %@", [appDelegate producte]);				producteDictionary = [[[[appDelegate carta] valueForKey:@"carta"] valueForKey:@"productes"]							  objectAtIndex:[[appDelegate producte] unsignedIntValue]];				[producte setText:[producteDictionary valueForKey:@"nom"]];				[subproducte setText:[[[producteDictionary valueForKey:@"subproductes"] 							   objectAtIndex:[[appDelegate subproducte] unsignedIntValue]] valueForKey:@"nom"]];				[extres setText:[[[appDelegate extres] allKeys] componentsJoinedByString:@", "]];							[preu setText:[f stringFromNumber:[appDelegate preu]]];		}/*// Override to allow orientations other than the default portrait orientation.- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {    // Return YES for supported orientations.    return (interfaceOrientation == UIInterfaceOrientationPortrait);}*/- (void)didReceiveMemoryWarning {    // Releases the view if it doesn't have a superview.    [super didReceiveMemoryWarning];        // Release any cached data, images, etc. that aren't in use.}- (void)viewDidUnload {    [super viewDidUnload];    // Release any retained subviews of the main view.    // e.g. self.myOutlet = nil;}- (void)dealloc {    [super dealloc];}@end