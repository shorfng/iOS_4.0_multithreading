//
//  ViewController.m
//  其他用法 - 快速迭代
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
  [self apply];
}

#pragma mark - 文件剪切方法1：快速迭代
- (void)apply {

  dispatch_queue_t queue =
      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

  NSString *from = @"/Users/TD/Desktop/From";
  NSString *to = @"/Users/TD/Desktop/To";

  NSFileManager *mgr = [NSFileManager defaultManager];
  NSArray *subpaths = [mgr subpathsAtPath:from];

 
  dispatch_apply(subpaths.count, queue, ^(size_t index) {

    NSString *subpath = subpaths[index];
    NSString *fromFullpath = [from stringByAppendingPathComponent:subpath];
    NSString *toFullpath = [to stringByAppendingPathComponent:subpath];

    // 剪切
    [mgr moveItemAtPath:fromFullpath toPath:toFullpath error:nil];

    NSLog(@"%@---%@", [NSThread currentThread], subpath);
  });
}

#pragma mark - 文件剪切方法2：传统方式
- (void)moveFile {
  NSString *from = @"/Users/TD/Desktop/From";
  NSString *to = @"/Users/TD/Desktop/To";

  NSFileManager *mgr = [NSFileManager defaultManager];

  //获取文件夹下的所有文件路径，包括子文件夹下的文件路径
  NSArray *subpaths = [mgr subpathsAtPath:from];

  for (NSString *subpath in subpaths) {

    //全路径
    NSString *fromFullpath = [from stringByAppendingPathComponent:subpath];
    NSString *toFullpath = [to stringByAppendingPathComponent:subpath];

    dispatch_async(
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          // 剪切
          [mgr moveItemAtPath:fromFullpath toPath:toFullpath error:nil];
        });
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
