//
//  TDOperation.m
//  自定义NSOperation
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "TDOperation.h"

@implementation TDOperation
//需要执行的任务
- (void)main {
  for (NSInteger i = 0; i < 3; i++) {
    NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
  }
  // 人为的判断是否执行取消操作，如果执行取消操作，就直接 return 不往下执行
  if (self.isCancelled)
    return;

  for (NSInteger i = 0; i < 3; i++) {
    NSLog(@"download2 -%zd-- %@", i, [NSThread currentThread]);
  }
  // 人为的判断是否执行取消操作，如果执行取消操作，就直接 return 不往下执行
  if (self.isCancelled)
    return;

  for (NSInteger i = 0; i < 3; i++) {
    NSLog(@"download3 -%zd-- %@", i, [NSThread currentThread]);
  }
  // 人为的判断是否执行取消操作，如果执行取消操作，就直接 return 不往下执行
  if (self.isCancelled)
    return;
}
@end
