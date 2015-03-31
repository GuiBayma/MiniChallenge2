//
//  SincronizarViewController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 30/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "SincronizarViewController.h"

@interface SincronizarViewController ()

@end

@implementation SincronizarViewController
@synthesize imageCruz, buttonSincronizar;
- (void)viewDidLoad {
    [super viewDidLoad];
    [imageCruz setUserInteractionEnabled:YES];
    [buttonSincronizar setUserInteractionEnabled:YES];
    buttonSincronizar.highlighted = NO;
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
    float buttonWidth = buttonSincronizar.frame.size.width;
    float buttonHeight = buttonSincronizar.frame.size.height;
    float buttonX = buttonSincronizar.frame.origin.x;
    float buttonY = buttonSincronizar.frame.origin.y;
    
    buttonSincronizar.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    
    buttonSincronizar.transform = CGAffineTransformMakeScale(1.15, 1.15);
    
    [UIView animateWithDuration:0.75
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         buttonSincronizar.transform = CGAffineTransformIdentity;
                         buttonSincronizar.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
                         
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             [self scaleImageView];
                         }
     }];
    
}

- (void)rotateImageView
{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
