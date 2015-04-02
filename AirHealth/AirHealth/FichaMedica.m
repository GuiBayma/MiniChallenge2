//
//  FichaMedica.m
//  AirHealth
//
//  Created by Guilherme Ferreira de Souza on 3/27/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "FichaMedica.h"

@implementation FichaMedica

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.dataNascimento = [NSDate date];
        self.sexo = @"";
        self.grupoSanguineo = @"";
        self.altura = [NSNumber numberWithInt:0];
        self.indiceMassaCorporal = [NSNumber numberWithInt:0];
        self.peso = [NSNumber numberWithInt:0];
        self.pressaoArterialDiastolica = [NSNumber numberWithInt:0];
        self.pressaoArterialSistolica = [NSNumber numberWithInt:0];
        self.temperaturaCorporal = [NSNumber numberWithInt:0];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.objectID forKey:@"fichaObjectID"];
    [coder encodeObject:self.dataNascimento forKey:@"dataNascimento"];
    [coder encodeObject:self.sexo forKey:@"sexo"];
    [coder encodeObject:self.grupoSanguineo forKey:@"grupoSanguineo"];
    
    [coder encodeObject:self.altura forKey:@"altura"];
    [coder encodeObject:self.indiceMassaCorporal forKey:@"imc"];
    //[coder encodeObject:self.massaCorporalMagra forKey:@"massaCorporalMagra"];
    //[coder encodeObject:self.percentualGorduraCorporal forKey:@"gorduraCorporal"];
    [coder encodeObject:self.peso forKey:@"peso"];
    
    //[coder encodeObject:self.frequenciaCardiaca forKey:@"frequenciaCardiaca"];
    //[coder encodeObject:self.frequenciaRespiratoria forKey:@"frequenciaRespiratoria"];
    [coder encodeObject:self.pressaoArterialSistolica forKey:@"pressaoSistolica"];
    [coder encodeObject:self.pressaoArterialDiastolica forKey:@"pressaoDiastolica"];
    [coder encodeObject:self.temperaturaCorporal forKey:@"temperaturaCorporal"];
    
    
}

- (FichaMedica *)initWithCoder:(NSCoder *)decoder {
    
    [self setObjectID:[decoder decodeObjectForKey:@"fichaObjectID"]];
    [self setDataNascimento:[decoder decodeObjectForKey:@"dataNascimento"]];
    [self setSexo:[decoder decodeObjectForKey:@"sexo"]];
    [self setGrupoSanguineo:[decoder decodeObjectForKey:@"grupoSanguineo"]];
    
    [self setAltura:[decoder decodeObjectForKey:@"altura"]];
    [self setIndiceMassaCorporal:[decoder decodeObjectForKey:@"imc"]];
    //[self setMassaCorporalMagra:[decoder decodeObjectForKey:@"massaCorporalMagra"]];
    //[self setPercentualGorduraCorporal:[decoder decodeObjectForKey:@"gorduraCorporal"]];
    [self setPeso:[decoder decodeObjectForKey:@"peso"]];
    
    //[self setFrequenciaCardiaca:[decoder decodeObjectForKey:@"frequenciaCardiaca"]];
    //[self setFrequenciaRespiratoria:[decoder decodeObjectForKey:@"frequenciaRespiratoria"]];
    [self setPressaoArterialSistolica:[decoder decodeObjectForKey:@"pressaoSistolica"]];
    [self setPressaoArterialDiastolica:[decoder decodeObjectForKey:@"pressaoDiastolica"]];
    [self setTemperaturaCorporal:[decoder decodeObjectForKey:@"temperaturaCorporal"]];
    
    
    return nil;
    
}


@end
