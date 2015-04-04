//
//  ConfiguracoesTableViewController.m
//  AirHealth
//
//  Created by Kaique Damato on 3/25/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "ConfiguracoesTableViewController.h"
#import "PageViewController.h"
#import "Persistencia.h"
#import "Usuario.h"
#import "FichaMedica.h"
#import "InfoConvenio.h"

@interface ConfiguracoesTableViewController ()

@end

@implementation ConfiguracoesTableViewController {
    Persistencia *persistencia;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //teste
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    persistencia = [Persistencia sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"celulaPadrao"];
//    if(indexPath.section==0){
//        if (indexPath.row == 0) {
//            cell.textLabel.text = @"Tutorial";
//        }
//        else {
//            cell.textLabel.text = @"Sobre o AirHealth";
//        }
//    }
//    
//    return cell;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            PageViewController *pvc = [[PageViewController alloc] init];
            [self presentViewController:pvc animated:YES completion:nil];
        }
        else if(indexPath.row == 1){
            AboutViewController *avc = [[AboutViewController alloc] init];
            [self presentViewController:avc animated:YES completion:nil];
        }
    }
    else{
        if(indexPath.section == 1){
            
        }
    }
}

- (IBAction)apagarTodosDados:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Apagar Dados"
                                                    message:@"Deseja apagar também os dados salvos na nuvem?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancelar"
                                          otherButtonTitles:@"Não", @"Sim", nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
            
        case 0: //botao cancelar
            
            break;
            
        case 1: //botao não
            
            persistencia.usuario = [[Usuario alloc] init];
            [persistencia salvarUsuarioLocal];
            
            persistencia.fichaMedica = [[FichaMedica alloc] init];
            [persistencia salvarFichaLocal];
            
            persistencia.infoConvenio = [[InfoConvenio alloc] init];
            [persistencia salvarInfoConvenioLocal];
            
            break;
            
        case 2: //botao sim
            
            [persistencia deletarUsuarioNuvem];
            persistencia.usuario = [[Usuario alloc] init];
            [persistencia salvarUsuarioNuvem];
            
            [persistencia deletarFichaNuvem];
            persistencia.fichaMedica = [[FichaMedica alloc] init];
            [persistencia salvarFichaLocal];
            
            [persistencia deletarInfoConvenioNuvem];
            persistencia.infoConvenio = [[InfoConvenio alloc] init];
            [persistencia salvarInfoConvenioLocal];
            
            break;
            
        default:
            break;
    }
    
}
@end
