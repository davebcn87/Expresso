//
//  LoginViewController.h
//  Expresso
//
//  Created by David Cortés Fulla on 30/11/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController {

@private
	UITextField *nombre;
	UITextField *contrasena;
	UIButton *inicia;
	NSMutableData *responseData;
}

@property (nonatomic, retain) IBOutlet UITextField *nombre;
@property (nonatomic, retain) IBOutlet UITextField *contrasena;
@property (nonatomic, retain) IBOutlet UITextField *inicia;

-(IBAction) iniciaSessio;

#pragma mark -
#pragma mark Delegat del NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end
