//
//  NSObject+ZRuntime.h
//  Pods
//
//  Created by zwx on 2017/11/20.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZRuntime)

/**
 Exchange methods' implementations.
 
 @param originalMethod Method to exchange.
 @param newMethod Method to exchange.
 */
+ (void)z_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

/**
 Append a new method to an object.
 
 @param newMethod Method to exchange.
 @param klass Host class.
 */
+ (void)z_appendMethod:(SEL)newMethod fromClass:(Class)klass;

/**
 Replace a method in an object.
 
 @param method Method to exchange.
 @param klass Host class.
 */
+ (void)z_replaceMethod:(SEL)method fromClass:(Class)klass;

@end
