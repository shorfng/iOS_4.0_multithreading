//
//  ViewController.m
//  异步串行
//
//  Created by 蓝田 on 16/3/19.
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
  [self serialAsyncDemo];
}

#pragma mark - 异步函数 + 串行队列：会开启新的线程，在子线程执行任务，任务是串行的（顺序执行），只开一条线程
- (void)asyncSerial {
  NSLog(@"异步串行 ----- begin");
  NSLog(@"主线程   ----- %@", [NSThread mainThread]);

  // 1.创建串行队列
  //写法1：
  dispatch_queue_t queue = dispatch_queue_create("TD", DISPATCH_QUEUE_SERIAL);
  //写法2：
//  dispatch_queue_t queue = dispatch_queue_create("TD", NULL);

  // 2.将任务加入队列
  dispatch_async(queue, ^{
    NSLog(@"1-----%@", [NSThread currentThread]);
  });
  dispatch_async(queue, ^{
    NSLog(@"2-----%@", [NSThread currentThread]);
  });
  dispatch_async(queue, ^{
    NSLog(@"3-----%@", [NSThread currentThread]);
  });

  NSLog(@"异步串行 ----- end");
}

#pragma mark - 写法2
- (void)serialAsyncDemo {
  // 1.创建队列
  dispatch_queue_t serialQueue =
      dispatch_queue_create("TD", DISPATCH_QUEUE_SERIAL);

  // 2.创建任务
  void (^task1)() = ^() {
    NSLog(@"task1---%@", [NSThread currentThread]);
  };

  void (^task2)() = ^() {
    NSLog(@"task2---%@", [NSThread currentThread]);
  };

  void (^task3)() = ^() {
    NSLog(@"task3---%@", [NSThread currentThread]);
  };

  // 3.将异步任务添加到串行队列
  dispatch_async(serialQueue, task1);
  dispatch_async(serialQueue, task2);
  dispatch_async(serialQueue, task3);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
