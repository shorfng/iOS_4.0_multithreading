//
//  ViewController.m
//  自定义NSOperation
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "TDOperation.h"
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

  // 2.创建自定义 TDGOperation
  TDOperation *op = [[TDOperation alloc] init];

  // 3.把操作（任务）添加到队列中，并自动调用 start 方法
  [queue addOperation:op];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
