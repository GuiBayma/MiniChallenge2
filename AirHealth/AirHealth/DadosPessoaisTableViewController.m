//
//  DadosPessoaisTableViewController.m
//  AirHealth
//
//  Created by Gabriel Alberto de Jesus Preto on 24/03/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "DadosPessoaisTableViewController.h"
#import "DadosPessoaisCell.h"
@interface DadosPessoaisTableViewController ()

@end

@implementation DadosPessoaisTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 15.f)];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DadosPessoaisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dadosPessoaisCell" forIndexPath:indexPath];
    
    if(indexPath.row == 0){
        cell.textPessoais.placeholder = @"Nome";
    }
    else if(indexPath.row == 1){
        cell.textPessoais.placeholder = @"CPF";
    }
    else if(indexPath.row == 2){
        cell.textPessoais.placeholder = @"RG";
    }
    else if(indexPath.row == 3){
        cell.textPessoais.placeholder = @"Endereço";
    }
    else if(indexPath.row == 4){
        cell.textPessoais.placeholder = @"CEP";
    }
    else if(indexPath.row == 5){
        cell.textPessoais.placeholder = @"Cidade";
    }
    else if(indexPath.row == 6){
        cell.textPessoais.placeholder = @"Estado";
    }
    else if(indexPath.row == 7){
        cell.textPessoais.placeholder = @"Plano de Saúde";
    }
    else if(indexPath.row == 8){
        cell.textPessoais.placeholder = @"Número Carteira";
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;

}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
