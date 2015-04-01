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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque = [[event allTouches]anyObject];
    
    if([toque view] == imageCruz || [toque view] == buttonSincronizar){
        [self scaleImageView];
        [self rotateImageView];
    }
    
}

-(void)scaleImageView{
    buttonWidth = buttonSincronizar.frame.size.width;
    buttonHeight = buttonSincronizar.frame.size.height;
    buttonX = buttonSincronizar.frame.origin.x;
    buttonY = buttonSincronizar.frame.origin.y;
    
    buttonSincronizar.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    buttonSincronizar.transform = CGAffineTransformMakeScale(1.25, 1.25);
    
    [labelSincronizando setHidden:NO];
    
    [UIView animateWithDuration:1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         buttonSincronizar.transform = CGAffineTransformIdentity;
                         buttonSincronizar.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
                         
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
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             [self scaleImageView];
                         }
     }];
    contAnimacao++;
    if(contAnimacao==4){
        contAnimacao=0;
    }
    
}



- (void)rotateImageView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [imageCruz setTransform:CGAffineTransformRotate(imageCruz.transform, M_PI_2)];
    }completion:^(BOOL finished){
        if(finished){
            [self rotateImageView];
        }
    }];
}

-(void)sincronizar:(id)sender{
    [self scaleImageView];
    [self rotateImageView];
}

- (void)stopAnimation{
    imageCruz = nil;
    buttonSincronizar = nil;
    [labelSincronizando setHidden:YES];
    labelSincronizando = nil;
    
}

//- (void)teste {
//    imageCruz = nil;
//    buttonSincronizar = nil;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
