//
//  AGTVerticalTabBarController.h
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

#import "AGTVerticalTabBarView.h"

@interface AGTVerticalTabBarController : UIViewController <AGTVerticalTabBarDelegate>

@property (nonatomic, copy) NSArray *tabBarItems;
@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedIndex;

@end
