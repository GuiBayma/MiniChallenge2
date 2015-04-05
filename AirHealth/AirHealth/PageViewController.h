//
//  PageViewController.h
//  AirHealth
//
//  Created by Guilherme Bayma on 3/25/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface PageViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *imagensPrimeiro;
@property (strong, nonatomic) NSArray *imagens;
@property (strong, nonatomic) NSArray *titulos;
@property (strong, nonatomic) NSArray *textos;

@end
