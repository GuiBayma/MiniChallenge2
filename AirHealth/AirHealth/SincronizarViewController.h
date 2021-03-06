//
//  SincronizarViewController.h
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 30/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HealthKit;
#import "PageViewController.h"

@interface SincronizarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageCruz;
@property (weak, nonatomic) IBOutlet UIButton *buttonSincronizar;
@property (weak, nonatomic) IBOutlet UILabel *labelSincronizando;
@property (weak, nonatomic) IBOutlet UILabel *labelSenha;
@property (weak, nonatomic) IBOutlet UILabel *labelOk;
@property (weak, nonatomic) IBOutlet UIImageView *imageOk;
@property  HKHealthStore *healthStore;
- (void)sincronizar:(id)sender;

@end
