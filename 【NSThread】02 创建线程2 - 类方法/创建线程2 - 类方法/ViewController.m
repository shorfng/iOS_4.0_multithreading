//
//  ViewController.m
//  创建线程2 - 类方法
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
  [self threadDemo2];
}

#pragma mark - 类方法
- (void)threadDemo2 {
  NSLog(@"before %@", [NSThread currentThread]);

  // detachNewThreadSelector 类方法不需要启动，会自动创建线程并执行@selector方法
  // 它会自动给我们做两件事 :  1.创建线程对象   2.添加到`可调度线程池`
  // 通过NSThread的类和NSObject的分类方法直接加入到可调度线程池里面去,等待CPU调度
  [NSThread detachNewThreadSelector:@selector(longOperation:)
                           toTarget:self
                         withObject:@"DETACH"];

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
