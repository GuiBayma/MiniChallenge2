//
//  Persistencia.m
//  AirHealth
//
//  Created by Guilherme Ferreira de Souza on 3/29/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "Persistencia.h"
#import "Usuario.h"
#import "FichaMedica.h"
#import "InfoConvenio.h"

@implementation Persistencia



- (instancetype)init
{
    self = [super init];
    if (self) {
        _usuario = [self carregarUsuarioLocal];
        _fichaMedica = [self carregarFichaLocal];
        _infoConvenio = [self carregarInfoConvenioLocal];
        
        if (_usuario == nil)
            _usuario = [[Usuario alloc] init];
        
        if (_fichaMedica == nil)
            _fichaMedica = [[FichaMedica alloc] init];
        
        if (_infoConvenio == nil)
            _infoConvenio = [[InfoConvenio alloc] init];
    }
    return self;
}


/**
 * @return Instância única do objeto de Ufisuario
 **/
+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken = 0;
    __strong static Persistencia *instance = nil;
    
    dispatch_once(&onceToken,^{
        instance = [self new];
    });
    
    return instance;
}


#pragma mark DAO Parse

/**
 * @description Método responsável por iniciar a conexão com o Parse.
 */
- (void)conexaoParse {
    
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"fD0pEnOJYuRPQMaTexrZ4ZwYIg8LVsBWJgCh0PN5"
                  clientKey:@"WUGLRcGna3aYmigJoSTXSB1Waq5iEnT2R393UxZ1"];
    
}

/**
 * @description Carregar os dados do usuário da base de dados que fica na nuvem.
 */
- (Usuario *)carregarUsuarioNuvem {
    
    [self conexaoParse];

    if (![_usuario.objectID isEqualToString:@""]) {
    
        PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
        
        [query whereKey:@"objectId" equalTo:_usuario.objectID];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            
            [_usuario setNome:object[@"nome"]];
            [_usuario setCpf:object[@"cpf"]];
            [_usuario setRg:object[@"rg"]];
            [_usuario setEmail:object[@"email"]];
            
        }];
    }
    return _usuario;
    
}

- (void)salvarUsuarioNuvem:(Usuario *)usu {
    
    [self conexaoParse];
    
    PFObject *classeUsuario = [PFObject objectWithClassName:@"Usuario"];
    classeUsuario[@"nome"] = usu.nome;
    classeUsuario[@"cpf"] = usu.cpf;
    classeUsuario[@"rg"] = usu.rg;
    classeUsuario[@"email"] = usu.email;
    
    [classeUsuario saveInBackgroundWithBlock:^(bool succeeded, NSError *error) {
        if (succeeded) {
            [usu setObjectID:classeUsuario.objectId];
            _usuario = usu;
        }
    }];
    
}


#pragma mark DAO Local

/**
 * @description Método responsável por carregar os dados do usuário do User Default`s
 */
- (Usuario *)carregarUsuarioLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosUsuario = [userDefaults objectForKey:@"Usuario"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:dadosUsuario];
}


/**
 * @description Método responsável por salvar as informações do usuário no User Default`s
 */
- (void)salvarUsuarioLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosUsuario = [NSKeyedArchiver archivedDataWithRootObject: _usuario];
    [userDefaults setObject:dadosUsuario forKey:@"Usuario"];
    
    
}

/**
 * @description Método responsável por carregar os dados da ficha médica do User Default`s
 */
- (FichaMedica *)carregarFichaLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosFicha = [userDefaults objectForKey:@"FichaMedica"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:dadosFicha];
    
}

/**
 * @description Método responsável por salvar as informações da ficha médica no User Default`s
 */
- (void)salvarFichaLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosFicha = [NSKeyedArchiver archivedDataWithRootObject:_fichaMedica];
    [userDefaults setObject:dadosFicha forKey:@"FichaMedica"];
    
}


/**
 * @description Método responsável por carregar os dados da ficha médica do User Default`s
 */
- (InfoConvenio *)carregarInfoConvenioLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosConv = [userDefaults objectForKey:@"InfoConvenio"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:dadosConv];
    
}


/**
 * @description Método responsável por salvar as informações do convênio no User Default`s
 */
- (void)salvarInfoConvenioLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosConv = [NSKeyedArchiver archivedDataWithRootObject:_infoConvenio];
    [userDefaults setObject:dadosConv forKey:@"InfoConvenio"];
    
}



@end
