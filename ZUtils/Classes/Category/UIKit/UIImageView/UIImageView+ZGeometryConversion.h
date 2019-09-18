//
//  UIImageView+ZGeometryConversion.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZGeometryConversion)
- (CGPoint)z_convertPointFromImage:(CGPoint)imagePoint;
- (CGRect)z_convertRectFromImage:(CGRect)imageRect;

- (CGPoint)z_convertPointFromView:(CGPoint)viewPoint;
- (CGRect)z_convertRectFromView:(CGRect)viewRect;
@end
