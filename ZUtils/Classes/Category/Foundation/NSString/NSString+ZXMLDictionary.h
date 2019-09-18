//
//  NSString+ZXMLDictionary.h
//  Pods
//
//  Created by zwx on 2017/11/21.
//

#import <Foundation/Foundation.h>


/*
 
 #import "NSString+XMLDictionary.h"
 
 ...
 
 NSString *XMLString = @"<test>data</test>";
 NSDictionary *XMLAsDictionary = [XMLString XMLDictionary];
 
 */

//https://github.com/AndrewHydeJr/NSString-XML

@interface NSString (ZXMLDictionary)
/**
 *  @brief  xml字符串转换成NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *)z_XMLDictionary;
@end
