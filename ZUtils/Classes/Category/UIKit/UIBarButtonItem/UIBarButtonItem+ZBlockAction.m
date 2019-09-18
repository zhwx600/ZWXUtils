//
//  UIBarButtonItem+ZBlockAction.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UIBarButtonItem+ZBlockAction.h"
#import <objc/runtime.h>

char * const UIBarButtonItemJKActionBlock = "UIBarButtonItemJKActionBlock";


@implementation UIBarButtonItem (ZBlockAction)

- (void)z_performActionBlock {
    
    dispatch_block_t block = self.z_actionBlock;
    
    if (block)
        block();
    
}

- (dispatch_block_t)z_actionBlock {
    return objc_getAssociatedObject(self, UIBarButtonItemJKActionBlock);
}

- (void)setZ_actionBlock:(dispatch_block_t)z_actionBlock
{
    
    if (z_actionBlock != self.z_actionBlock) {
        [self willChangeValueForKey:@"z_actionBlock"];
        
        objc_setAssociatedObject(self,
                                 UIBarButtonItemJKActionBlock,
                                 z_actionBlock,
                                 OBJC_ASSOCIATION_COPY);
        
        // Sets up the action.
        [self setTarget:self];
        [self setAction:@selector(z_performActionBlock)];
        
        [self didChangeValueForKey:@"z_actionBlock"];
    }
}
@end
