//
//  NSObject+ZKVOBlocks.h
//  Pods
//
//  Created by zwx on 2017/11/20.
//
// This class is based on NSObject+KVOBlocks (MIT licensed) by Stephan Leroux.
// See here: https://github.com/sleroux/KVO-Blocks

#import <Foundation/Foundation.h>
typedef void (^ZKVOBlock)(NSDictionary *change, void *context);

@interface NSObject (ZKVOBlock)

- (void)z_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context
             withBlock:(ZKVOBlock)block;

-(void)z_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath;

-(void)z_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(ZKVOBlock)block;

-(void)z_removeBlockObserverForKeyPath:(NSString *)keyPath;

@end
