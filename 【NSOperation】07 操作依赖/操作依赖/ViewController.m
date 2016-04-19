//
//  ViewController.m
//  操作依赖
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

  NSOperationQueue *queue = [[NSOperationQueue alloc] init];

  //创建对象，封装操作
  NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"download1----%@", [NSThread currentThread]);
  }];
  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"download2----%@", [NSThread currentThread]);
  }];
  NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"download3----%@", [NSThread currentThread]);
  }];
  NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
    for (NSInteger i = 0; i < 5; i++) {
      NSLog(@"download4----%@", [NSThread currentThread]);
    }
  }];

  NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"download5----%@", [NSThread currentThread]);
  }];
  //操作的监听
  op5.completionBlock = ^{
    NSLog(@"op5执行完毕---%@", [NSThread currentThread]);
  };

  //设置操作依赖（op4执行完，才执行 op3）
  [op3 addDependency:op1];
  [op3 addDependency:op2];
  [op3 addDependency:op4];

  //把操作添加到队列中
  [queue addOperation:op1];
  [queue addOperation:op2];
  [queue addOperation:op3];
  [queue addOperation:op4];
  [queue addOperation:op5];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
