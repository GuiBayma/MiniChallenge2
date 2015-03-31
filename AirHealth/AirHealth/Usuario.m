//
//  ParseServer.m
//  AirHealth
//
//  Created by Guilherme Ferreira de Souza on 3/26/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "Usuario.h"
#import "FichaMedica.h"

@implementation Usuario 

@synthesize nome;
//@dynamic nome, cpf, rg, email, senha;

- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.nome forKey:@"nomeUsu"];
    [coder encodeObject:self.cpf forKey:@"cpfUsu"];
    [coder encodeObject:self.rg forKey:@"rgUsu"];
    [coder encodeObject:self.email forKey:@"emailUsu"];
    
}

- (Usuario *)initWithCoder:(NSCoder *)decoder {
    
    self.nome = [decoder decodeObjectForKey:@"nomeUsu"];
    self.cpf = [decoder decodeObjectForKey:@"cpfUsu"];
    self.rg = [decoder decodeObjectForKey:@"rgUsu"];
    self.email = [decoder decodeObjectForKey:@"emailUsu"];
    
    return self;
}







@end
