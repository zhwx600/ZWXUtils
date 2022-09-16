//
//  ZViewOneController.m
//  ZWXUtils_Example
//
//  Created by zwx on 2022/9/16.
//  Copyright © 2022 zhwx600. All rights reserved.
//

#import "ZViewOneController.h"
#import "ZViewTwoController.h"


@interface ZViewOneController ()

@end

@implementation ZViewOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIView* tView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    tView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:tView];

    WS(weakSelf)
    [tView z_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
    
        [ZProgressHUD makeToast:@"111111"];
        
        [weakSelf showTwoVC];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) showTwoVC
{
    ZViewTwoController* twovc = [[ZViewTwoController alloc] init];
    [self.navigationController pushViewController:twovc animated:YES];
}

@end
