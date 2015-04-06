//
//  FichaMedicaTableViewController.m
//  AirHealth
//
//  Created by Kaique Damato on 3/26/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "FichaMedicaTableViewController.h"
#import "HKHealthStore+AAPLExtensions.h"
#import "Persistencia.h"

typedef NS_ENUM(NSInteger, AAPLProfileViewControllerTableViewIndex) {
    AAPLProfileViewControllerTableViewIndex0 = 0,
    AAPLProfileViewControllerTableViewIndex1,
    AAPLProfileViewControllerTableViewIndex2,
};

@interface FichaMedicaTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *idadeUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *idadeValorLabel;

@property (weak, nonatomic) IBOutlet UILabel *sexoUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexoValorLabel;

@property (weak, nonatomic) IBOutlet UILabel *grupoSanguineoUnidadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *grupoSanguineoValorLabel;

@property (weak, nonatomic) IBOutlet UILabel *alturaUnidadeLabel;
@property (weak, nonatomic) IBOutlet UITextField *alturaValorTextField;

@property (weak, nonatomic) IBOutlet UILabel *pesoUnidadeLabel;
@property (weak, nonatomic) IBOutlet UITextField *pesoValorTextField;

@property (weak, nonatomic) IBOutlet UILabel *imcUnidadeLabel;
@property (weak, nonatomic) IBOutlet UITextField *imcValorTextField;

@property (weak, nonatomic) IBOutlet UILabel *temperaturaCorporalUnidadeLabel;
@property (weak, nonatomic) IBOutlet UITextField *temperaturaCorporalValorTextField;

@property (weak, nonatomic) IBOutlet UILabel *pressaoSistolicaUnidadeLabel;
@property (weak, nonatomic) IBOutlet UITextField *pressaoSistolicaValorTextField;

@property (weak, nonatomic) IBOutlet UILabel *pressaoDiastolicaUnidadeLabel;
@property (weak, nonatomic) IBOutlet UITextField *pressaoDiastolicaValorTextField;

@end

@implementation FichaMedicaTableViewController {
    Persistencia *persistencia;
    NSNumberFormatter *numFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tocouNaView)];
    [self.view addGestureRecognizer:tap];
    
    self.alturaValorTextField.delegate = self;
    self.pesoValorTextField.delegate = self;
    self.imcValorTextField.delegate = self;
    self.temperaturaCorporalValorTextField.delegate = self;
    self.pressaoSistolicaValorTextField.delegate = self;
    self.pressaoDiastolicaValorTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(salvaImcNoHealthSotre) name:@"CalcularImc" object:nil];
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
                // Atualiza a interface do usuário de acordo com os dados atuais no HealthKit
                [self atualizaIdade];
                [self atualizaSexo];
                [self atualizaGrupoSanguineo];
                [self atualizaAltura];
                [self atualizaPeso];
                [self atualizaImc];
                [self atualizaTemperaturaCorporal];
                [self atualizaPressaoSistolica];
                [self atualizaPressaoDiastolica];
            });
        }];
    }
    
    [self.navigationController.navigationBar.topItem setTitle:@"Ficha Médica"];
    
    //ajustando view entre a navigation e a tabbar
    CGFloat tabBarHeight = self.tabBarController.tabBar.bounds.size.height;
    CGFloat navBarHeight = self.navigationController.navigationBar.bounds.size.height;
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - navBarHeight - tabBarHeight;
    frame.origin.y += navBarHeight;
    self.view.frame = frame;
}

- (void)tocouNaView {
    if ([self.alturaValorTextField isFirstResponder]) {
        [self.alturaValorTextField resignFirstResponder];
    } else if ([self.pesoValorTextField isFirstResponder]) {
        [self.pesoValorTextField resignFirstResponder];
    } else if ([self.imcValorTextField isFirstResponder]) {
        [self.imcValorTextField resignFirstResponder];
    } else if ([self.temperaturaCorporalValorTextField isFirstResponder]) {
        [self.temperaturaCorporalValorTextField resignFirstResponder];
    } else if ([self.pressaoSistolicaValorTextField isFirstResponder]) {
        [self.pressaoSistolicaValorTextField resignFirstResponder];
    } else if ([self.pressaoDiastolicaValorTextField isFirstResponder]) {
        [self.pressaoDiastolicaValorTextField resignFirstResponder];
    }
}

#pragma mark - Permissões do HealthKit

// Retorna os tipos de dados que desejamos atualizar no HealthKit.
- (NSSet *)dadosParaEscrever {
    HKQuantityType *altura = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *peso = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *imc = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    HKQuantityType *temperaturaCorporal = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKQuantityType *pressaoSistolica = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *pressaoDiastolica = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    
    return [NSSet setWithObjects:altura, peso, imc, temperaturaCorporal, pressaoSistolica, pressaoDiastolica, nil];
}

// Retorna os tipos de dados que desejamos ler do HealthKit.
- (NSSet *)dadosParaLer {
    HKCharacteristicType *dataNascimento = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *sexo = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    HKCharacteristicType *tipoSanguineo = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    HKQuantityType *altura = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *peso = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *imc = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    HKQuantityType *temperaturaCorporal = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKQuantityType *pressaoSistolica = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *pressaoDiastolica = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    
    return [NSSet setWithObjects:altura, peso, imc, dataNascimento, tipoSanguineo, sexo, temperaturaCorporal, pressaoSistolica, pressaoDiastolica, nil];
}

#pragma mark - Lendo os dados do HealthKit

- (void)atualizaIdade {
    self.idadeUnidadeLabel.text = NSLocalizedString(@"Idade", nil);
    
    NSError *error;
    NSDate *dateOfBirth = [self.healthStore dateOfBirthWithError:&error];
    
    if (!dateOfBirth) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
        
        if (dateOfBirth == nil) {
            self.idadeValorLabel.text = NSLocalizedString(@"Não Disponível", nil);
        } else {
            self.idadeValorLabel.text = NSLocalizedString(@"Não definido", nil);
        }
        
    }
    else {
        // Calcula a idade do usuário
        NSDate *now = [NSDate date];
        
        NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:dateOfBirth toDate:now options:NSCalendarWrapComponents];
        
        NSUInteger usersAge = [ageComponents year];
        
        self.idadeValorLabel.text = [NSNumberFormatter localizedStringFromNumber:@(usersAge) numberStyle:NSNumberFormatterNoStyle];
        
        [persistencia.fichaMedica setDataNascimento:dateOfBirth];
        
    }
}

- (void)atualizaSexo {
    self.sexoUnidadeLabel.text = NSLocalizedString(@"Sexo", nil);
    
    NSError *error;
    HKBiologicalSexObject *sexo = [self.healthStore biologicalSexWithError:&error];
    
    if (!sexo) {
        NSLog(@"Either an error occured fetching the user's sex information or none has been stored yet. In your app, try to handle this gracefully.");
        
        if (sexo == nil) {
            self.sexoValorLabel.text = NSLocalizedString(@"Não Disponível", nil);
        } else {
            self.sexoValorLabel.text = NSLocalizedString(@"Não definido", nil);
        }
        
    }
    else {
        // Calcula a idade do usuário
        int determinaSexo = [sexo biologicalSex];
        self.sexoValorLabel.text = [NSString stringWithFormat:@"%@", [self determinaSexo:determinaSexo]];
        
        [persistencia.fichaMedica setSexo:self.sexoValorLabel.text];
    }
    
}

- (void)atualizaGrupoSanguineo {
    self.grupoSanguineoUnidadeLabel.text = @"Grupo Sanguíneo";
    
    //Query para pegar o grupo sanguíneo do usuário, se existir;
    NSError *error;
    HKBloodTypeObject * grupoSanguineo = [self.healthStore bloodTypeWithError:&error];
    
    if (!grupoSanguineo) {
        NSLog(@"Either an error occured fetching the user's blood type information or none has been stored yet. In your app, try to handle this gracefully.");
        
        if (grupoSanguineo == nil) {
            self.grupoSanguineoValorLabel.text = NSLocalizedString(@"Não Disponível", nil);
        } else {
            self.grupoSanguineoValorLabel.text = NSLocalizedString(@"Não definido", nil);
        }
        
    } else {
        int num = [grupoSanguineo bloodType];
        
        self.grupoSanguineoValorLabel.text = [NSString stringWithFormat:@"%@",[self bloodType:num]];
        
        [persistencia.fichaMedica setGrupoSanguineo:self.grupoSanguineoValorLabel.text];
    }
}

- (void)atualizaAltura {
    NSString *localizedHeightUnitDescriptionFormat = NSLocalizedString(@"Altura (%@)", nil);
    
    self.alturaUnidadeLabel.text = [NSString stringWithFormat:localizedHeightUnitDescriptionFormat, @"cm"];
    
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    
    // Query para pegar a última altura do usuário, se existir.
    [self.healthStore aapl_mostRecentQuantitySampleOfType:heightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's height information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (heightType == nil) {
                    self.alturaValorTextField.text = NSLocalizedString(@"Não Disponível", nil);
                } else {
                    self.alturaValorTextField.text = NSLocalizedString(@"Não definido", nil);
                }
            });
        }
        else {
            // Determina a unidade de medida da altura do usuário
            HKUnit *heightUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixCenti];
            double usersHeight = [mostRecentQuantity doubleValueForUnit:heightUnit];
            
            // Atualize a interface do usuário
            dispatch_async(dispatch_get_main_queue(), ^{
                self.alturaValorTextField.text = [NSString stringWithFormat:@"%.2f", usersHeight];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CalcularImc" object:nil];
                
                [persistencia.fichaMedica setAltura:[NSNumber numberWithDouble:usersHeight]];
                
            });
        }
    }];
}

- (void)atualizaPeso {
    NSString *localizedWeightUnitDescriptionFormat = NSLocalizedString(@"Peso (%@)", nil);
    
    self.pesoUnidadeLabel.text = [NSString stringWithFormat:localizedWeightUnitDescriptionFormat, @"kg"];
    
    // Query para pegar o último peso do usuário, se existir.
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    
    [self.healthStore aapl_mostRecentQuantitySampleOfType:weightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weightType == nil) {
                    self.pesoValorTextField.text = NSLocalizedString(@"Não Disponível", nil);
                } else {
                    self.pesoValorTextField.text = NSLocalizedString(@"Não definido", nil);
                }
            });
        }
        else {
            // Determina  a unidade de medida do peso do usuário
            HKUnit *weightUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
            double usersWeight = [mostRecentQuantity doubleValueForUnit:weightUnit];
            
            // Atualiza a interface do usuário
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pesoValorTextField.text = [NSString stringWithFormat:@"%.2f", usersWeight];
                
                [persistencia.fichaMedica setPeso:[NSNumber numberWithDouble:usersWeight]];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CalcularImc" object:nil];
            });
        }
    }];
}

- (void)atualizaImc {
    self.imcUnidadeLabel.text = @"IMC";
    
    //Query para pegar o imc do usuário, se existir.
    HKQuantityType *imc = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    
    [self.healthStore aapl_mostRecentQuantitySampleOfType:imc predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's body mass index information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (imc == nil) {
                    self.imcValorTextField.text = NSLocalizedString(@"Não Disponível", nil);
                } else {
                    self.imcValorTextField.text = NSLocalizedString(@"Não definido", nil);
                }
            });
        } else {
            HKUnit *imcUnit = [HKUnit countUnit];
            double userImc = [mostRecentQuantity doubleValueForUnit:imcUnit];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imcValorTextField.text = [NSString stringWithFormat:@"%.2f", userImc];
                [persistencia.fichaMedica setIndiceMassaCorporal:[NSNumber numberWithDouble:userImc]];
            });
        }
    }];
}

- (void)atualizaTemperaturaCorporal {
    NSString *localizedHeightUnitDescriptionFormat = NSLocalizedString(@"Temperatura Corporal (%@)", nil);
    
    self.temperaturaCorporalUnidadeLabel.text = [NSString stringWithFormat:localizedHeightUnitDescriptionFormat, @"°C"];
    
    HKQuantityType *temperaturaCorporal = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    
    // Query para pegar a última altura do usuário, se existir.
    [self.healthStore aapl_mostRecentQuantitySampleOfType:temperaturaCorporal predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's body temperature information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (temperaturaCorporal == nil) {
                    self.temperaturaCorporalValorTextField.text = NSLocalizedString(@"Não Disponível", nil);
                } else {
                    self.temperaturaCorporalValorTextField.text = NSLocalizedString(@"Não definido", nil);
                }
            });
        }
        else {
            // Determina a unidade de medida da altura do usuário
            HKUnit *graus = [HKUnit degreeCelsiusUnit];
            double temperaturaDoUsuario = [mostRecentQuantity doubleValueForUnit:graus];
            
            // Atualize a interface do usuário
            dispatch_async(dispatch_get_main_queue(), ^{
                self.temperaturaCorporalValorTextField.text = [NSString stringWithFormat:@"%.0f", temperaturaDoUsuario];
                
                [persistencia.fichaMedica setTemperaturaCorporal:[NSNumber numberWithDouble:temperaturaDoUsuario]];
            });
        }
    }];
}

- (void)atualizaPressaoSistolica {
    HKQuantityType *pressaoSistolica = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    
    // Query para pegar a última altura do usuário, se existir.
    [self.healthStore aapl_mostRecentQuantitySampleOfType:pressaoSistolica predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's pressure systolic information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (pressaoSistolica == nil) {
                    self.pressaoSistolicaValorTextField.text = NSLocalizedString(@"Não Disponível", nil);
                } else {
                    self.pressaoSistolicaValorTextField.text = NSLocalizedString(@"Não definido", nil);
                }
            });
        }
        else {
            // Determina a unidade de medida da altura do usuário
            HKUnit *pressao = [HKUnit millimeterOfMercuryUnit];
            double pressaoDoUsuario = [mostRecentQuantity doubleValueForUnit:pressao];
            
            // Atualize a interface do usuário
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pressaoSistolicaValorTextField.text = [NSString stringWithFormat:@"%.0f", pressaoDoUsuario];
                
                [persistencia.fichaMedica setPressaoArterialSistolica:[NSNumber numberWithDouble:pressaoDoUsuario]];
            });
        }
    }];

}

- (void)atualizaPressaoDiastolica {
    HKQuantityType *pressaoDiastolica = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    
    // Query para pegar a última altura do usuário, se existir.
    [self.healthStore aapl_mostRecentQuantitySampleOfType:pressaoDiastolica predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's pressure systolic information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (pressaoDiastolica == nil) {
                    self.pressaoDiastolicaValorTextField.text = NSLocalizedString(@"Não Disponível", nil);
                } else {
                    self.pressaoDiastolicaValorTextField.text = NSLocalizedString(@"Não definido", nil);
                }
            });
        }
        else {
            // Determina a unidade de medida da altura do usuário
            HKUnit *pressao = [HKUnit millimeterOfMercuryUnit];
            double pressaoDoUsuario = [mostRecentQuantity doubleValueForUnit:pressao];
            
            // Atualize a interface do usuário
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pressaoDiastolicaValorTextField.text = [NSString stringWithFormat:@"%.0f", pressaoDoUsuario];
                [persistencia.fichaMedica setPressaoArterialDiastolica:[NSNumber numberWithDouble:pressaoDoUsuario]];
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
        
        [self atualizaAltura];
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
        [self atualizaPeso];
    }];
}

- (void)salvaImcNoHealthSotre {
    double altura = [self.alturaValorTextField.text floatValue];
    double peso = [self.pesoValorTextField.text floatValue];
    
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
        [self atualizaImc];
    }];
}

/*
 LEMBRAR DE DECIDIR SE VOU DEIXAR ESSE MÉTODO OU NÃO !!!!!!!!!
*/
- (void)salvaImcNoHealthStore:(double)imc {
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
        [self atualizaImc];
    }];

}

- (void)salvaTemperaturaCorporalNoHealthStore:(double)temperaturaCorporal {
    HKUnit *celsiusUnit = [HKUnit degreeCelsiusUnit];
    HKQuantity *celsiusQuantity = [HKQuantity quantityWithUnit:celsiusUnit doubleValue:temperaturaCorporal];
    
    HKQuantityType *temperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:temperatureType quantity:celsiusQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:temperatureSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", temperatureSample, error);
            abort();
        }
        [self atualizaTemperaturaCorporal];
    }];
}

- (void)salvaPressaoSistolicaNoHealthStore:(double)pressaoSistolica {
    HKUnit *pressureUnit = [HKUnit millimeterOfMercuryUnit];
    HKQuantity *pressureQuantity = [HKQuantity quantityWithUnit:pressureUnit doubleValue:pressaoSistolica];
    
    HKQuantityType *pressureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *pressureSample = [HKQuantitySample quantitySampleWithType:pressureType quantity:pressureQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:pressureSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", pressureSample, error);
            abort();
        }
        [self atualizaPressaoSistolica];
    }];
}

- (void)salvaPressaoDiastolicaNoHealthStore:(double)pressaoDiastolica {
    HKUnit *pressureUnit = [HKUnit millimeterOfMercuryUnit];
    HKQuantity *pressureQuantity = [HKQuantity quantityWithUnit:pressureUnit doubleValue:pressaoDiastolica];
    
    HKQuantityType *pressureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *pressureSample = [HKQuantitySample quantitySampleWithType:pressureType quantity:pressureQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:pressureSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", pressureSample, error);
            abort();
        }
        [self atualizaPressaoDiastolica];
    }];
}

#pragma mark - Ações do teclado

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.alturaValorTextField) {
        [self.alturaValorTextField resignFirstResponder];
    } else if (textField == self.pesoValorTextField) {
        [self.pesoValorTextField resignFirstResponder];
    } else if (textField == self.imcValorTextField) {
        [self.imcValorTextField resignFirstResponder];
    } else if (textField == self.temperaturaCorporalValorTextField) {
        [self.temperaturaCorporalValorTextField resignFirstResponder];
    } else if (textField == self.pressaoSistolicaValorTextField) {
        [self.pressaoSistolicaValorTextField resignFirstResponder];
    } else if (textField == self.pressaoDiastolicaValorTextField) {
        [self.pressaoDiastolicaValorTextField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.alturaValorTextField) {
        double altura = [self.alturaValorTextField.text floatValue];
        [self salvaAlturaNoHealthStore:altura];
    } else if (textField == self.pesoValorTextField) {
        double peso = [self.pesoValorTextField.text floatValue];
        [self salvaPesoNoHealthStore:peso];
    } else if (textField == self.imcValorTextField) {
        double imc = [self.imcValorTextField.text floatValue];
        [self salvaImcNoHealthStore:imc];
    } else if (textField == self.temperaturaCorporalValorTextField) {
        double temperaturaCorporal = [self.temperaturaCorporalValorTextField.text floatValue];
        [self salvaTemperaturaCorporalNoHealthStore:temperaturaCorporal];
    } else if (textField == self.pressaoSistolicaValorTextField) {
        double pressaoSistolica = [self.pressaoSistolicaValorTextField.text floatValue];
        [self salvaPressaoSistolicaNoHealthStore:pressaoSistolica];
    } else if (textField == self.pressaoDiastolicaValorTextField) {
        double pressaoDiastolica = [self.pressaoDiastolicaValorTextField.text floatValue];
        [self salvaPressaoDiastolicaNoHealthStore:pressaoDiastolica];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 1) {
        [self.alturaValorTextField becomeFirstResponder];
    } else if (indexPath.row == 1 && indexPath.section == 1) {
        [self.pesoValorTextField becomeFirstResponder];
    } else if (indexPath.row == 2 && indexPath.section == 1) {
        [self.imcValorTextField becomeFirstResponder];
    } else if (indexPath.row == 0 && indexPath.section == 2) {
        [self.temperaturaCorporalValorTextField becomeFirstResponder];
    } else if (indexPath.row == 1 && indexPath.section == 2) {
        [self.pressaoSistolicaValorTextField becomeFirstResponder];
    } else if (indexPath.row == 2 && indexPath.section == 2){
        [self.pressaoDiastolicaValorTextField becomeFirstResponder];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end