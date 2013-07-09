//
//  AGTVerticalTabBarControllerView.m
//  VerticalTabBar
//
//  Created by Miguel Ferrando on 04/07/13.
//  Copyright (c) 2013 AGBO. All rights reserved.
//

#import "AGTVerticalTabBarControllerView.h"
#import "AGTVerticalTabBarView.h"

#define TAB_BAR_WIDHT 49


@interface AGTVerticalTabBarControllerView ()

@property(nonatomic, strong) AGTVerticalTabBarView *tabBarView;
@property(nonatomic, strong) UIView *contentView;

@end


@implementation AGTVerticalTabBarControllerView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        // creamos el tabBar
        CGRect tabBarFrame = CGRectMake(0, 0, TAB_BAR_WIDHT, self.frame.size.height);
        _tabBarView = [[AGTVerticalTabBarView alloc] initWithFrame:tabBarFrame];
        [self addSubview:self.tabBarView];
    }
    return self;
}

- (void)setContentView:(UIView *)newContentView animated:(BOOL)animated
{
    if (!_contentView) {
        // si no hay contentView es porque acabamos de arrancar y tenemos que asignar la primera vista
        // contentView tendra el contenido de la view del VC en cuestion
        newContentView.frame = CGRectMake(TAB_BAR_WIDHT, 0, self.bounds.size.width - TAB_BAR_WIDHT, self.bounds.size.height);
        _contentView = newContentView;
        [self addSubview:_contentView];
        [self sendSubviewToBack:_contentView];
    }
    else {
        UIView *oldContentView = _contentView;
        
        if (!animated) {
            // si lo queremos sin animacion, nosotros le hemos dicho a piñon que si, pero lo dejamos al gusto
            newContentView.frame = CGRectMake(TAB_BAR_WIDHT, 0, self.bounds.size.width - TAB_BAR_WIDHT, self.bounds.size.height);
            _contentView = newContentView;
            [self addSubview:_contentView];
            [self sendSubviewToBack:_contentView];
            [oldContentView removeFromSuperview];
        }
        else {
			// lo vamos a desplazar de izquierda a derecha
            CGFloat xAmount = -_contentView.frame.size.width;
            
            newContentView.frame = oldContentView.frame;
            
            // ajustamos la posicion x
            newContentView.frame = CGRectMake(xAmount + TAB_BAR_WIDHT, newContentView.frame.origin.y, newContentView.frame.size.width, newContentView.frame.size.height);
            
            _contentView = newContentView;
            
            [self addSubview:_contentView];
            [self sendSubviewToBack:_contentView];
            
			self.userInteractionEnabled = NO;
            
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 oldContentView.frame = CGRectMake(oldContentView.frame.origin.x - xAmount, oldContentView.frame.origin.y, oldContentView.frame.size.width, oldContentView.frame.size.height);
                                 newContentView.frame = CGRectMake(newContentView.frame.origin.x - xAmount, newContentView.frame.origin.y, newContentView.frame.size.width, newContentView.frame.size.height);
                             }
                             completion:^(BOOL finished) {
                                 [oldContentView removeFromSuperview];
                                 [_contentView setNeedsLayout];
                                 self.userInteractionEnabled = YES;
                             }];
        }
    }
}

@end
