//
//  AppDelegate.m
//  AirHealth
//
//  Created by Guilherme Bayma on 3/24/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "AppDelegate.h"
#import "PageViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self conexaoParse];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.2470588235 green:0.7450980392 blue:0.5921568627 alpha:1]];
    
    
    return YES;
}

/**
 * @description Método responsável por iniciar a conexão com o Parse.
 */
- (void)conexaoParse {
    
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"fD0pEnOJYuRPQMaTexrZ4ZwYIg8LVsBWJgCh0PN5"
                  clientKey:@"WUGLRcGna3aYmigJoSTXSB1Waq5iEnT2R393UxZ1"];
    
    [PFUser enableAutomaticUser];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
