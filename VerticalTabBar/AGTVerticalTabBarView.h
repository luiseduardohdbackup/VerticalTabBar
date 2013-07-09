//
//  AGTVerticalTabBarView.h
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

@class AGTVerticalTabBarView;

@protocol AGTVerticalTabBarDelegate <NSObject>

- (void)tabBar:(AGTVerticalTabBarView *)tabBar didSelectTabAtIndex:(NSUInteger)index;

@end


@interface AGTVerticalTabBarView : UIView

@property(nonatomic, weak) id delegate;
@property(nonatomic, copy) NSArray *tabBarButtons;
@property(nonatomic, weak) UIButton *selectedTabBarButton;

@end
