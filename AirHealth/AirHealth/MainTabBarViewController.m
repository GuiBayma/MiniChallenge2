//
//  MainTabBarViewController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 24/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificarUsuarioNaoCadastrado) name:@"ValidacaoCadastro" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL primeiroUso = [defaults boolForKey:@"primeiroUso"];
//    BOOL primeiroUso = NO;
    if (!primeiroUso) {
        PageViewController *pvc = [[PageViewController alloc] init];
        [self presentViewController:pvc animated:YES completion:nil];
    }
}

- (BOOL)shouldAutorotate {
    
    if(self.selectedIndex == 0 || self.selectedIndex == 1 || self.selectedIndex == 2 || self.selectedIndex == 3)
    {
        return NO;
    }
    
    return [self.viewControllers.lastObject shouldAutorotate];
}

@end
