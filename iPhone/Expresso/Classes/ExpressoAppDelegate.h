//
//  ExpressoAppDelegate.h
//  Expresso
//
//  Created by David Cortés on 18/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ExpressoAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	UITextField *nombre;
	UITextField *contrasena;
	UIButton *inicia;
	NSMutableData *responseData;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UITextField *nombre;
@property (nonatomic, retain) IBOutlet UITextField *contrasena;
@property (nonatomic, retain) IBOutlet UITextField *inicia;

- (NSString *)applicationDocumentsDirectory;

-(IBAction) iniciaSessio;

#pragma mark -
#pragma mark Delegat del NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end

