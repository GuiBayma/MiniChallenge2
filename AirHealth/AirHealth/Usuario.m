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

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _nome = @"";
        _cpf = @"";
        _rg = @"";
        _endereco = @"";
        _cep = @"";
        _cidade = @"";
        _estado = @"";
        _email = @"";
        _telefone = @"";
        _senha = @"";
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.objectID forKey:@"usuObjectID"];
    [coder encodeObject:self.nome forKey:@"nomeUsu"];
    [coder encodeObject:self.cpf forKey:@"cpfUsu"];
    [coder encodeObject:self.rg forKey:@"rgUsu"];
    [coder encodeObject:self.endereco forKey:@"enderecoUsu"];
    [coder encodeObject:self.cep forKey:@"cepUsu"];
    [coder encodeObject:self.cidade forKey:@"cidadeUsu"];
    [coder encodeObject:self.estado forKey:@"estadoUsu"];
    [coder encodeObject:self.email forKey:@"emailUsu"];
    [coder encodeObject:self.telefone forKey:@"telefoneUsu"];
    
    [coder encodeObject:self.senha forKey:@"senhaUsu"];
    
}

- (Usuario *)initWithCoder:(NSCoder *)decoder {
    
    self.objectID = [decoder decodeObjectForKey:@"usuObjectID"];
    self.nome = [decoder decodeObjectForKey:@"nomeUsu"];
    self.cpf = [decoder decodeObjectForKey:@"cpfUsu"];
    self.rg = [decoder decodeObjectForKey:@"rgUsu"];
    self.endereco = [decoder decodeObjectForKey:@"enderecoUsu"];
    self.cep = [decoder decodeObjectForKey:@"cepUsu"];
    self.cidade = [decoder decodeObjectForKey:@"cidadeUsu"];
    self.estado = [decoder decodeObjectForKey:@"estadoUsu"];
    self.email = [decoder decodeObjectForKey:@"emailUsu"];
    self.telefone = [decoder decodeObjectForKey:@"telefoneUsu"];
    
    self.senha = [decoder decodeObjectForKey:@"senhaUsu"];
    
    return self;
}







@end
