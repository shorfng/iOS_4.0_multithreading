//
//  ViewController.m
//  其他用法 - barrier函数
//
//  Created by 蓝田 on 16/3/21.
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
  // 这里使用全局并发队列的方式会导致 dispatch_barrier_async 功能失效
  dispatch_queue_t queue =
      dispatch_queue_create("TD", DISPATCH_QUEUE_CONCURRENT);

  dispatch_async(queue, ^{
    NSLog(@"----1-----%@", [NSThread currentThread]);
  });
  dispatch_async(queue, ^{
    NSLog(@"----2-----%@", [NSThread currentThread]);
  });

  dispatch_barrier_async(queue, ^{
    NSLog(@"----barrier-----%@", [NSThread currentThread]);
  });

  dispatch_async(queue, ^{
    NSLog(@"----3-----%@", [NSThread currentThread]);
  });
  dispatch_async(queue, ^{
    NSLog(@"----4-----%@", [NSThread currentThread]);
  });
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
