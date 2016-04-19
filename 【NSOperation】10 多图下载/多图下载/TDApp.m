//
//  TDApp.m
//  多图下载
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "TDApp.h"

@implementation TDApp

+ (instancetype)appWithDict:(NSDictionary *)dict {
  TDApp *app = [[self alloc] init];
  [app setValuesForKeysWithDictionary:dict];
  return app;
}

@end
