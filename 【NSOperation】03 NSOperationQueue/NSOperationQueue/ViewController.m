//
//  ViewController.m
//  NSOperationQueue
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self operationQueue2];
}

#pragma mark - 把操作添加到队列中,方式1：addOperation
- (void)operationQueue1 {
  // 1.创建队列
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];

  // 2.1 方式1：创建操作（任务）NSInvocationOperation ，封装操作
  NSInvocationOperation *op1 =
      [[NSInvocationOperation alloc] initWithTarget:self
                                           selector:@selector(download1)
                                             object:nil];

  // 2.2 方式2：创建NSBlockOperation ，封装操作
  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"download2 --- %@", [NSThread currentThread]);
  }];

  // 添加操作
  [op2 addExecutionBlock:^{
    NSLog(@"download3 --- %@", [NSThread currentThread]);
  }];

  // 3.把操作（任务）添加到队列中，并自动调用 start 方法
  [queue addOperation:op1];
  [queue addOperation:op2];
}

- (void)download1 {
  NSLog(@"download1 --- %@", [NSThread currentThread]);
}

#pragma mark - 把操作添加到队列中,方式2：addOperationWithBlock
- (void)operationQueue2 {
  // 1.创建队列
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];

  // 2.添加操作到队列中
  [queue addOperationWithBlock:^{
    NSLog(@"download1 --- %@", [NSThread currentThread]);
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"download2 --- %@", [NSThread currentThread]);
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
