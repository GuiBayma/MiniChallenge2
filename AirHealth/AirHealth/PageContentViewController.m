//
//  PageContentViewController.m
//  AirHealth
//
//  Created by Guilherme Bayma on 3/25/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "PageContentViewController.h"

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageFile]];
    self.image.frame = CGRectMake(0, 0, 300, 265);
    self.image.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:self.image];
    
    self.titulo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-30, 100)];
    self.titulo.text = self.tituloTexto;
    self.titulo.font = [UIFont fontWithName:@"Arial" size:35];
    self.titulo.numberOfLines = 2;
    self.titulo.textAlignment = NSTextAlignmentCenter;
    [self.titulo sizeToFit];
    self.titulo.center = CGPointMake(self.view.center.x, 120);
    [self.view addSubview:self.titulo];
    
    self.texto = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-30, 100)];
    self.texto.text = self.textoTexto;
    self.texto.font = [UIFont fontWithName:@"Arial" size:25];
    self.texto.numberOfLines = 3;
    self.texto.textAlignment = NSTextAlignmentCenter;
    [self.texto sizeToFit];
    self.texto.center = CGPointMake(self.view.center.x, self.view.bounds.size.height-140);
    [self.view addSubview:self.texto];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end