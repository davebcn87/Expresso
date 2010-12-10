//
//  Extra.h
//  Expresso
//
//  Created by David Cortés Fulla on 10/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Extra :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * Quantitat;
@property (nonatomic, retain) NSString * nomExtra;

@end



