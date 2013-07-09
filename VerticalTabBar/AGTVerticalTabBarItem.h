//
//  AGTVerticalTabBarItem.h
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

@interface AGTVerticalTabBarItem : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIViewController *controller;
@property(nonatomic, strong) UIButton *button;

+ (id)itemWithTitle:(NSString *)title controller:(UIViewController *)viewController;
- (id)initWithTitle:(NSString *)title controller:(UIViewController *)viewController;

@end
