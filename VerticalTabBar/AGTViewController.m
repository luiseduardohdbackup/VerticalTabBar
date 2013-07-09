//
//  AGTViewController.m
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

#import "AGTViewController.h"

@interface AGTViewController ()

@end

@implementation AGTViewController

+ (id)controllerWithTitle:(NSString *)title backgroundColor:(UIColor *)bgColor
{
	UIViewController *controller = [[self alloc] initWithNibName:nil bundle:nil];
	controller.title = title;
	controller.view.backgroundColor = bgColor;
	return controller;
}

@end
