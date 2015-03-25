//
//  LoginController.h
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 25/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textUser;
@property (weak, nonatomic) IBOutlet UITextField *textSenha;
@property (weak, nonatomic) IBOutlet UIButton *buttonEntrar;
@property (weak, nonatomic) IBOutlet UIButton *buttonCadastro;

@end
