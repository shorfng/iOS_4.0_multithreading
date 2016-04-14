//
//  ViewController.m
//  创建线程3 - 分类方法
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
  [self threadDemo3];
}

#pragma mark - 分类方法
- (void)threadDemo3 {
  NSLog(@"before %@", [NSThread currentThread]);

  // performSelectorInBackground 是NSObject的分类方法,会自动在后台线程执行@selector方法
  // 没有 thread 字眼，隐式创建并启动线程
  // 所有 NSObject 都可以使用此方法，在其他线程执行方法
  // 通过NSThread的类和NSObject的分类方法直接加入到可调度线程池里面去,等待CPU调度
  // PerformSelectorInBackground 可以让方便地在后台线程执行任意NSObject对象的方法
  [self performSelectorInBackground:@selector(longOperation:)
                         withObject:@"PERFORM"];

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
