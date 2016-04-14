//
//  ViewController.m
//  其他用法 - 队列组
//
//  Created by 蓝田 on 16/3/21.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) UIImage *image1; //图片1
@property(nonatomic, strong) UIImage *image2; //图片2
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  dispatch_queue_t queue =
      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

  // 创建一个队列组
  dispatch_group_t group = dispatch_group_create();

  // 1.下载图片1
  dispatch_group_async(group, queue, ^{
    // 图片的网络路径
    NSURL *url =
        [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/"
                             @"8/1/9981681/200910/11/1255259355826.jpg"];
    // 加载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 生成图片
    self.image1 = [UIImage imageWithData:data];
  });

  // 2.下载图片2
  dispatch_group_async(group, queue, ^{
    // 图片的网络路径
    NSURL *url = [NSURL
        URLWithString:
            @"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
    // 加载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 生成图片
    self.image2 = [UIImage imageWithData:data];
  });

  // 3.将图片1、图片2合成一张新的图片（也可以直接在此处回到主线程，只不过是因为绘制图片比较耗时，没有放在主线程而已）
  dispatch_group_notify(group, queue, ^{

    // 开启新的图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));

    // 绘制图片
    [self.image1 drawInRect:CGRectMake(0, 0, 50, 100)];
    [self.image2 drawInRect:CGRectMake(50, 0, 50, 100)];

    // 取得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    // 结束上下文
    UIGraphicsEndImageContext();

    // 回到主线程显示图片
    dispatch_async(dispatch_get_main_queue(), ^{
      // 4.将新图片显示出来
      self.imageView.image = image;
    });
  });
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
