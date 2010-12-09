//
//  ComandaRealitzadaViewController.h
//  Expresso
//
//  Created by David Cortés Fulla on 08/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpressoAppDelegate.h"


@interface ComandaRealitzadaViewController : UIViewController {
	IBOutlet UILabel *producte;
	IBOutlet UILabel *preu;
	IBOutlet UILabel *extres;
	IBOutlet UILabel *producteReflex;
	IBOutlet UILabel *extresReflex;
}

@property (nonatomic, retain) IBOutlet UILabel *producte;
@property (nonatomic, retain) IBOutlet UILabel *producteReflex;
@property (nonatomic, retain) IBOutlet UILabel *preu;
@property (nonatomic, retain) IBOutlet UILabel *extres;
@property (nonatomic, retain) IBOutlet UILabel *extresReflex;

-(IBAction) guardaBeguda;
@end
