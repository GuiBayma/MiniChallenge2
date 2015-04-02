//
//  SincronizarViewController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 30/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "SincronizarViewController.h"
#import "Persistencia.h"

@interface SincronizarViewController (){
    int contAnimacao;
    Persistencia *persistencia;
}

@end

@implementation SincronizarViewController
@synthesize imageCruz, buttonSincronizar, labelSincronizando, labelSenha;

- (void)viewDidLoad {
    [super viewDidLoad];
    [imageCruz setUserInteractionEnabled:YES];
    [buttonSincronizar setUserInteractionEnabled:YES];
    buttonSincronizar.adjustsImageWhenHighlighted = NO;
    [labelSincronizando setHidden:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [imageCruz bringSubviewToFront:buttonSincronizar];
    
    persistencia = [Persistencia sharedInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exibirSenha) name:@"UsuarioSincronizado" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque = [[event allTouches]anyObject];
    
    if([toque view] == imageCruz || [toque view] == buttonSincronizar){
        //[self teste];
        [self tremblingButton];
        [self scaleImageReverse];
        [self rotateImageView];
        [self enviarDadosPraNuvem];
    }
    
}

- (void)rotateImageView{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [imageCruz setTransform:CGAffineTransformRotate(imageCruz.transform, M_PI_2)];
                     }completion:^(BOOL finished){
                         if(finished){
                             [self rotateImageView];
                         }
                     }];
}

- (void)tremblingButton{
    //[imageCruz setEnabled:YES];
    
    CAKeyframeAnimation * anim = [CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
    anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-4.0f, -1.0f, 0.0f) ],[ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(4.0f, 1.0f, 0.0f) ] ] ;
    anim.autoreverses = YES ;
    anim.repeatCount = 10000000;
    anim.duration = 0.1f ;
    
    [buttonSincronizar.layer addAnimation:anim forKey:nil ] ;

}

-(void)scaleImageReverse{
    [labelSincronizando setHidden:NO];
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         buttonSincronizar.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     }
                     completion:nil
                     ];

}

-(void)sincronizar:(id)sender{
    [self tremblingButton];
    [self scaleImageReverse];
    [self rotateImageView];
    [self enviarDadosPraNuvem];
}

- (void)stopAnimation{
    imageCruz = nil;
    buttonSincronizar = nil;
    [labelSincronizando setHidden:YES];
    labelSincronizando = nil;
    [super viewDidLoad];
}
-(void)teste{
    [UIView animateWithDuration:10
                          delay:1
                        options:nil
                     animations:^{
                         labelSincronizando.text = @"Sincronizando";
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             [UIView animateWithDuration:10
                                                   delay:1
                                                 options:nil
                                              animations:^{
                                                  labelSincronizando.text = @"Sincronizando.";
                                              }
                                              completion:^(BOOL finished){
                                                  [UIView animateWithDuration:10
                                                                        delay:1
                                                                      options:nil
                                                                   animations:^{
                                                                       labelSincronizando.text = @"Sincronizando..";
                                                                   }
                                                                   completion:^(BOOL finished){
                                                                       [UIView animateWithDuration:10
                                                                                             delay:1
                                                                                           options:nil
                                                                                        animations:^{
                                                                                            labelSincronizando.text = @"Sincronizando...";
                                                                                        }
                                                                                        completion:^(BOOL finished){
                                                                                            if(finished){
                                                                                                [self teste];
                                                                                            }
                                                                                        }];
                                                                   }];
                                              }];
                         }
                     }];
}


- (void)enviarDadosPraNuvem {
    [persistencia salvarInfoConvenioNuvem];
    [persistencia salvarFichaNuvem];
    [persistencia salvarUsuarioNuvem];
}

- (void)exibirSenha {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TA SUSSA"
                                                     message:[persistencia.usuario senha]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
    
    __block NSString *senha = [persistencia.usuario senha];
    [UIView animateWithDuration:2.0 animations:^{
        imageCruz.alpha = 1.0;
        buttonSincronizar.alpha = 1.0;
        labelSincronizando.alpha = 1.0;
        imageCruz.alpha = 0.0;
        buttonSincronizar.alpha = 0.0;
        labelSincronizando.alpha = 0.0;
    }];
    
    [UIView animateWithDuration:2.0 animations:^{
        labelSenha.text = [NSString stringWithFormat:@"Senha: %@", senha];
        NSLog(@"Senha: ", senha);
        labelSenha.alpha = 1.0;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
