//
//  ZViewController.m
//  ZUtils
//
//  Created by zhwx600 on 11/16/2017.
//  Copyright (c) 2017 zhwx600. All rights reserved.
//

#import "ZViewController.h"
#import "UILabel+ZStrike.h"


@interface ZViewController ()

@property (weak, nonatomic) IBOutlet UILabel *o_testLabel;
@end

@implementation ZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//    NSAttributedString*attrStr = [[NSAttributedString alloc]initWithString:self.o_testLabel.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor],NSStrikethroughColorAttributeName:[UIColor redColor],NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}];
//
//    self.o_testLabel.attributedText=attrStr;
    
    
    [self.o_testLabel z_setStrikeColor:[UIColor grayColor]];
    
    
    UIView* tView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    tView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:tView];

    [tView z_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
    
        [ZProgressHUD makeToast:@"111111"];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
