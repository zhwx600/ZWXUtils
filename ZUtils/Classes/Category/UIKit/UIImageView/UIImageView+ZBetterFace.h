//
//  UIImageView+ZBetterFace.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZBetterFace)
@property (nonatomic) BOOL z_needsBetterFace;
@property (nonatomic) BOOL z_fast;

void z_hack_uiimageview_bf(void);
- (void)z_setBetterFaceImage:(UIImage *)image;
@end
