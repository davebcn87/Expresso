////  TamanysViewController.h//  Expresso////  Created by Arol Viñolas Martinez on 08/12/10.//  Copyright 2010 FIB (UPC). All rights reserved.//#import <UIKit/UIKit.h>@interface TamanysViewController : UIViewController {	IBOutlet UIButton *botoSmall;	IBOutlet UIButton *botoGrande;	IBOutlet UIButton *botoVenti;		IBOutlet UILabel *labelSmall;	IBOutlet UILabel *labelGrande;	IBOutlet UILabel *labelVenti;		IBOutlet UILabel *preuSmall;	IBOutlet UILabel *preuGrande;	IBOutlet UILabel *preuVenti;		IBOutlet UIButton *botoExtres;	IBOutlet UIButton *botoFerComanda;		NSDictionary *subproducte;		NSNumberFormatter * f;	}@property (nonatomic,retain) IBOutlet UIButton *botoSmall;@property (nonatomic,retain) IBOutlet UIButton *botoGrande;@property (nonatomic,retain) IBOutlet UIButton *botoVenti;@property (nonatomic,retain) IBOutlet UILabel *labelSmall;@property (nonatomic,retain) IBOutlet UILabel *labelGrande;@property (nonatomic,retain) IBOutlet UILabel *labelVenti;@property (nonatomic,retain) IBOutlet UILabel *preuSmall;@property (nonatomic,retain) IBOutlet UILabel *preuGrande;@property (nonatomic,retain) IBOutlet UILabel *preuVenti;@property (nonatomic,retain) IBOutlet UIButton *botoExtres;@property (nonatomic,retain) IBOutlet UIButton *botoFerComanda;@property (nonatomic, assign) NSDictionary *subproducte;-(IBAction) escollirTamany:(id)sender;-(IBAction) ferComanda;@end