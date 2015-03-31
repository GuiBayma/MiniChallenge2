//
//  InfoConvenio.h
//  AirHealth
//
//  Created by Guilherme Ferreira de Souza on 3/27/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface InfoConvenio : NSObject <NSCoding>

@property (nonatomic, retain) NSString *objectID;

@property NSString *numCartao;
@property NSString *beneficiario;
@property NSString *titular;
@property NSDate *inicioValidade;
@property NSDate *terminoValidade;

- (void)encodeWithCoder:(NSCoder *)coder;
- (InfoConvenio *)initWithCoder:(NSCoder *)decoder;

@end
