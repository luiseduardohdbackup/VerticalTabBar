//
//  AGTVerticalTabBarController.m
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

#import "AGTVerticalTabBarController.h"
#import "AGTVerticalTabBarControllerView.h"
#import "AGTVerticalTabBarItem.h"
#import "AGTVerticalTabBarView.h"

#define STATUS_BAR_HEIGHT 20.0f


@interface AGTVerticalTabBarController ()

@property(nonatomic, assign) NSInteger lastSelectedIndex;

@end


@implementation AGTVerticalTabBarController

- (id)init
{
    self = [super init];
    if (self) {
        _lastSelectedIndex = 0;
    }
    return self;
}

- (void)loadView
{
    // sobreescribimos el metodo de cargar la vista para crearla a nuestra manera
    CGRect mainFrame = [UIScreen mainScreen].applicationFrame;
    CGRect viewFrame = CGRectMake(0.0f, STATUS_BAR_HEIGHT, mainFrame.size.width, mainFrame.size.height);
    
    // como vista vamos a asignar nuestra propia vista personalizada en vez de una UIView
    // esta vista contiene tanto el tabBar como la vista en si
    self.view = [[AGTVerticalTabBarControllerView alloc] initWithFrame:viewFrame];
    
    // extraemos los botones que contienen los AGTVerticalTabBarItem para pasarselos a la vista del tabBar
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:self.tabBarItems.count];
    
    for (NSUInteger i = 0; i < self.tabBarItems.count; i++) {
        AGTVerticalTabBarItem *item = [self.tabBarItems objectAtIndex:i];
        [buttons addObject:item.button];
    }
    
    // recuperamos la vista del tabBar, le asignamos los botones y nos hacemos su delegado
    AGTVerticalTabBarView *tabBarView = [(AGTVerticalTabBarControllerView *)self.view tabBarView];
    tabBarView.tabBarButtons = buttons;
    tabBarView.delegate = self;
    
    // marcamos el viewController actual, por defecto el 0
    [self setSelectedIndex:self.lastSelectedIndex];
}

- (void)setTabBarItems:(NSArray *)tabBarItems
{
    if (_tabBarItems != tabBarItems) {
        // cada vez que nos asignen nuevos items, los eliminamos
        for (AGTVerticalTabBarItem *item in _tabBarItems) {
            [item.controller willMoveToParentViewController:nil];
            [item.controller removeFromParentViewController];
        }
        
        // y los añadimos a la jerarquia de viewControllers
        _tabBarItems = tabBarItems;
        for (AGTVerticalTabBarItem *item in tabBarItems) {
            [self addChildViewController:item.controller];
            [item.controller didMoveToParentViewController:self];
        }
    }
}

- (void)setSelectedViewController:(UIViewController *)newViewController
{
    // si estan seleccionando el mismo VC no hacemos nada
    if (_selectedViewController == newViewController) {
        return;
    }
    
    _selectedViewController = newViewController;
    
    // le decimos a nuestra vista (AGTVerticalTabBarControllerView) que pinte la vista del nuevo VC animandolo
    [(id)self.view setContentView:_selectedViewController.view animated:YES];
    
    // nos guardamos el ultimo indice seleccionado y marcamos la seleccion en el boton correspondiente (para cambiar icono por ejemplo)
    AGTVerticalTabBarItem *item;
    for (NSUInteger i = 0; i < self.tabBarItems.count; ++i) {
        item = [self.tabBarItems objectAtIndex:i];
        [item.button setSelected:(item.controller == _selectedViewController)];
        if (item.button.selected) {
            self.lastSelectedIndex = i;
        }
        [item.button setNeedsDisplay];
    }
}

- (void)setSelectedIndex:(NSUInteger)index
{
    UIViewController *viewController = [[self.tabBarItems objectAtIndex:index] controller];
    [self setSelectedViewController:viewController];
}

- (NSUInteger)selectedIndex
{
    // devolvemos el indice seleccionado comparando los VC asociados a los tabBarItems con el VC actual
    for (NSUInteger i = 0; i < self.tabBarItems.count; ++i) {
        if ([[self.tabBarItems objectAtIndex:i] controller] == self.selectedViewController) {
            return i;
        }
    }
    return 0;
}

#pragma mark - AGTVerticalTabBarDelegate

- (void)tabBar:(AGTVerticalTabBarController *)tabBar didSelectTabAtIndex:(NSUInteger)index
{
    UIViewController *viewController = [[self.tabBarItems objectAtIndex:index] controller];
    self.selectedViewController = viewController;
}

@end
