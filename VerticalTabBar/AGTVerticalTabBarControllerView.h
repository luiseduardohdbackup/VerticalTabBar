//
//  AGTVerticalTabBarControllerView.h
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

@class AGTVerticalTabBarView;

@interface AGTVerticalTabBarControllerView : UIView

@property(nonatomic, strong, readonly) AGTVerticalTabBarView *tabBarView;

- (void)setContentView:(UIView *)contentView animated:(BOOL)animated;

@end
