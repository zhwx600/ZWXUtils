//
//  NSObject+ZReflection.h
//  Pods
//
//  Created by zwx on 2017/11/20.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZReflection)
//类名
- (NSString *)z_className;
+ (NSString *)z_className;
//父类名称
- (NSString *)z_superClassName;
+ (NSString *)z_superClassName;

//实例属性字典
-(NSDictionary *)z_propertyDictionary;

//属性名称列表
- (NSArray*)z_propertyKeys;
+ (NSArray *)z_propertyKeys;

//属性详细信息列表
- (NSArray *)z_propertiesInfo;
+ (NSArray *)z_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)z_propertiesWithCodeFormat;

//方法列表
-(NSArray*)z_methodList;
+(NSArray*)z_methodList;

-(NSArray*)z_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)z_registedClassList;
//实例变量
+ (NSArray *)z_instanceVariable;

//协议列表
-(NSDictionary *)z_protocolList;
+ (NSDictionary *)z_protocolList;


- (BOOL)z_hasPropertyForKey:(NSString*)key;
- (BOOL)z_hasIvarForKey:(NSString*)key;
@end
