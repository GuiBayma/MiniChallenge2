//
//  FichaMedicaTableViewController.h
//  AirHealth
//
//  Created by Kaique Damato on 3/26/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HealthKit;

@interface FichaMedicaTableViewController : UITableViewController

@property (nonatomic) HKHealthStore *healthStore;

@end
