//
//  ComandaRealitzadaViewController.m
//  Expresso
//
//  Created by David Cortés Fulla on 08/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import "ComandaRealitzadaViewController.h"


@implementation ComandaRealitzadaViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[preu setText:@"4,55 €"];
	[producte setText:@"Capuccino"];	
	[producteReflex setText:@"Capuccino"];
	[extres setText:@"Extres: 2 shots"];
	[extresReflex setText:@"Extres: 2 shots"];
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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
