//
//  Favorits.h
//  Expresso
//
//  Created by David Cortés Fulla on 10/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import <CoreData/CoreData.h>

@class Extra;

@interface Favorits :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * nom_producte;
@property (nonatomic, retain) NSNumber * preu;
@property (nonatomic, retain) NSString * usuari;
@property (nonatomic, retain) NSSet* extres;

@end


@interface Favorits (CoreDataGeneratedAccessors)
- (void)addExtresObject:(Extra *)value;
- (void)removeExtresObject:(Extra *)value;
- (void)addExtres:(NSSet *)value;
- (void)removeExtres:(NSSet *)value;

@end

