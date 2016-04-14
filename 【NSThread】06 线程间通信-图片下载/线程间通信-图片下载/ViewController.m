//
//  ViewController.m
//  线程间通信-图片下载
//
//  Created by 蓝田 on 16/3/17.
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
  // 开启子线程（在子线程中调用download方法下载图片）
  [self performSelectorInBackground:@selector(download) withObject:nil];
}

#pragma mark - 图片下载
- (void)download {
  // 1.图片的网络路径
  NSURL *url =
      [NSURL URLWithString:@"http://www.5068.com/u/faceimg/20140804114111.jpg"];

  // 2.下载图片并把图片转换为二进制的数据（耗时操作）
  NSData *data = [NSData dataWithContentsOfURL:url];

  // 3.生成图片（把数据转换成图片）
  UIImage *image = [UIImage imageWithData:data];

  // 4.回到主线程中设置图片
  // 方法1：
  [self.imageView
      performSelector:@selector(setImage:)
             onThread:[NSThread mainThread]
           withObject:image
        waitUntilDone:NO]; //是否等到@selector的方法完成后再往下执行，NO表示否

  //方法2：
//  [self.imageView performSelectorOnMainThread:@selector(setImage:)
//                                   withObject:image
//                                waitUntilDone:NO];
  // 方法3：代码一
//  [self performSelectorOnMainThread:@selector(showImage:)
//                         withObject:image
//                      waitUntilDone:NO];
}

// 方法3：代码二
//- (void)showImage:(UIImage *)image {
//  self.imageView.image = image; //设置显示图片
//}

#pragma mark - 测试图片下载时间 方法1：NSDate
- (void)download1 {
  // 1.图片的网络路径
  NSURL *url =
      [NSURL URLWithString:@"http://www.5068.com/u/faceimg/20140804114111.jpg"];

  NSDate *begin = [NSDate date]; //开始时间

  // 2.根据图片的网络路径去下载图片数据
  NSData *data = [NSData dataWithContentsOfURL:url];

  NSDate *end = [NSDate date]; //结束时间

  NSLog(@"%f", [end timeIntervalSinceDate:begin]); // 时间间隔 = 开始-结束

  // 3.显示图片
  self.imageView.image = [UIImage imageWithData:data];
}

#pragma mark - 测试图片下载时间 方法2：CFTimeInterval
- (void)download2 {
  // 1.图片的网络路径
  NSURL *url =
      [NSURL URLWithString:@"http://www.5068.com/u/faceimg/20140804114111.jpg"];

  CFTimeInterval begin = CFAbsoluteTimeGetCurrent(); // 开始时间

  // 2.根据图片的网络路径去下载图片数据
  NSData *data = [NSData dataWithContentsOfURL:url];

  CFTimeInterval end = CFAbsoluteTimeGetCurrent(); //结束时间

  NSLog(@"%f", end - begin); // 时间间隔 = 开始-结束

  // 3.显示图片
  self.imageView.image = [UIImage imageWithData:data];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
