//
//  InfoConvenio.m
//  AirHealth
//
//  Created by Guilherme Ferreira de Souza on 3/27/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "InfoConvenio.h"

@implementation InfoConvenio


- (InfoConvenio *)initWithCoder:(NSCoder *)decoder {
    self.nomePlanodeSaude = [decoder decodeObjectForKey:@"nomePlano"];
    self.numCartao = [decoder decodeObjectForKey:@"numCartao"];
    self.titular = [decoder decodeObjectForKey:@"titular"];
    self.beneficiario = [decoder decodeObjectForKey:@"beneficiario"];
    self.inicioValidade = [decoder decodeObjectForKey:@"inicio"];
    self.terminoValidade = [decoder decodeObjectForKey:@"termino"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.nomePlanodeSaude forKey:@"nomePlano"];
    [coder encodeObject:self.numCartao forKey:@"numCartao"];
    [coder encodeObject:self.titular forKey:@"titular"];
    [coder encodeObject:self.beneficiario forKey:@"beneficiario"];
    [coder encodeObject:self.inicioValidade forKey:@"inicio"];
    [coder encodeObject:self.terminoValidade forKey:@"termino"];
}

@end
