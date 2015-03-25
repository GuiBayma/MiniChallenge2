//
//  LoginController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 25/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end
@implementation LoginController

@synthesize textSenha, textUser, buttonEntrar;

- (void)viewDidLoad {
    [super viewDidLoad];
    buttonEntrar.layer.borderWidth=1.0f;
    buttonEntrar.layer.borderColor=[[UIColor blackColor]CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
