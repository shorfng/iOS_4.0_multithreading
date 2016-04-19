//
//  ViewController.m
//  NSBlockOperation
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

  // 1.创建 NSBlockOperation 操作对象
  NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
    // 在主线程
    NSLog(@"下载1------%@", [NSThread currentThread]);
  }];

  // 2.添加操作（额外的任务）（在子线程执行)
  [op addExecutionBlock:^{
    NSLog(@"下载2------%@", [NSThread currentThread]);
  }];

  [op addExecutionBlock:^{
    NSLog(@"下载3------%@", [NSThread currentThread]);
  }];
  [op addExecutionBlock:^{
    NSLog(@"下载4------%@", [NSThread currentThread]);
  }];

  // 3.开启执行操作
  [op start];
}

- (void)run {
  NSLog(@"------%@", [NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
