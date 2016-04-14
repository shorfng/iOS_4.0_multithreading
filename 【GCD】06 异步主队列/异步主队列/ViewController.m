//
//  ViewController.m
//  异步主队列
//
//  Created by 蓝田 on 16/3/20.
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
  [self mainQueueAsync];
}

#pragma mark - 异步函数 + 主队列：不会开启新的线程，在当前线程执行任务（主线程），任务是串行的（顺序执行），只开一条线程(适合处理 UI 或者是 UI事件)
- (void)asyncMain {
  NSLog(@"异步主队列 ----- begin");

  // 1.获得主队列
  dispatch_queue_t queue = dispatch_get_main_queue();

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

  NSLog(@"异步主队列 ----- end");
}

#pragma mark - 写法2
- (void)mainQueueAsync {
  NSLog(@"异步主队列 ----- begin");

  // 1.获取主队列
  dispatch_queue_t mainQueue = dispatch_get_main_queue();

  // 2.创建任务
  void (^task1)() = ^() {
    NSLog(@"---async task1---%@", [NSThread currentThread]);
  };

  void (^task2)() = ^() {
    NSLog(@"---async task2---%@", [NSThread currentThread]);
  };

  void (^task3)() = ^() {
    NSLog(@"---async task3---%@", [NSThread currentThread]);
  };

  // 3.将异步任务添加到主队列中
  dispatch_async(mainQueue, task1);
  dispatch_async(mainQueue, task2);
  dispatch_async(mainQueue, task3);

  NSLog(@"异步主队列 ----- end");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
