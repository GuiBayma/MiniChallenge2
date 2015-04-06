//
//  SincronizarViewController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 30/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "SincronizarViewController.h"
#import "Persistencia.h"

@interface SincronizarViewController (){
    int contAnimacao;
    Persistencia *persistencia;
    bool click;
    bool senhaGerada;
    bool dadosOk;
    __block NSString *senha;
}

@end

@implementation SincronizarViewController
@synthesize imageCruz, buttonSincronizar, labelSincronizando, labelSenha,imageOk, labelOk;

- (void)viewDidLoad {
    [super viewDidLoad];
    [imageCruz setUserInteractionEnabled:YES];
    [buttonSincronizar setUserInteractionEnabled:YES];
    buttonSincronizar.adjustsImageWhenHighlighted = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [imageCruz bringSubviewToFront:buttonSincronizar];
    click = NO;
    senhaGerada = NO;
    persistencia = [Persistencia sharedInstance];
    imageOk.alpha = 0;
    labelSenha.alpha = 0;
    imageCruz.alpha = 1;
    buttonSincronizar.alpha = 1;
    [labelSincronizando setHidden:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exibirSenha:) name:@"UsuarioSincronizado" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pedirPermissao) name:@"PedirPermissaoHealthKit" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
}

-(void)viewDidAppear:(BOOL)animated{
    if(senhaGerada){
        labelSenha.alpha=0;
        imageOk.alpha=0;
        labelOk.alpha=0;
        imageCruz.alpha=1;
        buttonSincronizar.alpha=1;
        self.view.backgroundColor = [UIColor whiteColor];
        click=NO;
    }
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    //    BOOL primeiroUso = [defaults boolForKey:@"primeiroUso"];
//    BOOL primeiroUso = NO;
//    if (!primeiroUso) {
//        PageViewController *pvc = [[PageViewController alloc] init];
//        [self presentViewController:pvc animated:YES completion:nil];
//    }
}

- (void)pedirPermissao {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    
    UITouch *toque = [[event allTouches]anyObject];
    
    if([toque view] == imageCruz){
        
        if ([persistencia.usuario.nome isEqual:@""] || [persistencia.usuario.cpf isEqual:@""] || [persistencia.usuario.rg isEqual:@""] || [persistencia.usuario.email isEqual:@""] || [persistencia.usuario.telefone isEqual:@""] || [persistencia.usuario.endereco isEqual:@""] || [persistencia.usuario.cep isEqual:@""] || [persistencia.usuario.cidade isEqual:@""] || [persistencia.usuario.estado isEqual:@""] || [persistencia.infoConvenio.nomePlanodeSaude isEqual:@""] || [persistencia.infoConvenio.numCartao isEqual:@""]) {
            
            dadosOk = NO;
            
            UIAlertView *alertaDadosNaoPreenchidos = [[UIAlertView alloc] initWithTitle:@"Dados não preenchidos"
                                                                                message:@"É necessário que os dados estejam preenchidos pra realizar a sincronização"
                                                                               delegate:self
                                                                      cancelButtonTitle:@"Ok"
                                                                      otherButtonTitles:nil];
            
            [alertaDadosNaoPreenchidos show];
            
        }
        else
            dadosOk = YES;
        
        if(click == NO && dadosOk) {
            [self tremblingButton];
            [self scaleImageReverse];
            [self rotateImageView];
            [self enviarDadosPraNuvem];
        }
        
    }
    
}

- (void)rotateImageView{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [imageCruz setTransform:CGAffineTransformRotate(imageCruz.transform, M_PI_2)];
                     }completion:^(BOOL finished){
                         if(finished){
                             [self rotateImageView];
                         }
                     }];
}

- (void)tremblingButton{
    
    CAKeyframeAnimation * anim = [CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
    anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-4.0f, -1.0f, 0.0f) ],[ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(4.0f, 1.0f, 0.0f) ] ] ;
    anim.autoreverses = YES ;
    anim.repeatCount = 100;
    anim.duration = 0.1f ;
    
    [buttonSincronizar.layer addAnimation:anim forKey:nil ] ;

}

-(void)scaleImageReverse{
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         buttonSincronizar.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     }
                     completion:nil
                     ];

}

-(void)sincronizar:(id)sender{
    
    if ([persistencia.usuario.nome isEqual:@""] || [persistencia.usuario.cpf isEqual:@""] || [persistencia.usuario.rg isEqual:@""] || [persistencia.usuario.email isEqual:@""] || [persistencia.usuario.telefone isEqual:@""] || [persistencia.usuario.endereco isEqual:@""] || [persistencia.usuario.cep isEqual:@""] || [persistencia.usuario.cidade isEqual:@""] || [persistencia.usuario.estado isEqual:@""] || [persistencia.infoConvenio.nomePlanodeSaude isEqual:@""] || [persistencia.infoConvenio.numCartao isEqual:@""]) {
        
        dadosOk = NO;
    
        UIAlertView *alertaDadosNaoPreenchidos = [[UIAlertView alloc] initWithTitle:@"Dados não preenchidos"
                                                                            message:@"É necessário que os dados estejam preenchidos pra realizar a sincronização"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
        
        [alertaDadosNaoPreenchidos show];
    
    }
    else
        dadosOk = YES;
    
    
    if(click == NO && dadosOk) {
        [self tremblingButton];
        [self scaleImageReverse];
        [self rotateImageView];
        [self enviarDadosPraNuvem];
        click = YES;
    }
    
    
}

- (void)stopAnimation{
    [imageCruz.layer removeAllAnimations];
    [buttonSincronizar.layer removeAllAnimations];
}

- (void)enviarDadosPraNuvem {
    [persistencia salvarInfoConvenioNuvem];
    [persistencia salvarFichaNuvem];
    [persistencia salvarUsuarioNuvem];
}

- (void)exibirSenha:(NSNotification *)not {
    
    senha = not.object;
    
    [UIView animateWithDuration:2.0 animations:^{
        imageCruz.alpha = 1.0;
        buttonSincronizar.alpha = 1.0;
        
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        #define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0];
        self.view.backgroundColor = Rgb2UIColor(58, 191, 151);
        imageCruz.alpha = 0.0;
        buttonSincronizar.alpha = 0.0;
    }];
    
    [UIView animateWithDuration:2.0 animations:^{
        labelSenha.text = [NSString stringWithFormat:@"Senha: %@", senha];
        
        UIView *rect = [[UIView alloc]initWithFrame:CGRectMake(self.tabBarController.tabBar.frame.origin.x, self.tabBarController.tabBar.frame.origin.y, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height)];
        
        rect.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:rect];
        imageOk.alpha = 1.0;
        labelSenha.alpha = 1.0;
        labelOk.alpha = 1.0;
    }];
    
    senhaGerada = YES;
}


@end
