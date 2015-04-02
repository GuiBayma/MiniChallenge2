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

@end
