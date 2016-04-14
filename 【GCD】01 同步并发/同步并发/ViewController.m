//
//  ViewController.m
//  同步并发
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
  [self concurrentSync];
}

#pragma mark - 同步函数 + 并发队列：不会开启新的线程，在当前线程执行任务（主线程），顺序执行，并发队列失去了并发的功能
- (void)syncConcurrent {
  NSLog(@"同步并发 ----- begin");

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

  NSLog(@"同步并发 ----- end");
}

#pragma mark - 写法2
- (void)concurrentSync {
  // 1. 创建并发队列
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

  // 3. 将同步任务添加到并发队列中
  dispatch_sync(conCurrentQueue, task1);
  dispatch_sync(conCurrentQueue, task2);
  dispatch_sync(conCurrentQueue, task3);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
