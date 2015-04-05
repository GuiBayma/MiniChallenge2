//
//  ConfiguracoesTableViewController.m
//  AirHealth
//
//  Created by Kaique Damato on 3/25/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "ConfiguracoesTableViewController.h"
#import "PageViewController.h"

@interface ConfiguracoesTableViewController ()

@end

@implementation ConfiguracoesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //teste
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        if (indexPath.section == 0) {
            PageViewController *pvc = [[PageViewController alloc] init];
            [self presentViewController:pvc animated:YES completion:nil];
        }
    }
    else{
        if(indexPath.section == 1){
            
        }
    }
}

- (IBAction)permitirHealthKit:(id)sender {
    self.healthStore = [[HKHealthStore alloc] init];
    // Set up an HKHealthStore, asking the user for read/write permissions. The profile view controller is the
    // first view controller that's shown to the user, so we'll ask for all of the desired HealthKit permissions now.
    // In your own app, you should consider requesting permissions the first time a user wants to interact with
    // HealthKit data.
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

@end
