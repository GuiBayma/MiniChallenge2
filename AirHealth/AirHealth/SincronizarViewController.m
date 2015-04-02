//
//  SincronizarViewController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 30/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "SincronizarViewController.h"

@interface SincronizarViewController (){
    int contAnimacao;
    float buttonWidth;
    float buttonHeight;
    float buttonX;
    float buttonY;
}

@end

@implementation SincronizarViewController
@synthesize imageCruz, buttonSincronizar, labelSincronizando;

- (void)viewDidLoad {
    [super viewDidLoad];
    [imageCruz setUserInteractionEnabled:YES];
    [buttonSincronizar setUserInteractionEnabled:YES];
    buttonSincronizar.adjustsImageWhenHighlighted = NO;
    [labelSincronizando setHidden:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque = [[event allTouches]anyObject];
    
    if([toque view] == imageCruz || [toque view] == buttonSincronizar){
        //[self teste];
        [self rotateImageView];
        [self scaleImageReverse];
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
    anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-2.0f, -1.0f, 0.0f) ],[ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(2.0f, 1.0f, 0.0f) ] ] ;
    anim.autoreverses = YES ;
    anim.repeatCount = 100;
    anim.duration = 0.07f ;
    
    [buttonSincronizar.layer addAnimation:anim forKey:nil ] ;

}

-(void)scaleImageReverse{
    [labelSincronizando setHidden:NO];
    
    [UIView animateWithDuration:3.0
                          delay:0
                        options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         buttonSincronizar.transform = CGAffineTransformMakeScale(1.25, 1.25);
                     }
                     completion:nil
                     ];

}

-(void)sincronizar:(id)sender{
    //[self teste];
    [self scaleImageReverse];
    [self rotateImageView];
}

- (void)stopAnimation{
    imageCruz = nil;
    buttonSincronizar = nil;
    [labelSincronizando setHidden:YES];
    labelSincronizando = nil;
    [super viewDidLoad];
}
-(void)teste{
    [UIView animateWithDuration:1
                          delay:1
                        options:UIViewAnimationOptionRepeat
                     animations:^{
                         if(contAnimacao == 0){
                             labelSincronizando.text = @"Sincronizando";
                         }
                         else if (contAnimacao == 1){
                             labelSincronizando.text = @"Sincronizando.";
                         }
                         else if(contAnimacao == 2){
                             labelSincronizando.text = @"Sincronizando..";
                         }
                         else if(contAnimacao == 3){
                             labelSincronizando.text = @"Sincronizando...";
                         }
                         contAnimacao++;
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             if(contAnimacao==4){
                                 contAnimacao=0;
                             }
                             [self teste];
                         }
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
