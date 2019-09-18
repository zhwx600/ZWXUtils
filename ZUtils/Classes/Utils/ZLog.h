//
//  ZLog.h
//  PaixieMall
//
//  Created by zhwx on 15/1/8.
//  Copyright (c) 2015年 拍鞋网. All rights reserved.
//

#ifndef PaixieMall_ZLog_h
#define PaixieMall_ZLog_h

#define NEED_OUTPUT_LOG                     1

#if NEED_OUTPUT_LOG

//普通打印
#define ZLog(format, ...)   NSLog(format, ##__VA_ARGS__)
//打印 行号 函数
#define ZLLog(format, ...)  NSLog(@"line:%d fun:%s\n" format, __LINE__,__PRETTY_FUNCTION__,  ##__VA_ARGS__)

//打印出 调用的文件名 行号 函数
#define ZFLLog(format, ...)  NSLog(@"%@ line:%d fun:%s\n" format,[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,__PRETTY_FUNCTION__,  ##__VA_ARGS__)


#define ZLLogRect(rect) \
ZLLog(@"%s x=%f, y=%f, w=%f, h=%f", #rect, rect.origin.x, rect.origin.y, \
rect.size.width, rect.size.height)


#define ZLLogPoint(pt) \
ZLLog(@"%s x=%f, y=%f", #pt, pt.x, pt.y)


#define ZLLogSize(size) \
ZLLog(@"%s w=%f, h=%f", #size, size.width, size.height)


#define ZLLogColor(_COLOR) \
ZLLog(@"%s h=%f, s=%f, v=%f", #_COLOR, _COLOR.hue, _COLOR.saturation, _COLOR.value)


#define ZLLogSuperViews(_VIEW) \
{ for (UIView* view = _VIEW; view; view = view.superview) { ZLLog(@"%@", view); } }


#define ZLLogSubViews(_VIEW) \
{ for (UIView* view in [_VIEW subviews]) { ZLLog(@"%@", view); } }


#else


#define SLog(format, ...)  ((void)0)
#define ZLLog(format, ...)  ((void)0)
#define ZFLLog(format, ...) ((void)0)

#endif



#endif
