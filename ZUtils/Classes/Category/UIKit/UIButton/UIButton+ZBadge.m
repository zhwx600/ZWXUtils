//
//  UIButton+ZBadge.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <objc/runtime.h>
#import "UIButton+ZBadge.h"


NSString const *z_UIButton_badgeKey = @"z_UIButton_badgeKey";

NSString const *z_UIButton_badgeBGColorKey = @"z_UIButton_badgeBGColorKey";
NSString const *z_UIButton_badgeTextColorKey = @"z_UIButton_badgeTextColorKey";
NSString const *z_UIButton_badgeFontKey = @"z_UIButton_badgeFontKey";
NSString const *z_UIButton_badgePaddingKey = @"z_UIButton_badgePaddingKey";
NSString const *z_UIButton_badgeMinSizeKey = @"z_UIButton_badgeMinSizeKey";
NSString const *z_UIButton_badgeOriginXKey = @"z_UIButton_badgeOriginXKey";
NSString const *z_UIButton_badgeOriginYKey = @"z_UIButton_badgeOriginYKey";
NSString const *z_UIButton_shouldHideBadgeAtZeroKey = @"z_UIButton_shouldHideBadgeAtZeroKey";
NSString const *z_UIButton_shouldAnimateBadgeKey = @"z_UIButton_shouldAnimateBadgeKey";
NSString const *z_UIButton_badgeValueKey = @"z_UIButton_badgeValueKey";

@implementation UIButton (ZBadge)

@dynamic z_badgeValue, z_badgeBGColor, z_badgeTextColor, z_badgeFont;
@dynamic z_badgePadding, z_badgeMinSize, z_badgeOriginX, z_badgeOriginY;
@dynamic z_shouldHideBadgeAtZero, z_shouldAnimateBadge;

- (void)z_badgeInit
{
    // Default design initialization
    self.z_badgeBGColor   = [UIColor redColor];
    self.z_badgeTextColor = [UIColor whiteColor];
    self.z_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.z_badgePadding   = 6;
    self.z_badgeMinSize   = 8;
    self.z_badgeOriginX   = self.frame.size.width - self.z_badge.frame.size.width/2;
    self.z_badgeOriginY   = -4;
    self.z_shouldHideBadgeAtZero = YES;
    self.z_shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)z_refreshBadge
{
    // Change new attributes
    self.z_badge.textColor        = self.z_badgeTextColor;
    self.z_badge.backgroundColor  = self.z_badgeBGColor;
    self.z_badge.font             = self.z_badgeFont;
}

- (CGSize) z_badgeExpectedSize
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
    self.z_badge.frame = CGRectMake(self.z_badgeOriginX, self.z_badgeOriginY, minWidth + padding, minHeight + padding);
    self.z_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.z_badge.layer.masksToBounds = YES;
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
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self z_updateBadgeFrame];
    }];
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
    return objc_getAssociatedObject(self, &z_UIButton_badgeKey);
}
-(void)setZ_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &z_UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)z_badgeValue {
    return objc_getAssociatedObject(self, &z_UIButton_badgeValueKey);
}
-(void) setZ_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &z_UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.z_shouldHideBadgeAtZero)) {
        [self z_removeBadge];
    } else if (!self.z_badge) {
        // Create a new badge because not existing
        self.z_badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.z_badgeOriginX, self.z_badgeOriginY, 20, 20)];
        self.z_badge.textColor            = self.z_badgeTextColor;
        self.z_badge.backgroundColor      = self.z_badgeBGColor;
        self.z_badge.font                 = self.z_badgeFont;
        self.z_badge.textAlignment        = NSTextAlignmentCenter;
        [self z_badgeInit];
        [self addSubview:self.z_badge];
        [self z_updateBadgeValueAnimated:NO];
    } else {
        [self z_updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)z_badgeBGColor {
    return objc_getAssociatedObject(self, &z_UIButton_badgeBGColorKey);
}
-(void)setZ_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &z_UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_refreshBadge];
    }
}

// Badge text color
-(UIColor *)z_badgeTextColor {
    return objc_getAssociatedObject(self, &z_UIButton_badgeTextColorKey);
}
-(void)setZ_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &z_UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_refreshBadge];
    }
}

// Badge font
-(UIFont *)z_badgeFont {
    return objc_getAssociatedObject(self, &z_UIButton_badgeFontKey);
}
-(void)setZ_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &z_UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) z_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void) setZ_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &z_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat) z_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setZ_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &z_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat) z_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void) setZ_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &z_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_updateBadgeFrame];
    }
}

-(CGFloat) z_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void) setZ_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &z_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.z_badge) {
        [self z_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) z_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setZ_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &z_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
-(BOOL) z_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &z_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setZ_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &z_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

