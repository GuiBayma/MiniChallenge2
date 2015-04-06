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
    bool click;
    bool senhaGerada;
    __block NSString *senha;
}

@end

@implementation SincronizarViewController
@synthesize imageCruz, buttonSincronizar, labelSincronizando, labelSenha,imageOk, labelOk;

- (void)viewDidLoad {
    [super viewDidLoad];
    [imageCruz setUserInteractionEnabled:YES];
    [buttonSincronizar setUserInteractionEnabled:YES];
    buttonSincronizar.adjustsImageWhenHighlighted = NO;
    [labelSincronizando setHidden:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [imageCruz bringSubviewToFront:buttonSincronizar];
    click = NO;
    senhaGerada = NO;
    persistencia = [Persistencia sharedInstance];
    imageOk.alpha = 0;
    labelSenha.alpha = 0;
    imageCruz.alpha = 1;
    buttonSincronizar.alpha = 1;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exibirSenha:) name:@"UsuarioSincronizado" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    if(senhaGerada){
        labelSenha.alpha=0;
        labelSincronizando.alpha=0;
        imageOk.alpha=0;
        labelOk.alpha=0;
        imageCruz.alpha=1;
        buttonSincronizar.alpha=1;
        self.view.backgroundColor = [UIColor whiteColor];
        click=NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque = [[event allTouches]anyObject];
    
    if([toque view] == imageCruz){
        if(click == NO){
            [self tremblingButton];
            [self scaleImageReverse];
            [self rotateImageView];
            [self enviarDadosPraNuvem];
        }
    }
    click = YES;
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
    anim.repeatCount = 100;
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
    
    if(click==NO){
        [self tremblingButton];
        [self scaleImageReverse];
        [self rotateImageView];
        [self enviarDadosPraNuvem];
    }
    
    click = YES;
}

- (void)stopAnimation{
    imageCruz = nil;
    buttonSincronizar = nil;
    [labelSincronizando setHidden:YES];
    labelSincronizando = nil;
}

- (void)enviarDadosPraNuvem {
    [persistencia salvarInfoConvenioNuvem];
    [persistencia salvarFichaNuvem];
    [persistencia salvarUsuarioNuvem];
}

- (void)exibirSenha:(NSNotification *)not {
    
    senha = not.object;
    
    [UIView animateWithDuration:2.0 animations:^{
        imageCruz.alpha = 1.0;
        buttonSincronizar.alpha = 1.0;
        labelSincronizando.alpha = 1.0;
        labelSincronizando.alpha = 0.0;
        
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        #define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0];
        self.view.backgroundColor = Rgb2UIColor(58, 191, 151);
        imageCruz.alpha = 0.0;
        buttonSincronizar.alpha = 0.0;
        labelSincronizando.alpha = 0.0;
    }];
    
    [UIView animateWithDuration:2.0 animations:^{
        labelSenha.text = [NSString stringWithFormat:@"Senha: %@", senha];
        
        UIView *rect = [[UIView alloc]initWithFrame:CGRectMake(self.tabBarController.tabBar.frame.origin.x, self.tabBarController.tabBar.frame.origin.y, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height)];
        
        rect.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:rect];
        imageOk.alpha = 1.0;
        labelSenha.alpha = 1.0;
        labelOk.alpha = 1.0;
    }];
    
    senhaGerada = YES;
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
