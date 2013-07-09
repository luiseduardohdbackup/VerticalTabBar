//
//  AGTAppDelegate.m
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

#import "AGTAppDelegate.h"
#import "AGTViewController.h"
#import "AGTVerticalTabBarController.h"
#import "AGTVerticalTabBarItem.h"

@implementation AGTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    AGTViewController *vc1 = [AGTViewController controllerWithTitle:@"First VC" backgroundColor:[UIColor greenColor]];
	AGTViewController *vc2 = [AGTViewController controllerWithTitle:@"Second VC" backgroundColor:[UIColor blueColor]];
	AGTViewController *vc3 = [AGTViewController controllerWithTitle:@"Third VC" backgroundColor:[UIColor redColor]];
    
    self.tabBarController = [[AGTVerticalTabBarController alloc] init];
    
    self.tabBarController.tabBarItems = (@[
										 [AGTVerticalTabBarItem itemWithTitle:@"1" controller:vc1],
										 [AGTVerticalTabBarItem itemWithTitle:@"2" controller:vc2],
										 [AGTVerticalTabBarItem itemWithTitle:@"3" controller:vc3]]
										 );

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
