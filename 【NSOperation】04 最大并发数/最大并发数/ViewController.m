//
//  ViewController.m
//  最大并发数
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
  // 1.创建队列
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];

  // 2.设置最大并发操作数(大并发操作数 = 1,就变成了串行队列)
  queue.maxConcurrentOperationCount = 2;

  // 3.添加操作
  [queue addOperationWithBlock:^{
    NSLog(@"download1 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"download2 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"download3 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"download4 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"download5 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"download6 --- %@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
