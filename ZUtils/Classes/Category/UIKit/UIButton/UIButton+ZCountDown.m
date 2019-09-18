//
//  UIButton+ZCountDown.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIButton+ZCountDown.h"

@implementation UIButton (ZCountDown)

-(void)z_startTime:(NSInteger )timeout title:(NSString *)title waitTFormat:(NSString *)format
{
    
    __block NSInteger timeOut=timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:title forState:UIControlStateNormal];
                self.enabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            NSInteger seconds = (NSInteger)timeOut;
            NSString *strTime = [NSString stringWithFormat:format, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [self setTitle:strTime forState:UIControlStateNormal];
                self.enabled = NO;
                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
    
}

@end
