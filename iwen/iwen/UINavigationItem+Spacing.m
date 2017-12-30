//
//  UINavigationItem+Spacing.m
//  iwen
//
//  Created by Interest on 15/10/21.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "UINavigationItem+Spacing.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation UINavigationItem (Spacing)

+(void)load
{
    Method  a = class_getInstanceMethod(self, @selector(setRightBarButtonItem:));
    
    Method  b = class_getInstanceMethod(self, @selector(mySetRightBarButtonItem:));
    
    method_exchangeImplementations(a, b);
    
    
    Method  e = class_getInstanceMethod(self, @selector(setLeftBarButtonItem:));
    
    Method  f = class_getInstanceMethod(self, @selector(mySetLeftBarButtonItem:));
    
    method_exchangeImplementations(e, f);
}



- (UIBarButtonItem *)spacer
{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                           target:nil action:nil];
    space.width = -10.0f;
    return space ;
}

- (void)mySetRightBarButtonItem:(UIBarButtonItem *)barButton{
    
    NSArray *barButtoms = [NSArray array];
    
    barButtoms = [NSArray arrayWithObjects:[self spacer],barButton, nil];
    
    [self setRightBarButtonItems:barButtoms];
    
    
}

- (void)mySetLeftBarButtonItem:(UIBarButtonItem *)barButton{
    
    NSArray *barButtoms = [NSArray array];
    
    barButtoms = [NSArray arrayWithObjects:[self spacer],barButton, nil];
    
    [self setLeftBarButtonItems:barButtoms];
    
    
}

@end
