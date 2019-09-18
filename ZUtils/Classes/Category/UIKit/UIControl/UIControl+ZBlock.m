//
//  UIControl+ZBlock.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UIControl+ZBlock.h"
#import <objc/runtime.h>


// UIControlEventTouchDown           = 1 <<  0,      // on all touch downs
// UIControlEventTouchDownRepeat     = 1 <<  1,      // on multiple touchdowns
// (tap count > 1)
// UIControlEventTouchDragInside     = 1 <<  2,
// UIControlEventTouchDragOutside    = 1 <<  3,
// UIControlEventTouchDragEnter      = 1 <<  4,
// UIControlEventTouchDragExit       = 1 <<  5,
// UIControlEventTouchUpInside       = 1 <<  6,
// UIControlEventTouchUpOutside      = 1 <<  7,
// UIControlEventTouchCancel         = 1 <<  8,
//
// UIControlEventValueChanged        = 1 << 12,     // sliders, etc.
//
// UIControlEventEditingDidBegin     = 1 << 16,     // UITextField
// UIControlEventEditingChanged      = 1 << 17,
// UIControlEventEditingDidEnd       = 1 << 18,
// UIControlEventEditingDidEndOnExit = 1 << 19,     // 'return key' ending
// editing
//
// UIControlEventAllTouchEvents      = 0x00000FFF,  // for touch events
// UIControlEventAllEditingEvents    = 0x000F0000,  // for UITextField
// UIControlEventApplicationReserved = 0x0F000000,  // range available for
// application use
// UIControlEventSystemReserved      = 0xF0000000,  // range reserved for
// internal framework use
// UIControlEventAllEvents           = 0xFFFFFFFF

#define z_UICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void (^)(id))eventBlock {                              \
objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
[self addTarget:self                                                        \
action:@selector(methodName##Action:)                                       \
forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
void (^block)(id) = objc_getAssociatedObject(self, @selector(methodName:));  \
if (block) {                                                                \
block(sender);                                                                \
}                                                                           \
}


@interface UIControl ()

@end

@implementation UIControl (ZBlock)

z_UICONTROL_EVENT(z_touchDown, TouchDown)
z_UICONTROL_EVENT(z_touchDownRepeat, TouchDownRepeat)
z_UICONTROL_EVENT(z_touchDragInside, TouchDragInside)
z_UICONTROL_EVENT(z_touchDragOutside, TouchDragOutside)
z_UICONTROL_EVENT(z_touchDragEnter, TouchDragEnter)
z_UICONTROL_EVENT(z_touchDragExit, TouchDragExit)
z_UICONTROL_EVENT(z_touchUpInside, TouchUpInside)
z_UICONTROL_EVENT(z_touchUpOutside, TouchUpOutside)
z_UICONTROL_EVENT(z_touchCancel, TouchCancel)
z_UICONTROL_EVENT(z_valueChanged, ValueChanged)
z_UICONTROL_EVENT(z_editingDidBegin, EditingDidBegin)
z_UICONTROL_EVENT(z_editingChanged, EditingChanged)
z_UICONTROL_EVENT(z_editingDidEnd, EditingDidEnd)
z_UICONTROL_EVENT(z_editingDidEndOnExit, EditingDidEndOnExit)

//- (void)touchUpInside:(void (^)(id))eventBlock {
//   objc_setAssociatedObject(self, @selector(touchUpInside:, eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//  [self addTarget:self action:@selector(touchUpInsideAction:)
//  forControlEvents:UIControlEventTouchUpInside];
//}
//- (void)touchUpInsideAction:(id)sender {
//  void (^block)(id) = objc_getAssociatedObject(self, @selector(touchUpInsideAction:));
//  if (block) {
//    block(sender);
//  }
//}

@end

