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
 * @description Carregar os dados do usuário da base de dados que fica na nuvem. O método atualiza o objeto de usuário da classe, mas é necessário que a propriedade 'objectID' do objeto esteja preenchido.
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
            [_usuario setEndereco:object[@"endereco"]];
            [_usuario setCep:object[@"cep"]];
            [_usuario setCidade:object[@"cidade"]];
            [_usuario setEstado:object[@"estado"]];
            [_usuario setEmail:object[@"email"]];
            
        }];
    }
    return _usuario;
    
}


/**
 * @description Salva o objeto usuário no servidor em cloud.
 */
- (void)salvarUsuarioNuvem {
    
    [self conexaoParse];
    
    PFObject *classeUsuario = [PFObject objectWithClassName:@"Usuario"];
    classeUsuario[@"nome"] = _usuario.nome;
    classeUsuario[@"cpf"] = _usuario.cpf;
    classeUsuario[@"rg"] = _usuario.rg;
    classeUsuario[@"endereco"] = _usuario.endereco;
    classeUsuario[@"cep"] = _usuario.cep;
    classeUsuario[@"cidade"] = _usuario.cidade;
    classeUsuario[@"estado"] = _usuario.estado;
    classeUsuario[@"email"] = _usuario.email;
    
    [classeUsuario saveInBackgroundWithBlock:^(bool succeeded, NSError *error) {
        if (succeeded) {
            [_usuario setObjectID:classeUsuario.objectId];
        }
    }];
    
}

/**
 * @description Carregar os dados da ficha médica da base de dados que fica na nuvem. O método atualiza o objeto de ficha médica da classe, mas é necessário que a propriedade 'objectID' do objeto esteja preenchido.
 */
- (FichaMedica *)carregarFichaNuvem {
    
    [self conexaoParse];
    
    if (![_fichaMedica.objectID isEqualToString:@""]) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"FichaMedica"];
        
        [query whereKey:@"objectId" equalTo:_fichaMedica.objectID];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            
            [_fichaMedica setDataNascimento:object[@"dataNascimento"]];
            [_fichaMedica setSexo:object[@"sexo"]];
            [_fichaMedica setGrupoSanguineo:object[@"grupoSanguineo"]];
            [_fichaMedica setAltura:object[@"altura"]];
            [_fichaMedica setIndiceMassaCorporal:object[@"imc"]];
            [_fichaMedica setPeso:object[@"peso"]];
            [_fichaMedica setPressaoArterialSistolica:object[@"pressaoSistolica"]];
            [_fichaMedica setPressaoArterialDiastolica:object[@"pressaoDiastolica"]];
            [_fichaMedica setTemperaturaCorporal:object[@"temperaturaCorporal"]];
            
        }];
    }
    return _fichaMedica;
    
}

/**
 * @description Salva o objeto ficha médica no servidor em cloud.
 */
- (void)salvarFichaNuvem {
    
    [self conexaoParse];
    
    PFObject *classeFichaMedica = [PFObject objectWithClassName:@"FichaMedica"];
    classeFichaMedica[@"dataNascimento"] = _fichaMedica.dataNascimento;
    classeFichaMedica[@"sexo"] = _fichaMedica.sexo;
    classeFichaMedica[@"grupoSanguineo"] = _fichaMedica.grupoSanguineo;
    classeFichaMedica[@"altura"] = _fichaMedica.altura;
    classeFichaMedica[@"imc"] = _fichaMedica.indiceMassaCorporal;
    classeFichaMedica[@"peso"] = _fichaMedica.peso;
    classeFichaMedica[@"pressaoSistolica"] = _fichaMedica.pressaoArterialSistolica;
    classeFichaMedica[@"pressaoDiastolica"] = _fichaMedica.pressaoArterialDiastolica;
    classeFichaMedica[@"temperaturaCorporal"] = _fichaMedica.temperaturaCorporal;
    
    [classeFichaMedica saveInBackgroundWithBlock:^(bool succeeded, NSError *error) {
        if (succeeded) {
            [_fichaMedica setObjectID:classeFichaMedica.objectId];
        }
    }];

}

/**
 * @description Carregar os dados de informações do convênio da base de dados que fica na nuvem. O método atualiza o objeto de informações do convênio da classe, mas é necessário que a propriedade 'objectID' do objeto esteja preenchido.
 */
- (InfoConvenio *)carregarInfoConvenioNuvem {
    
    [self conexaoParse];
    
    if (![_infoConvenio.objectID isEqualToString:@""]) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"InfoConvenio"];
        
        [query whereKey:@"objectId" equalTo:_infoConvenio.objectID];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            
            [_infoConvenio setNomePlanodeSaude:object[@"nomePlanoSaude"]];
            [_infoConvenio setNumCartao:object[@"numCartao"]];
            [_infoConvenio setBeneficiario:object[@"beneficiario"]];
            [_infoConvenio setTitular:object[@"titular"]];
            [_infoConvenio setInicioValidade:object[@"inicio"]];
            [_infoConvenio setTerminoValidade:object[@"termino"]];
            
        }];
    }
    return _infoConvenio;
}

/**
 * @description Salva o objeto de informações do convêniono servidor em cloud.
 */
- (void)salvarInfoConvenioNuvem {
    
    [self conexaoParse];
    
    PFObject *classeInfoConvenio = [PFObject objectWithClassName:@"InfoConvenio"];
    classeInfoConvenio[@"nomePlanoSaude"] = _infoConvenio.nomePlanodeSaude;
    classeInfoConvenio[@"numCartao"] = _infoConvenio.numCartao;
    classeInfoConvenio[@"beneficiario"] = _infoConvenio.beneficiario;
    classeInfoConvenio[@"titular"] = _infoConvenio.titular;
    classeInfoConvenio[@"inicio"] = _infoConvenio.inicioValidade;
    classeInfoConvenio[@"termino"] = _infoConvenio.terminoValidade;
    
    [classeInfoConvenio saveInBackgroundWithBlock:^(bool succeeded, NSError *error) {
        if (succeeded) {
            [_infoConvenio setObjectID:classeInfoConvenio.objectId];
        }
    }];
    
}


#pragma mark DAO Local

/**
 * @description Método responsável por carregar os dados do usuário do User Default`s. Ao exeutar esse método, o atributo de usuário da classe persistência é atualizado e retornado.
 */
- (Usuario *)carregarUsuarioLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosUsuario = [userDefaults objectForKey:@"Usuario"];
    
    _usuario = [NSKeyedUnarchiver unarchiveObjectWithData:dadosUsuario];
    
    return _usuario;
    
}


/**
 * @description Método responsável por salvar as informações do usuário no User Default`s.
 */
- (void)salvarUsuarioLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosUsuario = [NSKeyedArchiver archivedDataWithRootObject: _usuario];
    [userDefaults setObject:dadosUsuario forKey:@"Usuario"];
    
    
}

/**
 * @description Método responsável por carregar os dados da ficha médica do User Default`s. Ao executar esse método, o atributo de ficha médica é atualizado e retornado.
 */
- (FichaMedica *)carregarFichaLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosFicha = [userDefaults objectForKey:@"FichaMedica"];
    
    _fichaMedica = [NSKeyedUnarchiver unarchiveObjectWithData:dadosFicha];
    
    return _fichaMedica;
    
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
 * @description Método responsável por carregar os dados da ficha médica do User Default`s. Ao executar esse método, o atributo de informações sobre o convênio é atualizado e retornado.
 */
- (InfoConvenio *)carregarInfoConvenioLocal {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dadosConv = [userDefaults objectForKey:@"InfoConvenio"];
    
    _infoConvenio = [NSKeyedUnarchiver unarchiveObjectWithData:dadosConv];
    
    return _infoConvenio;
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
