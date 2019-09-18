//
//  UIButton+ZBadge.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZBadge)
@property (strong, nonatomic) UILabel *z_badge;

// Badge value to be display
@property (nonatomic) NSString *z_badgeValue;
// Badge background color
@property (nonatomic) UIColor *z_badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *z_badgeTextColor;
// Badge font
@property (nonatomic) UIFont *z_badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat z_badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat z_badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat z_badgeOriginX;
@property (nonatomic) CGFloat z_badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL z_shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL z_shouldAnimateBadge;
@end
