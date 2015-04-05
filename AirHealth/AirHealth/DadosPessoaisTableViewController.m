//
//  DadosPessoaisTableViewController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 24/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "DadosPessoaisTableViewController.h"
#import "DadosPessoaisCell.h"
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
    
    UIViewController *viewController;
    UIView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selecionaFotoBotao.tintColor = [UIColor colorWithRed:0.2470588235 green:0.7450980392 blue:0.5921568627 alpha:1];
    imagem.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [validadeInicioTextField setInputView:datePicker];
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0, 0, 0);
    
    persistencia = [Persistencia sharedInstance];
    
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
        enderecoTextField.text = [persistencia.usuario endereco];
        cepTextField.text = [persistencia.usuario cep];
        cidadeTextField.text = [persistencia.usuario cidade];
        estadoTextField.text = [persistencia.usuario estado];
        nomePlanoTextField.text = [persistencia.infoConvenio nomePlanodeSaude];
        numeroPlanoTextField.text = [persistencia.infoConvenio numCartao];
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
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([imagem isOpaque]) {
        [selecionaFotoBotao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    if ([textField isEqual:nomeTextField])
        [persistencia.usuario setNome:textField.text];
    
    else if ([textField isEqual:cpfTextField])
        [persistencia.usuario setCpf:textField.text];
    
    else if ([textField isEqual:rgTextField])
        [persistencia.usuario setRg:textField.text];
    
    else if ([textField isEqual:emailTextField])
        [persistencia.usuario setEmail:textField.text];
    
    else if([textField isEqual:telefoneTextField])
        [persistencia.usuario setTelefone:textField.text];
    
    else if ([textField isEqual:enderecoTextField])
        [persistencia.usuario setEndereco:textField.text];
    
    else if ([textField isEqual:cepTextField])
        [persistencia.usuario setCep:textField.text];
    
    else if ([textField isEqual:cidadeTextField])
        [persistencia.usuario setCidade:textField.text];
    
    else if ([textField isEqual:estadoTextField])
        [persistencia.usuario setEstado:textField.text];
    
    else if ([textField isEqual:nomePlanoTextField])
        [persistencia.infoConvenio setNomePlanodeSaude:textField.text];
    
    else if ([textField isEqual:numeroPlanoTextField])
        [persistencia.infoConvenio setNumCartao:textField.text];
    
    else if ([textField isEqual:validadeInicioTextField])
        [persistencia.infoConvenio setInicioValidade:[dateFormat dateFromString:textField.text]];
    
    else if ([textField isEqual:validadeFimTextField])
        [persistencia.infoConvenio setTerminoValidade:[dateFormat dateFromString:textField.text]];
}

@end
