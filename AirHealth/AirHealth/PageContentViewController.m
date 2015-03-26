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
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.label = [[UILabel alloc] init];
    self.texto = [[UILabel alloc] init];
    
    self.image.image = [UIImage imageNamed:self.imageFile];
    
    self.label.numberOfLines = 3;
    self.label.text = self.titleText;
    [self.label sizeToFit];
    self.label.center = CGPointMake(self.view.center.x, 80);
    
    self.texto.numberOfLines = 3;
    self.texto.text = self.textoText;
    [self.texto sizeToFit];
    self.texto.center = CGPointMake(self.view.center.x, self.view.bounds.size.height -100);
    
    [self.view addSubview:self.image];
    [self.view addSubview:self.label];
    [self.view addSubview:self.texto];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:205.0/255.0 green:44.0/255.0 blue:37.0/255.0 alpha:1];
    pageControl.backgroundColor = [UIColor colorWithRed:187.0/255.0 green:164.0/255.0 blue:124.0/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
