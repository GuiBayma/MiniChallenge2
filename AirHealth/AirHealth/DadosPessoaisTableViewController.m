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

@interface DadosPessoaisTableViewController ()

@end

@implementation DadosPessoaisTableViewController {
    Persistencia *persistencia;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DadosPessoaisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dadosPessoaisCell" forIndexPath:indexPath];
    
    if(indexPath.row == 0){
        cell.dado.text = @"Nome";
        cell.valor.text = [persistencia.usuario nome];
    }
    else if(indexPath.row == 1){
        cell.dado.text = @"CPF";
        cell.valor.text = [persistencia.usuario cpf];
    }
    else if(indexPath.row == 2){
        cell.dado.text = @"RG";
        cell.valor.text = [persistencia.usuario rg];
    }
    else if(indexPath.row == 3){
        cell.dado.text = @"Endereço";
        cell.valor.text = [persistencia.usuario endereco];
    }
    else if(indexPath.row == 4){
        cell.dado.text = @"CEP";
        cell.valor.text = [persistencia.usuario cep];
    }
    else if(indexPath.row == 5){
        cell.dado.text = @"Cidade";
        cell.valor.text = [persistencia.usuario cidade];
    }
    else if(indexPath.row == 6){
        cell.dado.text = @"Estado";
        cell.valor.text = [persistencia.usuario estado];
    }
    else if(indexPath.row == 7){
        cell.dado.text = @"Plano de Saúde";
        cell.valor.text = [persistencia.infoConvenio nomePlanodeSaude];
    }
    else if(indexPath.row == 8){
        cell.dado.text = @"Número Carteira";
        cell.valor.text = [persistencia.infoConvenio numCartao];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DadosPessoaisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dadosPessoaisCell" forIndexPath:indexPath];
    NSString *title;
    
    if(indexPath.row == 0){
        title = @"Seu Nome";
    }
    else if (indexPath.row == 1) {
        title = @"Seu CPF";
    }
    else if (indexPath.row == 2) {
        title = @"Seu RG";
    }
    else if (indexPath.row == 3) {
        title = @"Seu Endereço";
    }
    else if (indexPath.row == 4) {
        title = @"Seu CEP";
    }
    else if (indexPath.row == 5) {
        title = @"Seu Cidade";
    }
    else if (indexPath.row == 6) {
        title = @"Seu Estado";
    }
    else if (indexPath.row == 7) {
        title = @"Seu Plano de Saúde";
    }
    else if (indexPath.row == 8) {
        title = @"Seu Número Carteira";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Add the text field to let the user enter a numeric value.
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    // Create the "OK" button.
    NSString *okTitle = NSLocalizedString(@"OK", nil);
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields.firstObject;
        NSString *value = textField.text;
        cell.valor.text = value;
        
        if (![value isEqualToString:@""]) {
            
            switch (indexPath.row) {
                case 0:
                    [persistencia.usuario setNome: value];
                    break;
                case 1:
                    [persistencia.usuario setCpf:value];
                    break;
                case 2:
                    [persistencia.usuario setRg:value];
                    break;
                case 3:
                    [persistencia.usuario setEndereco:value];
                    break;
                case 4:
                    [persistencia.usuario setCep:value];
                    break;
                case 5:
                    [persistencia.usuario setCidade:value];
                    break;
                case 6:
                    [persistencia.usuario setEstado:value];
                    break;
                case 7:
                    [persistencia.infoConvenio setNomePlanodeSaude:value];
                    break;
                case 8:
                    [persistencia.infoConvenio setNumCartao:value];
                    break;
                default:
                    break;
            }
            
            [persistencia salvarUsuarioLocal];
            [persistencia salvarInfoConvenioLocal];
            
            //antes de reabilitar a interface novamente devo salvar o usuario
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            BOOL usuarioCadastrado = YES;
            [defaults setBool:usuarioCadastrado forKey:@"usuarioCadastrado"];
            [defaults synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HabilitarItensTabBar" object:nil];
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    
    [alertController addAction:okAction];
    
    // Create the "Cancel" button.
    NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    
    [alertController addAction:cancelAction];
    
    // Present the alert controller.
    [self presentViewController:alertController animated:YES completion:nil];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
