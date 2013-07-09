//
//  AGTVerticalTabBarView.m
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

#import "AGTVerticalTabBarView.h"

#define BUTTON_MARGIN       5.0f
#define BUTTON_WIDTH        39.0f
#define BUTTON_HEIGHT       39.0f

@implementation AGTVerticalTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setTabBarButtons:(NSArray *)buttons
{
    // borramos los anteriores por si los cambiamos dinamicamente
    for (id button in _tabBarButtons) {
        [button removeFromSuperview];
    }
    
    _tabBarButtons = buttons;
    
    for (id button in _tabBarButtons) {
        // les añadimos una accion a los botones para responder a la interaccion, llamaremos al delegado y el controlador cambiara el VC
        [button addTarget:self action:@selector(selectTabIfAllowed:) forControlEvents:UIControlEventTouchDown];
    }
    
    if (_tabBarButtons.count > 0) {
        // marcamos el primer boton por defecto
        [[_tabBarButtons objectAtIndex:0] setSelected:YES];
        self.selectedTabBarButton = [_tabBarButtons objectAtIndex:0];
        
        // avisamos al delegado
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectTabAtIndex:)]) {
            [self.delegate tabBar:self didSelectTabAtIndex:0];
        }
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{    
    // vamos a crear los botones centrados
    CGFloat buttonLayoutHeight = (BUTTON_WIDTH * self.tabBarButtons.count) + (BUTTON_MARGIN * (self.tabBarButtons.count - 1));
    CGFloat startOrigin = ((self.bounds.size.height - buttonLayoutHeight) / 2) + 15.0f;
        
    CGRect frame = CGRectMake(self.bounds.origin.x + BUTTON_MARGIN, startOrigin, BUTTON_WIDTH, BUTTON_HEIGHT);
    for (id button in self.tabBarButtons) {
        [button setFrame:frame];
        [self addSubview:button];
        frame.origin.y += (frame.size.height + BUTTON_MARGIN);
    }
}

- (void)selectTabIfAllowed:(id)sender
{
    // solo si no somos el mismo seleccionado
    if (self.selectedTabBarButton != sender) {
        for (id item in self.tabBarButtons) {
            [item setSelected:NO];
        }
        [sender setSelected:YES];
        self.selectedTabBarButton = sender;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectTabAtIndex:)]) {
            [self.delegate tabBar:self didSelectTabAtIndex:[self.tabBarButtons indexOfObject:sender]];
        }
    }
}

@end
