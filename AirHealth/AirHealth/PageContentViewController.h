//
//  PageContentViewController.h
//  AirHealth
//
//  Created by Guilherme Bayma on 3/25/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property UIImageView *image;
@property UILabel *titulo;
@property UILabel *texto;
@property NSUInteger pageIndex;
@property NSString *tituloTexto;
@property NSString *imageFile;
@property NSString *textoTexto;

@end