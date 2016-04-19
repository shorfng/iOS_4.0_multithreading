//
//  ViewController.m
//  队列的暂停和恢复
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) NSOperationQueue *queue; //队列
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // 1.创建队列
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];

  // 2.设置最大并发操作数(大并发操作数 = 1,就变成了串行队列)
  queue.maxConcurrentOperationCount = 1;

  // 3.添加操作
  [queue addOperationWithBlock:^{
    NSLog(@"download1 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:3];
  }];

  [queue addOperationWithBlock:^{
    NSLog(@"download2 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:3];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"download3 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:3];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"download4 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:3];
  }];

  self.queue = queue;
}

#pragma mark - 暂停和恢复
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if (self.queue.isSuspended) {
    self.queue.suspended = NO; // 恢复队列，继续执行
  } else {
    self.queue.suspended = YES; // 暂停（挂起）队列，暂停执行
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
