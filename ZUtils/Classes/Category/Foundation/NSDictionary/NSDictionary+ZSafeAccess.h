//
//  NSDictionary+ZSafeAccess.h
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


/**
 安全访问字典
 */
@interface NSDictionary (ZSafeAccess)
- (BOOL)z_hasKey:(NSString *)key;

- (NSString*)z_stringForKey:(id)key;

- (NSNumber*)z_numberForKey:(id)key;

- (NSDecimalNumber *)z_decimalNumberForKey:(id)key;

- (NSArray*)z_arrayForKey:(id)key;

- (NSDictionary*)z_dictionaryForKey:(id)key;

- (NSInteger)z_integerForKey:(id)key;

- (NSUInteger)z_unsignedIntegerForKey:(id)key;

- (BOOL)z_boolForKey:(id)key;

- (int16_t)z_int16ForKey:(id)key;

- (int32_t)z_int32ForKey:(id)key;

- (int64_t)z_int64ForKey:(id)key;

- (char)z_charForKey:(id)key;

- (short)z_shortForKey:(id)key;

- (float)z_floatForKey:(id)key;

- (double)z_doubleForKey:(id)key;

- (long long)z_longLongForKey:(id)key;

- (unsigned long long)z_unsignedLongLongForKey:(id)key;

- (NSDate *)z_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)z_CGFloatForKey:(id)key;

- (CGPoint)z_pointForKey:(id)key;

- (CGSize)z_sizeForKey:(id)key;

- (CGRect)z_rectForKey:(id)key;
@end

/**
 安全操作字典方式
 */
#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(ZZSafeAccess)

-(void)z_setObj:(id)i forKey:(NSString*)key;

-(void)z_setString:(NSString*)i forKey:(NSString*)key;

-(void)z_setBool:(BOOL)i forKey:(NSString*)key;

-(void)z_setInt:(int)i forKey:(NSString*)key;

-(void)z_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)z_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)z_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)z_setChar:(char)c forKey:(NSString*)key;

-(void)z_setFloat:(float)i forKey:(NSString*)key;

-(void)z_setDouble:(double)i forKey:(NSString*)key;

-(void)z_setLongLong:(long long)i forKey:(NSString*)key;

-(void)z_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)z_setSize:(CGSize)o forKey:(NSString*)key;

-(void)z_setRect:(CGRect)o forKey:(NSString*)key;
@end
