//
//  ViewController.m
//  线程间通信
//
//  Created by 蓝田 on 16/3/21.
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

  // 全局的异步并发
  dispatch_async(
      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        // 图片的网络路径
        NSURL *url = [NSURL
            URLWithString:@"http://www.5068.com/u/faceimg/20140804114111.jpg"];

        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];

        // 生成图片
        UIImage *image = [UIImage imageWithData:data];

        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
          self.imageView.image = image;
        });
      });
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
