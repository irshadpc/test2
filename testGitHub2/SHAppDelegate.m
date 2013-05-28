//
//  SHAppDelegate.m
//  testGitHub2
//
//  Created by sathachie on 2013/05/28.
//  Copyright (c) 2013年 SH. All rights reserved.
//

#import "SHAppDelegate.h"
#import "SHEventViewController.h"

@implementation SHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SHEventViewController *eventViewController = [[SHEventViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:eventViewController];
    self.window.rootViewController = navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
