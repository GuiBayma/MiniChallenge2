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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"celulaPadrao"];
    if(indexPath.section==0){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Tutorial";
        }
        else {
            cell.textLabel.text = @"Sobre o AirHealth";
        }
    }
//    else{
//        //[cell.textLabel setFrame:CGRectMake(cell.frame.size.width/2,cell.textLabel.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
//        //cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        if(indexPath.row == 0){
//            cell.textLabel.text = @"Permitir o Health";
//            cell.textLabel.textColor = [UIColor blueColor];
//            [cell.textLabel setFrame:CGRectMake(cell.frame.size.width/2, 20, 100, 20)];
//        }
//        else{
//            cell.textLabel.text = @"Apagar todos os dados";
//            cell.textLabel.textColor = [UIColor redColor];
//        }
//    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

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
