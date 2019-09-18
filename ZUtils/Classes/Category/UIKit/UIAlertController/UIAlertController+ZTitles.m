//
//  UIAlertController+ZTitles.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIAlertController+ZTitles.h"
#import <objc/runtime.h>

static void * containerViewPorpertyKey = (void *)@"containerViewPorpertyKey";

CGFloat padding = 10;
CGFloat itemHeight = 57;
CGFloat lineHeight = 0.5;
CGFloat itemCount = 2;

@interface UIAlertController ()

@property (nonatomic, retain) UIView *containerView;

@end

@implementation UIAlertController (ZTitles)

- (id)containerView // containerView
{
    return objc_getAssociatedObject(self, containerViewPorpertyKey);
}

- (void)setContainerView:(id)containerView
{
    objc_setAssociatedObject(self, containerViewPorpertyKey, containerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)configTitles: (NSArray *)titles withActionHandlers:(NSArray *)actionHandlers{
    
    // 视图
    CGFloat alertVCWidth = self.view.frame.size.width - 2 * padding;
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertVCWidth, itemHeight*itemCount + (itemCount-1)*lineHeight)];
    [self.view addSubview: self.containerView];
    
    // x          y             w                            h
    // padding    0             alertVCWidth - 2 * padding,  h
    // padding    (h+lineH)*1   alertVCWidth - 2 * padding,  h
    // padding    (h+lineH)*2   alertVCWidth - 2 * padding,  h
    
    if (titles.count-1 > 0) {
        for (int i = 0; i< titles.count-1; i++) {
            
            UILabel *l = [[UILabel alloc] init];
            l.frame = CGRectMake(padding, (itemHeight+lineHeight)*i, alertVCWidth - 2 * padding, itemHeight);
            l.backgroundColor = [UIColor clearColor];
            l.text = titles[i];
            l.font = [UIFont systemFontOfSize:30];
            l.textAlignment = NSTextAlignmentCenter;
            l.textColor = [UIColor blackColor];
            l.userInteractionEnabled = false;
            [self.containerView addSubview: l];
        }
    }
    
    
    // actions
    if (actionHandlers.count-1 > 0) {
        for (int i = 0; i< actionHandlers.count-1; i++) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler: actionHandlers[i]];
            [self addAction: action];
        }
    }
    
    // 取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:titles[titles.count-1] style:UIAlertActionStyleCancel handler: actionHandlers[actionHandlers.count-1]];
    [self addAction:cancelAction];
    
}

@end

