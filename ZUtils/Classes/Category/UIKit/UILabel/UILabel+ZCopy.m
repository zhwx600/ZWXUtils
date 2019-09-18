//
//  UILabel+ZCopy.m
//  ZUtils
//
//  Created by zwx on 2017/11/24.
//

#import "UILabel+ZCopy.h"
#import <objc/runtime.h>

@interface UILabel ()

@property (nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;

@end

@implementation UILabel (ZCopy)

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return self.z_copyingEnabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    // Only return YES for the copy: action AND the copyingEnabled property is YES.
    return (action == @selector(copy:) && self.z_copyingEnabled);
}

- (void)copy:(id)sender
{
    if(self.z_copyingEnabled)
    {
        // Copy the label text
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.text];
    }
}

#pragma mark - UI Actions

- (void) longPressGestureRecognized:(UIGestureRecognizer *) gestureRecognizer
{
    if (gestureRecognizer == self.longPressGestureRecognizer)
    {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        {
            [self becomeFirstResponder];
            
            UIMenuController *copyMenu = [UIMenuController sharedMenuController];
            [copyMenu setTargetRect:self.bounds inView:self];
            copyMenu.arrowDirection = UIMenuControllerArrowDefault;
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}

#pragma mark - Properties

- (BOOL)z_copyingEnabled
{
    return [objc_getAssociatedObject(self, @selector(z_copyingEnabled)) boolValue];
}

- (void)setZ_copyingEnabled:(BOOL)copyingEnabled
{
    if(self.z_copyingEnabled != copyingEnabled)
    {
        objc_setAssociatedObject(self, @selector(z_copyingEnabled), @(copyingEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setupGestureRecognizers];
    }
}

- (UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    return objc_getAssociatedObject(self, @selector(longPressGestureRecognizer));
}

- (void)setLongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    objc_setAssociatedObject(self, @selector(longPressGestureRecognizer), longPressGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)z_shouldUseLongPressGestureRecognizer
{
    NSNumber *value = objc_getAssociatedObject(self, @selector(z_shouldUseLongPressGestureRecognizer));
    if(value == nil) {
        // Set the default value
        value = @YES;
        objc_setAssociatedObject(self, @selector(z_shouldUseLongPressGestureRecognizer), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return [value boolValue];
}

- (void)setZ_shouldUseLongPressGestureRecognizer:(BOOL)useGestureRecognizer
{
    if(self.z_shouldUseLongPressGestureRecognizer != useGestureRecognizer)
    {
        objc_setAssociatedObject(self, @selector(z_shouldUseLongPressGestureRecognizer), @(useGestureRecognizer), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setupGestureRecognizers];
    }
}

#pragma mark - Private Methods

- (void) setupGestureRecognizers
{
    // Remove gesture recognizer
    if(self.longPressGestureRecognizer) {
        [self removeGestureRecognizer:self.longPressGestureRecognizer];
        self.longPressGestureRecognizer = nil;
    }
    
    if(self.z_shouldUseLongPressGestureRecognizer && self.z_copyingEnabled) {
        self.userInteractionEnabled = YES;
        // Enable gesture recognizer
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self addGestureRecognizer:self.longPressGestureRecognizer];
    }
}

@end
