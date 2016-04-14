//
//  ViewController.m
//  线程生命周期
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

  // 1.在主线程中创建一个子线程(实例化线程对象) ---> 新建状态
  NSThread *Th =
      [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];

  // 2.将 Th 线程加入到可调度线程池,等待CPU调度--->就绪状态
  [Th start];

  // 3.让主线程阻塞,让当前线程(主线程)休眠
  [NSThread sleepForTimeInterval:1.0];

  // 4.在主线程给 Th 线程打死亡标签
  [Th cancel]; //只是打了个标签,并没有执行,需要在子线程中
}

// Th 线程---> 运行状态
- (void)run {

  NSThread *huThread = [NSThread currentThread];

  CGMutablePathRef path = CGPathCreateMutable();

  for (int i = 0; i < 30; i++) {
    if ([huThread isCancelled]) {
      NSLog(@"good bye1");
      return; // --->非正常死亡(被逼着死亡)
    }

    if (i == 5) {
      [NSThread sleepForTimeInterval:3.0]; //--->huThread阻塞状态3秒
      // [NSThread sleepUntilDate:[NSDate distantFuture]]; // 睡到遥远的未来
      // [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]]; //线程睡到从现在开始后的2秒为止
    }

    if ([huThread isCancelled]) {
      NSLog(@"good bye2");
      return;
    }

    if (i == 20) {
      //清空资源
      CGPathRelease(path);

      //在调用下面方法之前,必须清空资源  非正常死亡--自杀（退出线程）
      [NSThread exit];
    }

    if ([huThread isCancelled]) {
      NSLog(@"good bye3");
      return;
    }
    NSLog(@"%d", i);
  }
} //--->huThread死亡状态  (正常死亡状态)


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
