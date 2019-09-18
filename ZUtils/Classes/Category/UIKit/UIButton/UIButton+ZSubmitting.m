//
//  UIButton+ZSubmitting.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIButton+ZSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *z_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *z_spinnerView;
@property(nonatomic, strong) UILabel *z_spinnerTitleLabel;

@end

@implementation UIButton (ZSubmitting)

- (void)z_beginSubmitting:(NSString *)title {
    [self z_endSubmitting];
    
    self.z_submitting = @YES;
    self.hidden = YES;
    
    self.z_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.z_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.z_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.z_modalView.layer.borderWidth = self.layer.borderWidth;
    self.z_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.z_modalView.bounds;
    self.z_spinnerView = [[UIActivityIndicatorView alloc]
                           initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.z_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.z_spinnerView.bounds;
    self.z_spinnerView.frame = CGRectMake(
                                           15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                           spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.z_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.z_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.z_spinnerTitleLabel.text = title;
    self.z_spinnerTitleLabel.font = self.titleLabel.font;
    self.z_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.z_modalView addSubview:self.z_spinnerView];
    [self.z_modalView addSubview:self.z_spinnerTitleLabel];
    [self.superview addSubview:self.z_modalView];
    [self.z_spinnerView startAnimating];
}

- (void)z_endSubmitting {
    if (!self.isZSubmitting.boolValue) {
        return;
    }
    
    self.z_submitting = @NO;
    self.hidden = NO;
    
    [self.z_modalView removeFromSuperview];
    self.z_modalView = nil;
    self.z_spinnerView = nil;
    self.z_spinnerTitleLabel = nil;
}

- (NSNumber *)isZSubmitting {
    return objc_getAssociatedObject(self, @selector(setZ_submitting:));
}

- (void)setZ_submitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setZ_submitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIActivityIndicatorView *)z_spinnerView {
    return objc_getAssociatedObject(self, @selector(setZ_spinnerView:));
}

- (void)setZ_spinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setZ_spinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)z_modalView {
    return objc_getAssociatedObject(self, @selector(setZ_modalView:));
    
}

- (void)setZ_modalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setZ_modalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)z_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setZ_spinnerTitleLabel:));
}

- (void)setZ_spinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setZ_spinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
