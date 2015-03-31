//
//  FichaMedica.h
//  AirHealth
//
//  Created by Guilherme Ferreira de Souza on 3/27/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface FichaMedica : NSObject <NSCoding>

@property (nonatomic, retain) NSString *objectID;

@property NSDate *dataNascimento;
@property NSString *sexo;
@property NSString *grupoSanguineo;

@property NSNumber *altura;
@property NSNumber *indiceMassaCorporal;
//@property NSNumber *massaCorporalMagra;
//@property NSNumber *percentualGorduraCorporal;
@property NSNumber *peso;

//@property NSNumber *frequenciaCardiaca;
//@property NSNumber *frequenciaRespiratoria;
@property NSNumber *pressaoArterialSistolica;
@property NSNumber *pressaoArterialDiastolica;
@property NSNumber *temperaturaCorporal;

- (void)encodeWithCoder:(NSCoder *)coder;
- (FichaMedica *)initWithCoder:(NSCoder *)decoder;

@end
