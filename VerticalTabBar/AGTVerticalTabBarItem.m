//
//  AGTVerticalTabBarItem.m
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

#import "AGTVerticalTabBarItem.h"

@implementation AGTVerticalTabBarItem

+ (id)itemWithTitle:(NSString *)title controller:(UIViewController *)viewController
{
    return [[self alloc] initWithTitle:title controller:viewController];
}

- (id)initWithTitle:(NSString *)title controller:(UIViewController *)viewController
{
    if ((self = [super init])) {
        _title = title;
        _controller = viewController;
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_button setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

@end
