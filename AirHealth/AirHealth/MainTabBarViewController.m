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
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(habilitarItens) name:@"HabilitarItensTabBar" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL primeiroUso = [defaults boolForKey:@"primeiroUso"];
    //BOOL primeiroUso = NO;
    if (!primeiroUso) {
        PageViewController *pvc = [[PageViewController alloc] init];
        [self presentViewController:pvc animated:YES completion:nil];
    }
//    else {
//        bool usuarioCadastrado = [defaults boolForKey:@"usuarioCadastrado"];
//        if (!usuarioCadastrado)
//            [self notificarUsuarioNaoCadastrado];
//    }
    
}

//- (void)notificarUsuarioNaoCadastrado {
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    bool usuarioCadastrado = [defaults boolForKey:@"usuarioCadastrado"];
//    
//    if (!usuarioCadastrado) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cadastro necessário"
//                                                        message:@"Para usar o app é necessário que você efetue o cadastro de seus dados pessoais."
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        
//        
//        [self setSelectedViewController:self.viewControllers[1]];
//        [self.tabBar.items[0] setEnabled:NO];
//        [self.tabBar.items[2] setEnabled:NO];
//        [self.tabBar.items[3] setEnabled:NO];
//        
//    }
//    
//}
//
//- (void)habilitarItens {
//    [self.tabBar.items[0] setEnabled:YES];
//    [self.tabBar.items[2] setEnabled:YES];
//    [self.tabBar.items[3] setEnabled:YES];
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
