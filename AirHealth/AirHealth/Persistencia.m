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
 * @description Carregar os dados do usuário da base de dados que fica na nuvem. O método atualiza o objeto de usuário da classe, mas é necessário que a propriedade 'objectID' do objeto esteja preenchido.
 * @return Instância da propriedade 'usuario' da classe.
 */
- (Usuario *)carregarUsuarioNuvem {
    
    //[self conexaoParse];

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
            [_usuario setTelefone:object[@"telefone"]];
            [_usuario setSenha:object[@"senha"]];
            
            
        }];
    }
    return _usuario;
    
}


/**
 * @description Salva o objeto usuário no servidor em cloud.
 */
- (void)salvarUsuarioNuvem {
    
    if (!_usuario.objectID || [_usuario.objectID isEqualToString:@""]) {
        PFObject *classeUsuario = [PFObject objectWithClassName:@"Usuario"];
        
        if (_usuario.imagem)
            classeUsuario[@"imagem"] = [PFFile fileWithData:_usuario.imagem];
        
        classeUsuario[@"nome"] = _usuario.nome;
        classeUsuario[@"cpf"] = _usuario.cpf;
        classeUsuario[@"rg"] = _usuario.rg;
        classeUsuario[@"endereco"] = _usuario.endereco;
        classeUsuario[@"cep"] = _usuario.cep;
        classeUsuario[@"cidade"] = _usuario.cidade;
        classeUsuario[@"estado"] = _usuario.estado;
        classeUsuario[@"email"] = _usuario.email;
        classeUsuario[@"telefone"] = _usuario.telefone;
        //classeUsuario[@"fichaMedica"] = _fichaMedica.objectID;
        //classeUsuario[@"infoConvenio"] = _infoConvenio.objectID;
        classeUsuario[@"senha"] = [NSString stringWithFormat:@"%d%d%d%d", arc4random_uniform(9), arc4random_uniform(9), arc4random_uniform(9), arc4random_uniform(9)];
        
        [classeUsuario saveInBackgroundWithBlock:^(bool succeeded, NSError *error) {
            if (succeeded) {
                [_usuario setObjectID:classeUsuario.objectId];
                [_usuario setSenha:classeUsuario[@"senha"]];
                [self salvarUsuarioLocal];
                [self relacionaObjetos];
            }
        }];
    }
    
    else {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
        
        [query getObjectInBackgroundWithId:_usuario.objectID block:^(PFObject *classeUsuario, NSError *erro) {
            
            if (_usuario.imagem)
                classeUsuario[@"imagem"] = [PFFile fileWithData:_usuario.imagem];
            
            classeUsuario[@"nome"] = _usuario.nome;
            classeUsuario[@"cpf"] = _usuario.cpf;
            classeUsuario[@"rg"] = _usuario.rg;
            classeUsuario[@"endereco"] = _usuario.endereco;
            classeUsuario[@"cep"] = _usuario.cep;
            classeUsuario[@"cidade"] = _usuario.cidade;
            classeUsuario[@"estado"] = _usuario.estado;
            classeUsuario[@"email"] = _usuario.email;
            classeUsuario[@"telefone"] = _usuario.telefone;
            [self salvarUsuarioLocal];
            [classeUsuario saveInBackground];
            [self relacionaObjetos];
        }];

    }
}



/**
 * @description Deleta o registro do usuário da base de dados na nuvem.
 */
- (void)deletarUsuarioNuvem {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
    
    [query getObjectInBackgroundWithId:_usuario.objectID block:^(PFObject *classeUsuario, NSError *erro) {
        
        [classeUsuario deleteInBackground];
    }];

}


/**
 * @description Carregar os dados da ficha médica da base de dados que fica na nuvem. O método atualiza o objeto de ficha médica da classe, mas é necessário que a propriedade 'objectID' do objeto esteja preenchido.
 * @return Instância da propriedade 'fichaMedica' da classe.
 */
- (FichaMedica *)carregarFichaNuvem {
    
    //[self conexaoParse];
    
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
    
    if (!_fichaMedica.objectID || [_fichaMedica.objectID isEqualToString:@""]) {
        
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
                [self salvarFichaLocal];
                [self relacionaObjetos];
            }
        }];
    }
    else {
        
        PFQuery *query = [PFQuery queryWithClassName:@"FichaMedica"];
        
        [query getObjectInBackgroundWithId:_fichaMedica.objectID block:^(PFObject *classeFichaMedica, NSError *erro) {
            
            classeFichaMedica[@"dataNascimento"] = _fichaMedica.dataNascimento;
            classeFichaMedica[@"sexo"] = _fichaMedica.sexo;
            classeFichaMedica[@"grupoSanguineo"] = _fichaMedica.grupoSanguineo;
            classeFichaMedica[@"altura"] = _fichaMedica.altura;
            classeFichaMedica[@"imc"] = _fichaMedica.indiceMassaCorporal;
            classeFichaMedica[@"peso"] = _fichaMedica.peso;
            classeFichaMedica[@"pressaoSistolica"] = _fichaMedica.pressaoArterialSistolica;
            classeFichaMedica[@"pressaoDiastolica"] = _fichaMedica.pressaoArterialDiastolica;
            classeFichaMedica[@"temperaturaCorporal"] = _fichaMedica.temperaturaCorporal;
            [self salvarFichaLocal];
            [classeFichaMedica saveInBackground];
        }];
    }
}

/**
 * @description Deleta o registro da ficha médica da base de dados na nuvem.
 */
- (void)deletarFichaNuvem {
    
    PFQuery *query = [PFQuery queryWithClassName:@"FichaMedica"];
    
    [query getObjectInBackgroundWithId:_fichaMedica.objectID block:^(PFObject *classeFichaMedica, NSError *erro) {
        
        [classeFichaMedica deleteInBackground];
    }];
    
}


/**
 * @description Carregar os dados de informações do convênio da base de dados que fica na nuvem. O método atualiza o objeto de informações do convênio da classe, mas é necessário que a propriedade 'objectID' do objeto esteja preenchido.
 * @return Instância da propriedade 'infoConvenio' da classe.
 */
- (InfoConvenio *)carregarInfoConvenioNuvem {
    
    
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
    
    
    //se o objectId estiver nulo ou vazio, é criado um novo registro
    if (!_infoConvenio.objectID || [_infoConvenio.objectID isEqualToString:@""]) {
        
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
                [self salvarInfoConvenioLocal];
                [self relacionaObjetos];
            }
        }];
    }
    //se estiver preenchido, o registro é localizado e atualizado
    else {
        
        PFQuery *query = [PFQuery queryWithClassName:@"InfoConvenio"];
        
        [query getObjectInBackgroundWithId:_infoConvenio.objectID block:^(PFObject *classeInfoConvenio, NSError *erro) {
            
            classeInfoConvenio[@"nomePlanoSaude"] = _infoConvenio.nomePlanodeSaude;
            classeInfoConvenio[@"numCartao"] = _infoConvenio.numCartao;
            classeInfoConvenio[@"beneficiario"] = _infoConvenio.beneficiario;
            classeInfoConvenio[@"titular"] = _infoConvenio.titular;
            classeInfoConvenio[@"inicio"] = _infoConvenio.inicioValidade;
            classeInfoConvenio[@"termino"] = _infoConvenio.terminoValidade;
            [self salvarInfoConvenioLocal];
            [classeInfoConvenio saveInBackground];
        }];
    }
}

/**
 * @description Deleta o registro das informações de convênio da base de dados na nuvem.
 */
- (void)deletarInfoConvenioNuvem {
    
    PFQuery *query = [PFQuery queryWithClassName:@"InfoConvenio"];
    
    [query getObjectInBackgroundWithId:_infoConvenio.objectID block:^(PFObject *classeInfoConvenio, NSError *erro) {
        
        [classeInfoConvenio deleteInBackground];
    }];
    
}

/**
 * @description Método responsável por atrelar a relação entre os objetos no banco de dados em nuvem.
 */
- (void)relacionaObjetos {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
    
    [query getObjectInBackgroundWithId:_usuario.objectID block:^(PFObject *classeUsuario, NSError *erro) {
        
        classeUsuario[@"fichaMedica"] = _fichaMedica.objectID;
        classeUsuario[@"infoConvenio"] = _infoConvenio.objectID;
        [classeUsuario saveInBackgroundWithBlock:^(bool succeeded, NSError *erro) {
            
            if (succeeded)
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UsuarioSincronizado" object:[_usuario senha]];
            
        }];
    }];
    
}


#pragma mark DAO Local

/**
 * @description Método responsável por carregar os dados do usuário do User Default`s. Ao exeutar esse método, o atributo de usuário da classe persistência é atualizado e retornado.
 * @return Instância da propriedade 'usuario' da classe.
 */
- (Usuario *)carregarUsuarioLocal {
    
    _usuario = [[Usuario alloc] init];
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
 * @return Instância da propriedade 'fichaMedica' da classe.
 */
- (FichaMedica *)carregarFichaLocal {
    
    _fichaMedica = [[FichaMedica alloc] init];
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
 * @return Instância da propriedade 'infoConvenio' da classe.
 */
- (InfoConvenio *)carregarInfoConvenioLocal {
    
    _infoConvenio = [[InfoConvenio alloc] init];
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
