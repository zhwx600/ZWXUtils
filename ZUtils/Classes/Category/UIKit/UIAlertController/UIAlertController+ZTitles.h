//
//  UIAlertController+ZTitles.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (ZTitles)

- (void)configTitles: (NSArray *)titles withActionHandlers:(NSArray *)actionHandlers;

@end

//Y用法
//self.alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//NSArray *titles = @[@"保存", @"保存222", @"123", @"取消"];
//NSArray *actionHandles = @[
//
//                           ^(UIAlertAction *action){
//                               NSLog(@"1");
//                           },
//
//                            ^(UIAlertAction *action){
//                                NSLog(@"2");
//                            },
//
//                            ^(UIAlertAction *action){
//                                NSLog(@"3");
//                            },
//
//                            ^(UIAlertAction *action){
//                                NSLog(@"取消");
//                            }
//                            ];
//
//
//[self.alertVC configTitles:titles withActionHandlers:actionHandles];

