//
//  ZViewTwoController.m
//  ZWXUtils_Example
//
//  Created by zwx on 2022/9/16.
//  Copyright © 2022 zhwx600. All rights reserved.
//

#import "ZViewTwoController.h"

@interface ZViewTwoController ()

@end

@implementation ZViewTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    //导航栏高度 固定为 44
    ZLLog(@"--%f-----*4",self.navigationController.navigationBar.frame.size.height);
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
