//
//  UILabel+ZStrike.m
//  Pods
//
//  Created by zwx on 2017/11/24.
//

#import "UILabel+ZStrike.h"

@implementation UILabel (ZStrike)

-(void) z_setStrikeColor:(UIColor*)color
{
    NSAttributedString* attrStr = [[NSAttributedString alloc]initWithString:self.text attributes:@{NSStrikethroughColorAttributeName:color,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}];
    
    self.attributedText=attrStr;
}

@end
