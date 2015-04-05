//
//  AboutViewController.m
//  AirHealth
//
//  Created by Guilherme Bayma on 4/2/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about.png"]];
    image.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:image];
    
    UIButton *fecha = [UIButton buttonWithType:UIButtonTypeCustom];
    [fecha addTarget:self action:@selector(fechar) forControlEvents:UIControlEventTouchUpInside];
    fecha.frame = CGRectMake(self.view.bounds.size.width -80, 35, 44, 44);
    [fecha setImage:[UIImage imageNamed:@"close-100.png"] forState:UIControlStateNormal];
    [self.view addSubview:fecha];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fechar {
    [self dismissViewControllerAnimated:YES completion:nil];
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
