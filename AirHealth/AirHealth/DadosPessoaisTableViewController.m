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

@interface DadosPessoaisTableViewController () <UITextFieldDelegate>

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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    if(indexPath.row == 0 && indexPath.section == 0){
        [nomeTextField becomeFirstResponder];
    } else if (indexPath.row == 1 && indexPath.section == 0) {
        [cpfTextField becomeFirstResponder];
    } else if (indexPath.row == 2 && indexPath.section == 0) {
        [rgTextField becomeFirstResponder];
    } else if (indexPath.row == 3 && indexPath.section == 0) {
        [emailTextField becomeFirstResponder];
    } else if (indexPath.row == 4 && indexPath.section == 0) {
        [telefoneTextField becomeFirstResponder];
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        [enderecoTextField becomeFirstResponder];
    } else if (indexPath.row == 1 && indexPath.section == 1) {
        [cepTextField becomeFirstResponder];
    } else if (indexPath.row == 2 && indexPath.section == 1) {
        [cidadeTextField becomeFirstResponder];
    } else if (indexPath.row == 3 && indexPath.section == 1) {
        [estadoTextField becomeFirstResponder];
    } else if (indexPath.row == 0 && indexPath.section == 2) {
        [nomePlanoTextField becomeFirstResponder];
    } else if (indexPath.row == 1 && indexPath.section == 2) {
        [numeroPlanoTextField becomeFirstResponder];
    } else if (indexPath.row == 2 && indexPath.section == 2) {
        [validadeInicioTextField becomeFirstResponder];
    } else {
        [validadeFimTextField becomeFirstResponder];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
