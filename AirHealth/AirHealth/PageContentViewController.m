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
    self.image.image = [UIImage imageNamed:self.imageFile];
    [self.view addSubview:self.image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
