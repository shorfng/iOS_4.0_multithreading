//
//  ViewController.m
//  其他用法 - 一次性代码
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

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSLog(@"------run"); // 只执行1次的代码(这里面默认是线程安全的)
  });
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
