//
//  UIImageView+ZBetterFace.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIImageView+ZBetterFace.h"
#import <objc/runtime.h>
#define BETTER_LAYER_NAME @"BETTER_LAYER_NAME"
#define GOLDEN_RATIO (0.618)

#ifdef BF_DEBUG
#define BFLog(format...) NSLog(format)
#else
#define BFLog(format...)
#endif

static CIDetector *z_detector;

@implementation UIImageView (ZBetterFace)

void z_hack_uiimageview_bf(){
    Method oriSetImgMethod = class_getInstanceMethod([UIImageView class], @selector(setImage:));
    Method newSetImgMethod = class_getInstanceMethod([UIImageView class], @selector(z_setBetterFaceImage:));
    method_exchangeImplementations(newSetImgMethod, oriSetImgMethod);
}

- (void)z_setBetterFaceImage:(UIImage *)image{
    [self z_setBetterFaceImage:image];
    if (![self z_needsBetterFace]) {
        return;
    }
    
    [self z_faceDetect:image];
}

char nbfKey;
- (void)setZ_needsBetterFace:(BOOL)needsBetterFace{
    objc_setAssociatedObject(self,
                             &nbfKey,
                             [NSNumber numberWithBool:needsBetterFace],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)z_needsBetterFace{
    NSNumber *associatedObject = objc_getAssociatedObject(self, &nbfKey);
    return [associatedObject boolValue];
}

char fastSpeedKey;
- (void)setZ_fast:(BOOL)fast{
    objc_setAssociatedObject(self,
                             &fastSpeedKey,
                             [NSNumber numberWithBool:fast],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

char detectorKey;
- (void)setZ_detector:(CIDetector *)detector{
    objc_setAssociatedObject(self,
                             &detectorKey,
                             detector,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CIDetector *)z_detector{
    return objc_getAssociatedObject(self, &detectorKey);
}

- (BOOL)z_fast{
    NSNumber *associatedObject = objc_getAssociatedObject(self, &fastSpeedKey);
    return [associatedObject boolValue];
}

- (void)z_faceDetect:(UIImage *)aImage
{
    dispatch_queue_t queue = dispatch_queue_create("com.croath.betterface.queue", NULL);
    dispatch_async(queue, ^{
        CIImage* image = aImage.CIImage;
        if (image == nil) { // just in case the UIImage was created using a CGImage revert to the previous, slower implementation
            image = [CIImage imageWithCGImage:aImage.CGImage];
        }
        if (z_detector == nil) {
            NSDictionary  *opts = [NSDictionary dictionaryWithObject:[self z_fast] ? CIDetectorAccuracyLow : CIDetectorAccuracyHigh
                                                              forKey:CIDetectorAccuracy];
            z_detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                             context:nil
                                             options:opts];
        }
        
        NSArray* features = [z_detector featuresInImage:image];
        
        if ([features count] == 0) {
            BFLog(@"no faces");
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self z_imageLayer] removeFromSuperlayer];
            });
        } else {
            BFLog(@"succeed %lu faces", (unsigned long)[features count]);
            [self z_markAfterFaceDetect:features
                                    size:CGSizeMake(CGImageGetWidth(aImage.CGImage),
                                                    CGImageGetHeight(aImage.CGImage))];
        }
    });
}

-(void)z_markAfterFaceDetect:(NSArray *)features size:(CGSize)size{
    CGRect fixedRect = CGRectMake(MAXFLOAT, MAXFLOAT, 0, 0);
    CGFloat rightBorder = 0, bottomBorder = 0;
    for (CIFaceFeature *f in features){
        CGRect oneRect = f.bounds;
        oneRect.origin.y = size.height - oneRect.origin.y - oneRect.size.height;
        
        fixedRect.origin.x = MIN(oneRect.origin.x, fixedRect.origin.x);
        fixedRect.origin.y = MIN(oneRect.origin.y, fixedRect.origin.y);
        
        rightBorder = MAX(oneRect.origin.x + oneRect.size.width, rightBorder);
        bottomBorder = MAX(oneRect.origin.y + oneRect.size.height, bottomBorder);
    }
    
    fixedRect.size.width = rightBorder - fixedRect.origin.x;
    fixedRect.size.height = bottomBorder - fixedRect.origin.y;
    
    CGPoint fixedCenter = CGPointMake(fixedRect.origin.x + fixedRect.size.width / 2.0,
                                      fixedRect.origin.y + fixedRect.size.height / 2.0);
    CGPoint offset = CGPointZero;
    CGSize finalSize = size;
    if (size.width / size.height > self.bounds.size.width / self.bounds.size.height) {
        //move horizonal
        finalSize.height = self.bounds.size.height;
        finalSize.width = size.width/size.height * finalSize.height;
        fixedCenter.x = finalSize.width / size.width * fixedCenter.x;
        fixedCenter.y = finalSize.width / size.width * fixedCenter.y;
        
        offset.x = fixedCenter.x - self.bounds.size.width * 0.5;
        if (offset.x < 0) {
            offset.x = 0;
        } else if (offset.x + self.bounds.size.width > finalSize.width) {
            offset.x = finalSize.width - self.bounds.size.width;
        }
        offset.x = - offset.x;
    } else {
        //move vertical
        finalSize.width = self.bounds.size.width;
        finalSize.height = size.height/size.width * finalSize.width;
        fixedCenter.x = finalSize.width / size.width * fixedCenter.x;
        fixedCenter.y = finalSize.width / size.width * fixedCenter.y;
        
        offset.y = fixedCenter.y - self.bounds.size.height * (1-GOLDEN_RATIO);
        if (offset.y < 0) {
            offset.y = 0;
        } else if (offset.y + self.bounds.size.height > finalSize.height){
            offset.y = finalSize.height = self.bounds.size.height;
        }
        offset.y = - offset.y;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CALayer *layer = [self z_imageLayer];
        layer.frame = CGRectMake(offset.x,
                                 offset.y,
                                 finalSize.width,
                                 finalSize.height);
        layer.contents = (id)self.image.CGImage;
    });
}

- (CALayer *)z_imageLayer {
    for (CALayer *layer in [self.layer sublayers]) {
        if ([[layer name] isEqualToString:BETTER_LAYER_NAME]) {
            return layer;
        }
    }
    
    CALayer *layer = [CALayer layer];
    [layer setName:BETTER_LAYER_NAME];
    layer.actions = @{@"contents": [NSNull null],
                      @"bounds": [NSNull null],
                      @"position": [NSNull null]};
    [self.layer addSublayer:layer];
    return layer;
}

@end
