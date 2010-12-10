//
//  Favorits.h
//  Expresso
//
//  Created by Arol Viñolas Martinez on 10/12/10.
//  Copyright 2010 FIB (UPC). All rights reserved.
//

#import <CoreData/CoreData.h>

@class Extra;

@interface Favorits :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * producte;
@property (nonatomic, retain) NSString * subproducte;
@property (nonatomic, retain) NSString * tamany;
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

