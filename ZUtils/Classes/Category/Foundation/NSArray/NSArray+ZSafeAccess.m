//
//  NSArray+ZSafeAccess.m
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import "NSArray+ZSafeAccess.h"

@implementation NSArray (ZSafeAccess)
-(id)z_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (NSString*)z_stringWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}


- (NSNumber*)z_numberWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)z_decimalNumberWithIndex:(NSUInteger)index{
    id value = [self z_objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray*)z_arrayWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary*)z_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)z_integerWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)z_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)z_boolWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)z_int16WithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)z_int32WithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)z_int64WithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)z_charWithIndex:(NSUInteger)index{
    
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)z_shortWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)z_floatWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)z_doubleWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)z_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self z_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)z_CGFloatWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)z_pointWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)z_sizeWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)z_rectWithIndex:(NSUInteger)index
{
    id value = [self z_objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (JKSafeAccess)
-(void)z_addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)z_addString:(NSString*)i
{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)z_addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)z_addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)z_addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)z_addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)z_addCGFloat:(CGFloat)f
{
    [self addObject:@(f)];
}
-(void)z_addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)z_addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)z_addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)z_addSize:(CGSize)o
{
    [self addObject:NSStringFromCGSize(o)];
}
-(void)z_addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}
@end

