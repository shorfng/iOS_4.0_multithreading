//
//  ViewController.m
//  NSInvocationOperation
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

  //创建操作对象，封装要执行的任务
  NSInvocationOperation *op =
      [[NSInvocationOperation alloc] initWithTarget:self
                                           selector:@selector(run)
                                             object:nil];
  //执行操作
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
