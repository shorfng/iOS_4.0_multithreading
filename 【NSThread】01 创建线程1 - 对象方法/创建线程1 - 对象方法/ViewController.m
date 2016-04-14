//
//  ViewController.m
//  创建线程1 - 对象方法
//
//  Created by 蓝田 on 16/3/17.
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
  [self threadDemo1];
}

#pragma mark - 对象方法alloc/init
/*
 - 在 OC 中，任何一个方法的代码都是从上向下顺序执行的
 - 同一个方法内的代码，都是在相同线程执行的(block除外)
 */
- (void)threadDemo1 {
  NSLog(@"before %@", [NSThread currentThread]);

  // 线程一启动，就会在线程thread中执行self的run方法
  NSThread *thread = [[NSThread alloc] initWithTarget:self
                                             selector:@selector(longOperation:)
                                               object:@"THREAD"];

  //开启线程,通过start方法,就会将我们创建出来的当前线程加入到`可调度线程池`,供CPU调度
  //[thread start];执行后，会在另外一个线程执行 longOperation: 方法
  [thread start];

  NSLog(@"after %@", [NSThread currentThread]);
}

- (void)longOperation:(id)obj {
  NSLog(@"%@ - %@", [NSThread currentThread], obj);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
