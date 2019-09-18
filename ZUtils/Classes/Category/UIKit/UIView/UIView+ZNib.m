//
//  UIView+ZNib.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIView+ZNib.h"

@implementation UIView (ZNib)

/**
 *  自动从xib创建视图
 */
+(instancetype)z_viewFromXIB{
    
    NSString *name=NSStringFromClass(self);
    
    UIView *xibView = nil;
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            xibView = object;
            break;
        }
    }
    if(xibView==nil){
        NSLog(@"从xib创建视图失败，当前类是：%@",name);
    }
    return xibView;
}


#pragma mark - Nibs
+ (UINib *)z_loadNib
{
    return [self z_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)z_loadNibNamed:(NSString*)nibName
{
    return [self z_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)z_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)z_loadInstanceFromNib
{
    return [self z_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)z_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self z_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)z_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self z_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)z_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}
@end
