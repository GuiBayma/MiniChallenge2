//
//  HKHealthStore+AAPLExtensions.h
//  AirHealth
//
//  Created by Kaique Damato on 3/26/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <Foundation/Foundation.h>
@import HealthKit;

@interface HKHealthStore (AAPLExtensions)

- (void)aapl_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(HKQuantity *mostRecentQuantity, NSError *error))completion;

@end
