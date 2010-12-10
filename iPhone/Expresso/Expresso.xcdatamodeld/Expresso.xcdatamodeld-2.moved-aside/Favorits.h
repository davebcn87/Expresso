//
//  Favorits.h
//  Expresso
//
//  Created by David Cortés Fulla on 09/12/10.
//  Copyright 2010 Facultat d'Informatica de Barcelona (UPC). All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Favorits :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * nom_producte;
@property (nonatomic, retain) NSNumber * id_producte;
@property (nonatomic, retain) NSString * usuari;
@property (nonatomic, retain) NSNumber * preu;

@end



