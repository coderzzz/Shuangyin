//
//  UINavigationController+Visitors.m
//  iwen
//
//  Created by Interest on 15/11/19.
//  Copyright © 2015年 Interest. All rights reserved.
//

#import "UINavigationController+Visitors.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation UINavigationController (Visitors)


+(void)load
{
//    Method  a = class_getInstanceMethod(self, @selector(pushViewController:animated:));
//    
//    Method  b = class_getInstanceMethod(self, @selector(myPushViewController:animated:));
//    
//    method_exchangeImplementations(a, b);
}


- (void)myPushViewController:(UIViewController *)vc animated:(BOOL)animated{
    
    
    
    
    UserModel *model = [[LoginService shareInstanced]getUserModel];
    
    unsigned int outCount, i;
    
    BOOL isExit = NO;
    
    objc_property_t * properties = class_copyPropertyList([vc class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        if ([propertyName isEqualToString:@"tourist"]) {
            free(properties);
            
            isExit  = YES;
            
            break;
        }
    }
    if (isExit && !model.fphone.length>0) {
        
        
        NSString *class =@"LoginViewController";
        const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
        
      
        Class newClass = objc_getClass(className);
        if (!newClass)
        {
          
            Class superClass = [NSObject class];
            newClass = objc_allocateClassPair(superClass, className, 0);
            
            objc_registerClassPair(newClass);
        }
       
        id instance = [[newClass alloc] init];
        
        [instance setValue:@"1" forKey:@"isTourist"];
        
        
        BaseNavigationController *base = [[BaseNavigationController alloc]initWithRootViewController:instance];
        
        [self presentViewController:base animated:YES completion:nil];
        
        
    }
    else{
        
        [self myPushViewController:vc animated:animated];
    }

}

@end
