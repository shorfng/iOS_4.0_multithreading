//
//  ViewController.m
//  线程安全
//
//  Created by 蓝田 on 16/3/17.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) NSThread *thread01; // 售票员01
@property(nonatomic, strong) NSThread *thread02; // 售票员02
@property(nonatomic, strong) NSThread *thread03; // 售票员03

@property(nonatomic, assign) NSInteger ticketCount; //票的总数
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.ticketCount = 10;

  //创建线程
  self.thread01 = [[NSThread alloc] initWithTarget:self
                                          selector:@selector(saleTicket)
                                            object:nil];
  self.thread01.name = @"售票员01";

  self.thread02 = [[NSThread alloc] initWithTarget:self
                                          selector:@selector(saleTicket)
                                            object:nil];
  self.thread02.name = @"售票员02";

  self.thread03 = [[NSThread alloc] initWithTarget:self
                                          selector:@selector(saleTicket)
                                            object:nil];
  self.thread03.name = @"售票员03";
}

// 开启线程
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.thread01 start];
  [self.thread02 start];
  [self.thread03 start];
}

// 卖票
- (void)saleTicket {

  while (1) {

    @synchronized(self) { //互斥锁（控制器做锁对象）
      // 先取出总数
      NSInteger count = self.ticketCount;

      // 判断还有没有余票
      if (count > 0) {
        self.ticketCount = count - 1;
        NSLog(@"%@卖了一张票，还剩下%zd张", [NSThread currentThread].name,
              self.ticketCount);
      } else {
        NSLog(@"票已经卖完了");
        break;
      }
    }
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
