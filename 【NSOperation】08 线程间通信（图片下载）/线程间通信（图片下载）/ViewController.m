//
//  ViewController.m
//  线程间通信（图片下载）
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self test2];
}

#pragma mark - 线程间通信（图片合成）
- (void)test1 {
  // 1.队列
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];

  __block UIImage *image1 = nil;
  // 2.下载图片1
  NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
    // 图片的网络路径
    NSURL *url =
        [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/"
                             @"8/1/9981681/200910/11/1255259355826.jpg"];
    // 加载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 生成图片
    image1 = [UIImage imageWithData:data];
  }];

  __block UIImage *image2 = nil;
  // 3.下载图片2
  NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
    // 图片的网络路径
    NSURL *url = [NSURL
        URLWithString:
            @"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
    // 加载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 生成图片
    image2 = [UIImage imageWithData:data];
  }];

  // 4.合成图片
  NSBlockOperation *combine = [NSBlockOperation blockOperationWithBlock:^{
    // 开启新的图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));

    // 绘制图片1
    [image1 drawInRect:CGRectMake(0, 0, 50, 100)];
    image1 = nil;

    // 绘制图片2
    [image2 drawInRect:CGRectMake(50, 0, 50, 100)];
    image2 = nil;

    // 取得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    // 结束上下文
    UIGraphicsEndImageContext();

    // 5.回到主线程
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      self.imageView.image = image;
    }];
  }];

  // 设置依赖操作
  [combine addDependency:download1];
  [combine addDependency:download2];

  //把操作添加到队列中
  [queue addOperation:download1];
  [queue addOperation:download2];
  [queue addOperation:combine];
}

#pragma mark - 线程间通信（图片下载）
- (void)test2 {
  [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
    // 图片的网络路径
    NSURL *url =
        [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/"
                             @"8/1/9981681/200910/11/1255259355826.jpg"];

    // 加载图片
    NSData *data = [NSData dataWithContentsOfURL:url];

    // 生成图片
    UIImage *image = [UIImage imageWithData:data];

    // 回到主线程
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      self.imageView.image = image;
    }];
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
