//
//  Persistencia.h
//  AirHealth
//
//  Created by Guilherme Ferreira de Souza on 3/29/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Usuario.h"

@interface Persistencia : NSObject

@property Usuario *usuario;
@property FichaMedica *fichaMedica;
@property InfoConvenio *infoConvenio;

+ (Persistencia *)sharedInstance;

- (Usuario *)carregarUsuarioLocal;
- (FichaMedica *)carregarFichaLocal;
- (InfoConvenio *)carregarInfoConvenioLocal;

- (void)salvarUsuarioLocal;
- (void)salvarFichaLocal;
- (void)salvarInfoConvenioLocal;

- (Usuario *)carregarUsuarioNuvem;
- (FichaMedica *)carregarFichaNuvem;
- (InfoConvenio *)carregarInfoConvenioNuvem;

- (void)salvarUsuarioNuvem;
- (void)salvarFichaNuvem;
- (void)salvarInfoConvenioNuvem;

- (void)deletarUsuarioNuvem;
- (void)deletarFichaNuvem;
- (void)deletarInfoConvenioNuvem;



@end
