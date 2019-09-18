//
//  UIImage+ZGIF.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZGIF)
+ (UIImage *)z_animatedGIFNamed:(NSString *)name;

+ (UIImage *)z_animatedGIFWithData:(NSData *)data;

- (UIImage *)z_animatedImageByScalingAndCroppingToSize:(CGSize)size;
@end
