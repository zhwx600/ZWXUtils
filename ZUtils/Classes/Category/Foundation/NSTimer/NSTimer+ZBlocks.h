//
//  NSTimer+ZBlocks.h
//  Pods
//
//  Created by zwx on 2017/11/24.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ZBlocks)
+(id) z_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;
+(id) z_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;
@end
