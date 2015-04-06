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

- (void)viewDidAppear:(BOOL)animated {
    

    [self.navigationController.navigationBar.topItem setTitle:@"Configurações"];
    
    //ajustando view entre a navigation e a tabbar
    CGFloat tabBarHeight = self.tabBarController.tabBar.bounds.size.height;
    CGFloat navBarHeight = self.navigationController.navigationBar.bounds.size.height;
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - navBarHeight - tabBarHeight;
    frame.origin.y += navBarHeight;
    self.view.frame = frame;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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

- (IBAction)permitirHealthKit:(id)sender {
    self.healthStore = [[HKHealthStore alloc] init];

    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dadosParaEscrever];
        NSSet *readDataTypes = [self dadosParaLer];
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
                return;
            }
        }];
    }
}

- (IBAction)apagarTodosDados:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Apagar Dados"
                                                    message:@"Tem certeza que deseja apagar os dados?"
                                                   delegate:self
                                          cancelButtonTitle:@"Não"
                                          otherButtonTitles:@"Sim", nil];
    
    [alert show];
    
}

// Retorna os tipos de dados que desejamos atualizar no HealthKit.
- (NSSet *)dadosParaEscrever {
    HKQuantityType *altura = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *peso = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *imc = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
             
    return [NSSet setWithObjects:altura, peso, imc,nil];
}

// Retorna os tipos de dados que desejamos ler do HealthKit.
- (NSSet *)dadosParaLer {
    HKCharacteristicType *dataNascimento = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *sexo = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    HKCharacteristicType *tipoSanguineo = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    HKQuantityType *altura = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *peso = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *imc = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    
    return [NSSet setWithObjects:altura, peso, imc, dataNascimento, tipoSanguineo, sexo, nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIAlertView *okAlert = [[UIAlertView alloc] initWithTitle:@"Dados apagados"
                                                      message:@"Os dados foram apagados com sucesso!"
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
    
    UIAlertView *cancelarAlert = [[UIAlertView alloc] initWithTitle:@"Operação cancelada"
                                                      message:@"A operação de apagar os dados foi cancelada."
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
    
    
    switch (buttonIndex) {
            
        case 0: //botao não
            
            [cancelarAlert show];
            
            break;
            
        case 1: //botao sim
            
            [persistencia deletarUsuarioNuvem];
            //persistencia.usuario = [[Usuario alloc] init];
            //[persistencia salvarUsuarioNuvem];
            
            [persistencia deletarFichaNuvem];
            //persistencia.fichaMedica = [[FichaMedica alloc] init];
            //[persistencia salvarFichaLocal];
            
            [persistencia deletarInfoConvenioNuvem];
            //persistencia.infoConvenio = [[InfoConvenio alloc] init];
            //[persistencia salvarInfoConvenioLocal];
            
            [okAlert show];

            
            break;

        default:
            break;
    }
    
}

@end
