//
//  NSArray+ZSafeAccess.h
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 安全访问的方式
 */
@interface NSArray (ZSafeAccess)

-(id)z_objectWithIndex:(NSUInteger)index;

- (NSString*)z_stringWithIndex:(NSUInteger)index;

- (NSNumber*)z_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)z_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)z_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)z_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)z_integerWithIndex:(NSUInteger)index;

- (NSUInteger)z_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)z_boolWithIndex:(NSUInteger)index;

- (int16_t)z_int16WithIndex:(NSUInteger)index;

- (int32_t)z_int32WithIndex:(NSUInteger)index;

- (int64_t)z_int64WithIndex:(NSUInteger)index;

- (char)z_charWithIndex:(NSUInteger)index;

- (short)z_shortWithIndex:(NSUInteger)index;

- (float)z_floatWithIndex:(NSUInteger)index;

- (double)z_doubleWithIndex:(NSUInteger)index;

- (NSDate *)z_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)z_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)z_pointWithIndex:(NSUInteger)index;

- (CGSize)z_sizeWithIndex:(NSUInteger)index;

- (CGRect)z_rectWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

/**
 安全操作数组方式
 */
@interface NSMutableArray(ZSafeAccess)

-(void)z_addObj:(id)i;

-(void)z_addString:(NSString*)i;

-(void)z_addBool:(BOOL)i;

-(void)z_addInt:(int)i;

-(void)z_addInteger:(NSInteger)i;

-(void)z_addUnsignedInteger:(NSUInteger)i;

-(void)z_addCGFloat:(CGFloat)f;

-(void)z_addChar:(char)c;

-(void)z_addFloat:(float)i;

-(void)z_addPoint:(CGPoint)o;

-(void)z_addSize:(CGSize)o;

-(void)z_addRect:(CGRect)o;
@end
