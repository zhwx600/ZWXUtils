//
//  UIBarButtonItem+ZBadge.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UIBarButtonItem+ZBadge.h"
#import <objc/runtime.h>

NSString const *z_UIBarButtonItem_badgeKey = @"z_UIBarButtonItem_badgeKey";

NSString const *z_UIBarButtonItem_badgeBGColorKey = @"z_UIBarButtonItem_badgeBGColorKey";
NSString const *z_UIBarButtonItem_badgeTextColorKey = @"z_UIBarButtonItem_badgeTextColorKey";
NSString const *z_UIBarButtonItem_badgeFontKey = @"z_UIBarButtonItem_badgeFontKey";
NSString const *z_UIBarButtonItem_badgePaddingKey = @"z_UIBarButtonItem_badgePaddingKey";
NSString const *z_UIBarButtonItem_badgeMinSizeKey = @"z_UIBarButtonItem_badgeMinSizeKey";
NSString const *z_UIBarButtonItem_badgeOriginXKey = @"z_UIBarButtonItem_badgeOriginXKey";
NSString const *z_UIBarButtonItem_badgeOriginYKey = @"z_UIBarButtonItem_badgeOriginYKey";
NSString const *z_UIBarButtonItem_shouldHideBadgeAtZeroKey = @"z_UIBarButtonItem_shouldHideBadgeAtZeroKey";
NSString const *z_UIBarButtonItem_shouldAnimateBadgeKey = @"z_UIBarButtonItem_shouldAnimateBadgeKey";
NSString const *z_UIBarButtonItem_badgeValueKey = @"z_UIBarButtonItem_badgeValueKey";

@implementation UIBarButtonItem (ZBadge)

@dynamic z_badgeValue, z_badgeBGColor, z_badgeTextColor, z_badgeFont;
@dynamic z_badgePadding, z_badgeMinSize, z_badgeOriginX, z_badgeOriginY;
@dynamic z_shouldHideBadgeAtZero, z_shouldAnimateBadge;

- (void)z_badgeInit
{
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width - self.z_badge.frame.size.width/2;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width - self.z_badge.frame.size.width;
    }
    [superview addSubview:self.z_badge];
    
    // Default design initialization
    self.z_badgeBGColor   = [UIColor redColor];
    self.z_badgeTextColor = [UIColor whiteColor];
    self.z_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.z_badgePadding   = 6;
    self.z_badgeMinSize   = 8;
    self.z_badgeOriginX   = defaultOriginX;
    self.z_badgeOriginY   = -4;
    self.z_shouldHideBadgeAtZero = YES;
    self.z_shouldAnimateBadge = YES;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)z_refreshBadge
{
    // Change new attributes
    self.z_badge.textColor        = self.z_badgeTextColor;
    self.z_badge.backgroundColor  = self.z_badgeBGColor;
    self.z_badge.font             = self.z_badgeFont;
    
    if (!self.z_badgeValue || [self.z_badgeValue isEqualToString:@""] || ([self.z_badgeValue isEqualToString:@"0"] && self.z_shouldHideBadgeAtZero)) {
        self.z_badge.hidden = YES;
    } else {
        self.z_badge.hidden = NO;
        [self z_updateBadgeValueAnimated:YES];
    }
    
}

- (CGSize)z_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self z_duplicateLabel:self.z_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)z_updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self z_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.z_badgeMinSize) ? self.z_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.z_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.z_badge.layer.masksToBounds = YES;
    self.z_badge.frame = CGRectMake(self.z_badgeOriginX, self.z_badgeOriginY, minWidth + padding, minHeight + padding);
    self.z_badge.layer.cornerRadius = (minHeight + padding) / 2;
}

// Handle the badge changing value
- (void)z_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.z_shouldAnimateBadge && ![self.z_badge.text isEqualToString:self.z_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.z_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.z_badge.text = self.z_badgeValue;
    
    // Animate the size modification if needed
    if (animated && self.z_shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self z_updateBadgeFrame];
        }];
    } else {
        [self z_updateBadgeFrame];
    }
}

- (UILabel *)z_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)z_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.z_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.z_badge removeFromSuperview];
        self.z_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)z_badge {
    UILabel* lbl = objc_getAssociatedObject(self, &z_UIBarButtonItem_badgeKey);
    if(lbl==nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.z_badgeOriginX, self.z_badgeOriginY, 20, 20)];
        [self setZ_badge:lbl];
        [self z_badgeInit];
        [self.customView addSubview:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    return lbl;
}
-(void)setZ_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)z_badgeValue {
    return objc_getAssociatedObject(self, &z_UIBarButtonItem_badgeValueKey);
}
-(void)setZ_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    [self z_updateBadgeValueAnimated:YES];
    [self z_refreshBadge];
}

// Badge background color
-(UIColor *)z_badgeBGColor {
    return objc_getAssociatedObject(self, &z_UIBarButtonItem_badgeBGColorKey);
}
-(void)setZ_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_refreshBadge];
    }
}

// Badge text color
-(UIColor *)z_badgeTextColor {
    return objc_getAssociatedObject(self, &z_UIBarButtonItem_badgeTextColorKey);
}
-(void)setZ_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_refreshBadge];
    }
}

// Badge font
-(UIFont *)z_badgeFont {
    return objc_getAssociatedObject(self, &z_UIBarButtonItem_badgeFontKey);
}
-(void)setZ_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) z_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIBarButtonItem_badgePaddingKey);
    return number.floatValue;
}
-(void) setZ_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat)z_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIBarButtonItem_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setZ_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat)z_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIBarButtonItem_badgeOriginXKey);
    return number.floatValue;
}
-(void) setZ_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_updateBadgeFrame];
    }
}

-(CGFloat)z_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIBarButtonItem_badgeOriginYKey);
    return number.floatValue;
}
-(void) setZ_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &z_UIBarButtonItem_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) z_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIBarButtonItem_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setZ_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &z_UIBarButtonItem_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.z_badge) {
        [self z_refreshBadge];
    }
}

// Badge has a bounce animation when value changes
-(BOOL) z_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIBarButtonItem_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setZ_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &z_UIBarButtonItem_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.z_badge) {
        [self z_refreshBadge];
    }
}


@end

