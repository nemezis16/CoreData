//
//  ORAppDelegate.m
//  EasyNote
//
//  Created by RomanOsadchuk on 10.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORAppDelegate.h"
#import "ORDatabaseModel.h"
#import "ORTableViewController.h"

@interface ORAppDelegate ()
@property (nonatomic, strong)ORDatabaseModel* databaseModel;
@end

@implementation ORAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.databaseModel=[ORDatabaseModel new];
    
    
    // Fetch Main Storyboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    // Instantiate Root Navigation Controller
    UINavigationController *rootNavigationController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"rootNavigationController"];
    
    // Configure View Controller
    ORTableViewController *viewController = (ORTableViewController *)[rootNavigationController topViewController];
    if ([viewController isKindOfClass:[ORTableViewController class]]) {
         viewController.managedObjectContext=self.databaseModel.managedObjectContext;
    }
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:78.0f/255.0f green:165.0/255.0f blue:252.0f/255.0f alpha:1.0f]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];


    
    // Configure Window
    [self.window setRootViewController:rootNavigationController];
    
    return YES;

}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.databaseModel saveContext];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.databaseModel saveContext];
  
}

//

@end
