//
//  ParseServer.h
//  AirHealth
//
//  Created by Guilherme Ferreira de Souza on 3/26/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "InfoConvenio.h"
#import "FichaMedica.h"

@interface Usuario : NSObject <NSCoding>

@property NSString *objectID;
@property NSString *nome;
@property NSString *cpf;
@property NSString *rg;
@property NSString *endereco;
@property NSString *cep;
@property NSString *cidade;
@property NSString *estado;
@property NSString *email;
@property NSString *telefone;
@property NSString *senha;

- (void)encodeWithCoder:(NSCoder *)coder;
- (Usuario *)initWithCoder:(NSCoder *)decoder;



@end
