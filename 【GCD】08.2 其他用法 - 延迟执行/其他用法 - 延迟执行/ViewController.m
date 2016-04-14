//
//  ViewController.m
//  其他用法 - 延迟执行
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  [self delay1];
}

#pragma mark - 方法1：调用NSObject的方法
- (void)delay1 {
  NSLog(@"touchesBegan-----");

  // 2秒后再调用self的run方法
  [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
}

#pragma mark - 方法2：使用 GCD 函数
- (void)delay2 {
  NSLog(@"touchesBegan-----");

  // 这里是在主线程执行，如果想要在子线程执行，选择相应的队列
  dispatch_after(
      dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),
      dispatch_get_main_queue(), ^{
        NSLog(@"run-----");
      });
}

#pragma mark - 方法3：使用NSTimer定时器
- (void)delay3 {
  NSLog(@"touchesBegan-----");

  [NSTimer scheduledTimerWithTimeInterval:2.0
                                   target:self
                                 selector:@selector(run)
                                 userInfo:nil
                                  repeats:NO];
}

- (void)run {
  NSLog(@"run-----");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
