//
//  FichaMedicaTableViewController.m
//  AirHealth
//
//  Created by Kaique Damato on 3/26/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "FichaMedicaTableViewController.h"
#import "HKHealthStore+AAPLExtensions.h"

typedef NS_ENUM(NSInteger, AAPLProfileViewControllerTableViewIndex) {
    AAPLProfileViewControllerTableViewIndex0 = 0,
    AAPLProfileViewControllerTableViewIndex1,
    AAPLProfileViewControllerTableViewIndex2,
};

@interface FichaMedicaTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *idadeUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *idadeValorLabel;

@property (weak, nonatomic) IBOutlet UILabel *sexoUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexoValorLabel;

@property (weak, nonatomic) IBOutlet UILabel *grupoSanguineoUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *grupoSanguineoValorLabel;

@property (weak, nonatomic) IBOutlet UILabel *alturaUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *alturaValorLabel;

@property (weak, nonatomic) IBOutlet UILabel *pesoUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pesoValorLabel;

@property (weak, nonatomic) IBOutlet UILabel *imcUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *imcValorLabel;

@end

@implementation FichaMedicaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(salvaImcNoHealthSotre) name:@"CalcularImc" object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the user interface based on the current user's health information.
                [self atualizaIdade];
                [self atualizaSexo];
                [self atualizaGrupoSanguineo];
                [self atualizaAlturaDoUsuario];
                [self atualizaPesoDoUsuario];
                [self atualizaImcDoUsuario];
            });
        }];
    }
}

#pragma mark - Permissões do HealthKit

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

#pragma mark - Lendo os dados do HealthKit

- (void)atualizaIdade {
    self.idadeUnidadeLabel.text = NSLocalizedString(@"Idade", nil);
    
    NSError *error;
    NSDate *dateOfBirth = [self.healthStore dateOfBirthWithError:&error];
    
    if (!dateOfBirth) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
        
        self.idadeValorLabel.text = NSLocalizedString(@"Não Disponível", nil);
    }
    else {
        // Calcula a idade do usuário
        NSDate *now = [NSDate date];
        
        NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:dateOfBirth toDate:now options:NSCalendarWrapComponents];
        
        NSUInteger usersAge = [ageComponents year];
        
        self.idadeValorLabel.text = [NSNumberFormatter localizedStringFromNumber:@(usersAge) numberStyle:NSNumberFormatterNoStyle];
    }
}

- (void)atualizaSexo {
    self.sexoUnidadeLabel.text = NSLocalizedString(@"Sexo", nil);
    
    NSError *error;
    HKBiologicalSexObject *sexo = [self.healthStore biologicalSexWithError:&error];
    
    if (!sexo) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
        
        self.sexoUnidadeLabel.text = NSLocalizedString(@"Não Disponível", nil);
    }
    else {
        // Calcula a idade do usuário
        int determinaSexo = [sexo biologicalSex];
        self.sexoValorLabel.text = [NSString stringWithFormat:@"%@", [self determinaSexo:determinaSexo]];
    }
    
}

- (void)atualizaGrupoSanguineo {
    self.grupoSanguineoUnidadeLabel.text = @"Grupo Sanguíneo";
    
    //Query para pegar o grupo sanguíneo do usuário, se existir;
    NSError *error;
    HKBloodTypeObject * grupoSanguineo = [self.healthStore bloodTypeWithError:&error];
    
    if (!grupoSanguineo) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
        
        self.grupoSanguineoUnidadeLabel.text = @"Não Disponível";
    } else {
        int num = [grupoSanguineo bloodType];
        
        self.grupoSanguineoValorLabel.text = [NSString stringWithFormat:@"%@",[self bloodType:num]];
    }
}

- (void)atualizaAlturaDoUsuario {
    // Formatando a altura do usuário em centímetros.
    NSLengthFormatter *lengthFormatter = [[NSLengthFormatter alloc] init];
    lengthFormatter.unitStyle = NSFormattingUnitStyleLong;
    
    NSString *localizedHeightUnitDescriptionFormat = NSLocalizedString(@"Altura (%@)", nil);
    
    self.alturaUnidadeLabel.text = [NSString stringWithFormat:localizedHeightUnitDescriptionFormat, @"cm"];
    
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    
    // Query para pegar a última altura do usuário, se existir.
    [self.healthStore aapl_mostRecentQuantitySampleOfType:heightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's height information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.alturaValorLabel.text = NSLocalizedString(@"Não Disponível", nil);
            });
        }
        else {
            // Determina a unidade de medida da altura do usuário
            HKUnit *heightUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixCenti];
            double usersHeight = [mostRecentQuantity doubleValueForUnit:heightUnit];
            
            // Atualize a interface do usuário
            dispatch_async(dispatch_get_main_queue(), ^{
                self.alturaValorLabel.text = [NSString stringWithFormat:@"%.2f", usersHeight];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CalcularImc" object:nil];
            });
        }
    }];
}

- (void)atualizaPesoDoUsuario {
    // Formatando o peso do usuário em quilos.
    NSMassFormatter *massFormatter = [[NSMassFormatter alloc] init];
    massFormatter.unitStyle = NSFormattingUnitStyleLong;
    
    NSString *localizedWeightUnitDescriptionFormat = NSLocalizedString(@"Peso (%@)", nil);
    
    self.pesoUnidadeLabel.text = [NSString stringWithFormat:localizedWeightUnitDescriptionFormat, @"kg"];
    
    // Query para pegar o último peso do usuário, se existir.
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    
    [self.healthStore aapl_mostRecentQuantitySampleOfType:weightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pesoValorLabel.text = NSLocalizedString(@"Não disponível", nil);
            });
        }
        else {
            // Determina  a unidade de medida do peso do usuário
            HKUnit *weightUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
            double usersWeight = [mostRecentQuantity doubleValueForUnit:weightUnit];
            
            // Atualiza a interface do usuário
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pesoValorLabel.text = [NSString stringWithFormat:@"%.2f", usersWeight];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CalcularImc" object:nil];
            });
        }
    }];
}

- (void)atualizaImcDoUsuario {
    self.imcUnidadeLabel.text = @"IMC";
    
    //Query para pegar o imc do usuário, se existir.
    HKQuantityType *imc = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    
    [self.healthStore aapl_mostRecentQuantitySampleOfType:imc predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pesoValorLabel.text = NSLocalizedString(@"Não disponível", nil);
            });
        } else {
            HKUnit *imcUnit = [HKUnit countUnit];
            double userImc = [mostRecentQuantity doubleValueForUnit:imcUnit];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imcValorLabel.text = [NSString stringWithFormat:@"%.2f", userImc];
            });
        }
    }];
}

- (NSString *)bloodType:(int)bloodType {
    NSString *tipoSangue;
    switch (bloodType) {
        case 1:
            tipoSangue = @"A+";
            break;
            
        case 2:
            tipoSangue = @"A-";
            break;
            
        case 3:
            tipoSangue = @"B+";
            break;
            
        case 4:
            tipoSangue = @"B-";
            break;
            
        case 5:
            tipoSangue = @"AB+";
            break;
            
        case 6:
            tipoSangue = @"AB-";
            break;
            
        case 7:
            tipoSangue = @"O+";
            break;
            
        case 8:
            tipoSangue = @"O-";
            break;
            
        default:
            tipoSangue = @"Não Definido";
            break;
    }
    return tipoSangue;
}

- (NSString *)determinaSexo:(int)sexo {
    NSString *tipoSexo;
    switch (sexo) {
        case 1:
            tipoSexo = @"Feminino";
            break;
            
        case 2:
            tipoSexo = @"Masculino";
            break;
            
        case 3:
            tipoSexo = @"Outro";
            break;
            
        default:
            tipoSexo = @"Não Definido";
            break;
    }
    return tipoSexo;
}

#pragma mark - Escrevendo dados no HealthKit

- (void)salvaAlturaNoHealthStore:(double)altura {
    // Salve a altura do usuário no HeathKit.
    HKUnit *heightUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixCenti];
    HKQuantity *heightQuantity = [HKQuantity quantityWithUnit:heightUnit doubleValue:altura];
    
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *heightSample = [HKQuantitySample quantitySampleWithType:heightType quantity:heightQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:heightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the height sample %@. In your app, try to handle this gracefully. The error was: %@.", heightSample, error);
            abort();
        }
        
        [self atualizaAlturaDoUsuario];
    }];
}

- (void)salvaPesoNoHealthStore:(double)peso {
    // Salve o peso do usuário no HealthKit.
    HKUnit *weightUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:weightUnit doubleValue:peso];
    
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", weightSample, error);
            abort();
        }
        [self atualizaPesoDoUsuario];
    }];
}

- (void)salvaImcNoHealthSotre {
    double altura = [self.alturaValorLabel.text floatValue];
    double peso = [self.pesoValorLabel.text floatValue];
    
    double imc = (peso/((altura/100)*(altura/100)));
    
    HKUnit *imcUnit = [HKUnit countUnit];
    HKQuantity *imcQuantity = [HKQuantity quantityWithUnit:imcUnit doubleValue:imc];
    
    HKQuantityType *imcType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *imcSample = [HKQuantitySample quantitySampleWithType:imcType quantity:imcQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:imcSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", imcSample, error);
            abort();
        }
        [self atualizaImcDoUsuario];
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AAPLProfileViewControllerTableViewIndex index = (AAPLProfileViewControllerTableViewIndex)indexPath.row;
    
    // We won't allow people to change their date of birth, so ignore selection of the age cell.
    
    // Set up variables based on what row the user has selected.
    NSString *title;
    void (^valueChangedHandler)(double value);
    
    if (index == AAPLProfileViewControllerTableViewIndex0 && indexPath.section == 0) {
        title = NSLocalizedString(@"Esse campo só pode ser alterado no HealthKit", nil);
    } else if (index == AAPLProfileViewControllerTableViewIndex1 && indexPath.section == 0) {
        title = NSLocalizedString(@"Esse campo só pode ser alterado no HealthKit", nil);
    } else if (index == AAPLProfileViewControllerTableViewIndex2 && indexPath.section == 0) {
        title = NSLocalizedString(@"Esse campo só pode ser alterado no HealthKit", nil);
    } else if (index == AAPLProfileViewControllerTableViewIndex0 && indexPath.section == 1) {
        title = NSLocalizedString(@"Digite sua altura", nil);
        
        valueChangedHandler = ^(double value) {
            [self salvaAlturaNoHealthStore:value];
        };
    } else if (index == AAPLProfileViewControllerTableViewIndex1 && indexPath.section == 1) {
        title = NSLocalizedString(@"Digite seu peso", nil);
        
        valueChangedHandler = ^(double value) {
            [self salvaPesoNoHealthStore:value];
        };
    } else if (index == AAPLProfileViewControllerTableViewIndex2 && indexPath.section == 1) {
        title = NSLocalizedString(@"Digite seu IMC", nil);
    }
    
    // Criando um alerta para ser apresentado
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Adicionando um textField para que o usuário possa colocar um valor numérico
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        // Só permite que o usuário entre com um valor válido
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }];
    
    // Criando o botão "OK"
    NSString *okTitle = NSLocalizedString(@"OK", nil);
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields.firstObject;
        
        double value = textField.text.doubleValue;
        
        valueChangedHandler(value);
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    
    [alertController addAction:okAction];
    
    // Criando o botão "Cancelar"
    NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    
    [alertController addAction:cancelAction];
    
    // Apresentando o alerta
    [self presentViewController:alertController animated:YES completion:nil];
}

@end