//
//  SincronizarViewController.h
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 30/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SincronizarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageCruz;
@property (weak, nonatomic) IBOutlet UIButton *buttonSincronizar;
- (IBAction)sincronizar:(id)sender;

@end