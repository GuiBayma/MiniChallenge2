//
//  ConfiguracoesTableViewController.h
//  AirHealth
//
//  Created by Kaique Damato on 3/25/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"
@import HealthKit;

@interface ConfiguracoesTableViewController : UITableViewController<UIAlertViewDelegate>

@property HKHealthStore *healthStore;

- (IBAction)apagarTodosDados:(id)sender;


@end
