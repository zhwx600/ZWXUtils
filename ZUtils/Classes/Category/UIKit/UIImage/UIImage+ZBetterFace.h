//
//  UIImage+ZBetterFace.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZAccuracy) {
    ZAccuracyLow = 0,
    ZAccuracyHigh,
};

@interface UIImage (ZBetterFace)

- (UIImage *)z_betterFaceImageForSize:(CGSize)size
                              accuracy:(ZAccuracy)accurary;

@end
