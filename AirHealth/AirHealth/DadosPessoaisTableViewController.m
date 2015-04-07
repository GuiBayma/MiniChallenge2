//
//  DadosPessoaisTableViewController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 24/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "DadosPessoaisTableViewController.h"
#import "Persistencia.h"
#import "Usuario.h"

@interface DadosPessoaisTableViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation DadosPessoaisTableViewController {
    Persistencia *persistencia;
    
    __weak IBOutlet UITextField *nomeTextField;
    __weak IBOutlet UITextField *cpfTextField;
    __weak IBOutlet UITextField *rgTextField;
    __weak IBOutlet UITextField *emailTextField;
    __weak IBOutlet UITextField *telefoneTextField;
    
    __weak IBOutlet UITextField *enderecoTextField;
    __weak IBOutlet UITextField *cepTextField;
    __weak IBOutlet UITextField *cidadeTextField;
    __weak IBOutlet UITextField *estadoTextField;
    
    __weak IBOutlet UITextField *nomePlanoTextField;
    __weak IBOutlet UITextField *numeroPlanoTextField;
    __weak IBOutlet UITextField *validadeInicioTextField;
    __weak IBOutlet UITextField *validadeFimTextField;
    
    __weak IBOutlet UIImageView *imagem;
    __weak IBOutlet UIButton *selecionaFotoBotao;
    
    UIDatePicker *datePicker;
    NSDateFormatter *dateFormat;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tocouNaView)];
    [self.view addGestureRecognizer:tap];
    
    selecionaFotoBotao.tintColor = [UIColor colorWithRed:0.2470588235 green:0.7450980392 blue:0.5921568627 alpha:1];
    imagem.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    UIView *viewBotao = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UIButton *botaoConfirma = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, 0, 90, 50)];
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    viewBotao.backgroundColor = [UIColor lightGrayColor];
    [botaoConfirma setTitle:@"Concluído" forState:UIControlStateNormal];
    [botaoConfirma addTarget:self action:@selector(confirmaData) forControlEvents:UIControlEventTouchUpInside];
    [botaoConfirma setTitleColor:[UIColor colorWithRed:0.07058823529 green:0.3960784314 blue:0.9803921569 alpha:1] forState:UIControlStateNormal];
    
    [view addSubview:datePicker];
    [view addSubview:viewBotao];
    [view addSubview:botaoConfirma];
    
    [validadeInicioTextField setInputView:view];
    [validadeFimTextField setInputView:view];
    
    nomeTextField.delegate = self;
    cpfTextField.delegate = self;
    rgTextField.delegate = self;
    emailTextField.delegate = self;
    telefoneTextField.delegate = self;
    enderecoTextField.delegate = self;
    cepTextField.delegate = self;
    cidadeTextField.delegate = self;
    estadoTextField.delegate = self;
    nomePlanoTextField.delegate = self;
    numeroPlanoTextField.delegate = self;
    validadeInicioTextField.delegate = self;
    validadeFimTextField.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    persistencia = [Persistencia sharedInstance];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    
    
}

- (void)tocouNaView {
    if ([nomeTextField isFirstResponder]) {
        [nomeTextField resignFirstResponder];
    } else if ([cpfTextField isFirstResponder]) {
        [cpfTextField resignFirstResponder];
    } else if ([rgTextField isFirstResponder]) {
        [rgTextField resignFirstResponder];
    } else if ([emailTextField isFirstResponder]) {
        [emailTextField resignFirstResponder];
    } else if ([telefoneTextField isFirstResponder]) {
        [telefoneTextField resignFirstResponder];
    } else if ([enderecoTextField isFirstResponder]) {
        [enderecoTextField resignFirstResponder];
    } else if ([cepTextField isFirstResponder]) {
        [cepTextField resignFirstResponder];
    } else if ([cidadeTextField isFirstResponder]) {
        [cidadeTextField resignFirstResponder];
    } else if ([estadoTextField isFirstResponder]) {
        [estadoTextField resignFirstResponder];
    } else if ([nomePlanoTextField isFirstResponder]) {
        [nomePlanoTextField resignFirstResponder];
    } else if ([numeroPlanoTextField isFirstResponder]) {
        [numeroPlanoTextField resignFirstResponder];
    } else if ([validadeInicioTextField isFirstResponder]) {
        [validadeInicioTextField resignFirstResponder];
    } else {
        [validadeFimTextField resignFirstResponder];
    }
}

- (void)confirmaData {
    
    NSString *theDate = [dateFormat stringFromDate:datePicker.date];
    
    if ([validadeInicioTextField isFirstResponder]) {
        validadeInicioTextField.text = [NSString stringWithFormat:@"%@",theDate];
        [validadeFimTextField becomeFirstResponder];
    } else if ([validadeFimTextField isFirstResponder]) {
        validadeFimTextField.text = [NSString stringWithFormat:@"%@",theDate];
        [validadeFimTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)viewDidAppear:(BOOL)animated {
    
    nomeTextField.text = [persistencia.usuario nome];
    cpfTextField.text = [persistencia.usuario cpf];
    rgTextField.text = [persistencia.usuario rg];
    emailTextField.text = [persistencia.usuario email];
    telefoneTextField.text = [persistencia.usuario telefone];
    
    enderecoTextField.text = [persistencia.usuario endereco];
    cepTextField.text = [persistencia.usuario cep];
    cidadeTextField.text = [persistencia.usuario cidade];
    estadoTextField.text = [persistencia.usuario estado];

    nomePlanoTextField.text = [persistencia.infoConvenio nomePlanodeSaude];
    numeroPlanoTextField.text = [persistencia.infoConvenio numCartao];
    validadeInicioTextField.text = [dateFormat stringFromDate:[persistencia.infoConvenio inicioValidade]];
    validadeFimTextField.text = [dateFormat stringFromDate:[persistencia.infoConvenio terminoValidade]];
    
    if (persistencia.usuario.imagem) {
        imagem.image = [UIImage imageWithData:[persistencia.usuario imagem]];
        [selecionaFotoBotao setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
    
    [self.navigationController.navigationBar.topItem setTitle:@"Dados Pessoais"];
        
}

- (IBAction)selecionaFoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [sender setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    imagem.image = chosenImage;
    
    [persistencia.usuario setImagem:UIImagePNGRepresentation(chosenImage)];
    [persistencia salvarUsuarioLocal];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([imagem isOpaque]) {
        [selecionaFotoBotao setTitleColor:[UIColor colorWithRed:0.2470588235 green:0.7450980392 blue:0.5921568627 alpha:1] forState:UIControlStateNormal];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)saveImage: (UIImage *)image {
    NSString *path;
    if (image != nil)
    {
        path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                   NSUserDomainMask, YES)[0];
        path = [path stringByAppendingPathComponent:
                [NSString stringWithFormat:@"%@.png",
                 nomeTextField.text]];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
    return path;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == nomeTextField) {
        [cpfTextField becomeFirstResponder];
    } else if (textField == cpfTextField) {
        [rgTextField becomeFirstResponder];
    } else if (textField == rgTextField) {
        [emailTextField becomeFirstResponder];
    } else if (textField == emailTextField) {
        [telefoneTextField becomeFirstResponder];
    } else if (textField == telefoneTextField) {
        [enderecoTextField becomeFirstResponder];
    } else if (textField == enderecoTextField) {
        [cepTextField becomeFirstResponder];
    } else if (textField  == cepTextField) {
        [cidadeTextField becomeFirstResponder];
    } else if (textField == cidadeTextField) {
        [estadoTextField becomeFirstResponder];
    } else if (textField == estadoTextField) {
        [nomePlanoTextField becomeFirstResponder];
    } else if (textField == nomePlanoTextField) {
        [numeroPlanoTextField becomeFirstResponder];
    } else if (textField == numeroPlanoTextField) {
        [validadeInicioTextField becomeFirstResponder];
    } else if (textField == validadeInicioTextField) {
        [validadeFimTextField becomeFirstResponder];
    }
    
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0 && indexPath.section == 1){
        [nomeTextField becomeFirstResponder];
    } else if (indexPath.row == 1 && indexPath.section == 1) {
        [cpfTextField becomeFirstResponder];
    } else if (indexPath.row == 2 && indexPath.section == 1) {
        [rgTextField becomeFirstResponder];
    } else if (indexPath.row == 3 && indexPath.section == 1) {
        [emailTextField becomeFirstResponder];
    } else if (indexPath.row == 4 && indexPath.section == 1) {
        [telefoneTextField becomeFirstResponder];
    } else if (indexPath.row == 0 && indexPath.section == 2) {
        [enderecoTextField becomeFirstResponder];
    } else if (indexPath.row == 1 && indexPath.section == 2) {
        [cepTextField becomeFirstResponder];
    } else if (indexPath.row == 2 && indexPath.section == 2) {
        [cidadeTextField becomeFirstResponder];
    } else if (indexPath.row == 3 && indexPath.section == 2) {
        [estadoTextField becomeFirstResponder];
    } else if (indexPath.row == 0 && indexPath.section == 3) {
        [nomePlanoTextField becomeFirstResponder];
    } else if (indexPath.row == 1 && indexPath.section == 3) {
        [numeroPlanoTextField becomeFirstResponder];
    } else if (indexPath.row == 2 && indexPath.section == 3) {
        [validadeInicioTextField becomeFirstResponder];
    } else {
        [validadeFimTextField becomeFirstResponder];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:nomeTextField]) {
        [persistencia.usuario setNome:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if ([textField isEqual:cpfTextField]) {
        [persistencia.usuario setCpf:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if ([textField isEqual:rgTextField]) {
        [persistencia.usuario setRg:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if ([textField isEqual:emailTextField]) {
        [persistencia.usuario setEmail:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if([textField isEqual:telefoneTextField]) {
        [persistencia.usuario setTelefone:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if ([textField isEqual:enderecoTextField]) {
        [persistencia.usuario setEndereco:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if ([textField isEqual:cepTextField]) {
        [persistencia.usuario setCep:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if ([textField isEqual:cidadeTextField]) {
        [persistencia.usuario setCidade:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if ([textField isEqual:estadoTextField]) {
        [persistencia.usuario setEstado:textField.text];
        [persistencia salvarUsuarioLocal];
    }
    else if ([textField isEqual:nomePlanoTextField]) {
        [persistencia.infoConvenio setNomePlanodeSaude:textField.text];
        [persistencia salvarInfoConvenioLocal];
    }
    else if ([textField isEqual:numeroPlanoTextField]) {
        [persistencia.infoConvenio setNumCartao:textField.text];
        [persistencia salvarInfoConvenioLocal];
    }
    else if ([textField isEqual:validadeInicioTextField]) {
        [persistencia.infoConvenio setInicioValidade:[dateFormat dateFromString:textField.text]];
        [persistencia salvarInfoConvenioLocal];
    }
    else if ([textField isEqual:validadeFimTextField]) {
        [persistencia.infoConvenio setTerminoValidade:[dateFormat dateFromString:textField.text]];
        [persistencia salvarInfoConvenioLocal];
    }
    
}


@end
