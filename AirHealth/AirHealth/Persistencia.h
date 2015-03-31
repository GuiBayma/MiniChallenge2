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
- (InfoConvenio *)carregarInfoConvNuvem;

+ (void)salvarUsuarioNuvem:(Usuario *)usu;
+ (void)salvarFichaNuvem:(FichaMedica *)ficha;
+ (void)salvarInfoConvenioNuvem:(InfoConvenio *)infoConv;



@end
