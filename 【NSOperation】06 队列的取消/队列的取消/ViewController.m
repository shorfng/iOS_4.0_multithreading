//
//  ViewController.m
//  队列的取消
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

#pragma mark - 取消队列的所有操作
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  // 取消队列的所有操作（相等于调用了所有NSOperation的-(void)cancel方法）
  [self.queue cancelAllOperations];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
