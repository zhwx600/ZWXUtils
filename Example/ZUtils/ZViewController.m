//
//  ZViewController.m
//  ZUtils
//
//  Created by zhwx600 on 11/16/2017.
//  Copyright (c) 2017 zhwx600. All rights reserved.
//

#import "ZViewController.h"
#import "UILabel+ZStrike.h"

#import "ZViewOneController.h"


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
    
    BOOL isfull = IS_FULL_SCREEN;
    
    
    [self.o_testLabel z_setStrikeColor:[UIColor grayColor]];
    
    
    UIView* tView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    tView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:tView];

    WS(weakSelf)
    [tView z_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
    
        [ZProgressHUD makeToast:@"111111"];
        
        [weakSelf showOneVC];
    }];
    
    
    [[AFHttpClient sharedClient] getUrl:@"https://api.apiopen.top/getAllUrl" param:nil header:nil success:^(id json) {
        
        ZLLog(@"234234%@",@"haha");
        
    } failure:^(NSError *error) {
        
    } processView:self.view];
    
}


-(void) showOneVC
{
    ZViewOneController* onevc = [[ZViewOneController alloc] init];
    
    UINavigationController* navvc = [[UINavigationController alloc] initWithRootViewController:onevc];
    navvc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navvc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
