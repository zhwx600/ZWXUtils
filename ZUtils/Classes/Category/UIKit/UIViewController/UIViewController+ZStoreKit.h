//
//  UIViewController+ZStoreKit.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

#define affiliateToken @"10laQX"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (ZStoreKit)

@property NSString *z_campaignToken;
@property (nonatomic, copy) void (^z_loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^z_loadedStoreKitItemBlock)(void);

//弹窗 购买商品页面
- (void)z_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

//生成 跳转appstore 的url
+ (NSURL*)z_appURLForIdentifier:(NSInteger)identifier;

//打开appstore 的url
+ (void)z_openAppURLForIdentifier:(NSInteger)identifier;
//打开appstore 的url(预览页)
+ (void)z_openAppReviewURLForIdentifier:(NSInteger)identifier;

//判断url 是否包含 itunes
+ (BOOL)z_containsITunesURLString:(NSString*)URLString;
//从Url 获取id
+ (NSInteger)z_IDFromITunesURL:(NSString*)URLString;

@end
