//
//  TDApp.h
//  多图下载
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDApp : NSObject

@property(nonatomic, strong) NSString *icon;     // 图片
@property(nonatomic, strong) NSString *download; //下载量
@property(nonatomic, strong) NSString *name;     // 名字

+ (instancetype)appWithDict:(NSDictionary *)dict;

@end
