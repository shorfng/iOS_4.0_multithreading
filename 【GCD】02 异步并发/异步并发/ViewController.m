//
//  ViewController.m
//  异步并发
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
  [self concurrentAsync];
}

#pragma mark - 异步函数 + 并发队列：可以同时开启多条线程，在当前线程执行任务（主线程），无序执行（按照任务添加到队列中的顺序被调度），线程条数具体由`可调度线程池/底层线程池`来决定
- (void)asyncConcurrent {
  NSLog(@"异步并发 ----- begin");

  // 1.获得全局的并发队列
  dispatch_queue_t queue =
      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

  // 2.将任务加入队列
  dispatch_sync(queue, ^{
    NSLog(@"1-----%@", [NSThread currentThread]);
  });
  dispatch_sync(queue, ^{
    NSLog(@"2-----%@", [NSThread currentThread]);
  });
  dispatch_sync(queue, ^{
    NSLog(@"3-----%@", [NSThread currentThread]);
  });

  NSLog(@"异步并发 ----- begin");
}

- (void)concurrentAsync {
  // 1.创建并发队列
  dispatch_queue_t conCurrentQueue =
      dispatch_queue_create("TD", DISPATCH_QUEUE_CONCURRENT);
    
  // 2. 创建任务
  void (^task1)() = ^() {
    NSLog(@"---task1---%@", [NSThread currentThread]);
  };
    
  void (^task2)() = ^() {
    NSLog(@"---task2---%@", [NSThread currentThread]);
  };

  void (^task3)() = ^() {
    NSLog(@"---task3---%@", [NSThread currentThread]);
  };

  // 3. 将异步任务添加到并发队列中
  dispatch_async(conCurrentQueue, task1);
  dispatch_async(conCurrentQueue, task2);
  dispatch_async(conCurrentQueue, task3);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
