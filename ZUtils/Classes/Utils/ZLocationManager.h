//
//  ZLocationManager.h
//  PaixieMall
//
//  Created by zhwx on 15/1/8.
//  Copyright (c) 2015年 拍鞋网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class ZLocationManager;

@protocol ZLocationManagerDelegate <NSObject>

- (void)completionReverseGeocodeLocation:(ZLocationManager *)locationManager;
- (void)didFailWithError:(NSError *)error;

@end

@interface ZLocationManager : NSObject
@property (nonatomic, assign) id<ZLocationManagerDelegate> o_delegate;

//addressDictionary  地址信息的dictionary
//
//thoroughfare  指定街道级别信息
//
//subThoroughfare  指定街道级别的附加信息
//
//locality  指定城市信息(城市)
//
//subLocality  指定城市信息附加信息(地区)
//
//administrativeArea  行政区域(省份)
//
//subAdministrativeArea  行政区域附加信息
//
//country  国家信息
//
//countryCode  国家代号
//
//postalCode  邮政编码
@property (nonatomic,strong) CLPlacemark* o_placmark;
//新的经纬度
@property (nonatomic,strong) CLLocation* o_newLocation;

+(instancetype) sharedInstance;


-(void) startUpdateLocation;

-(void) stopUpdateLocation;

@end

