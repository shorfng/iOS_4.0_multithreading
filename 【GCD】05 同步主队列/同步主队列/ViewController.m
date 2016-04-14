//
//  ViewController.m
//  同步主队列
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
  [self syncMain];
}

#pragma mark - 同步函数 + 主队列：不会开启新的线程，会出现"死等",可能导致`主线程`卡死
- (void)syncMain {
  NSLog(@"同步主队列 ----- begin");

  // 1.获得主队列
  dispatch_queue_t queue = dispatch_get_main_queue();

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

  NSLog(@"同步主队列 ----- end");
}

- (void)mainQueueSync {
  NSLog(@"同步主队列 ----- begin");

  // 1.获取主队列
  dispatch_queue_t mainQueue = dispatch_get_main_queue();

  // 2.创建队列
  void (^task1)() = ^() {
    NSLog(@"---task1---%@", [NSThread currentThread]);
  };

  void (^task2)() = ^() {
    NSLog(@"---task2---%@", [NSThread currentThread]);
  };

  void (^task3)() = ^() {
    NSLog(@"---task3---%@", [NSThread currentThread]);
  };

  // 3.将同步任务添加到并发队列中
  dispatch_sync(mainQueue, task1);
  dispatch_sync(mainQueue, task2);
  dispatch_sync(mainQueue, task3);

  NSLog(@"同步主队列 ----- end");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
