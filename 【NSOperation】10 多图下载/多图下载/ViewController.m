//
//  ViewController.m
//  多图下载
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "TDApp.h"
#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) NSArray *apps;                   //所有数据
@property(nonatomic, strong) NSMutableDictionary *imageCache; //内存缓存的图片
@property(nonatomic, strong) NSOperationQueue *queue;         //队列对象
@property(nonatomic, strong) NSMutableDictionary *operations; //所有的操作对象

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.apps.count;
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  // 重用标识
  static NSString *ID = @"app";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

  TDApp *app = self.apps[indexPath.row];

#pragma mark - app 名称
  cell.textLabel.text = app.name;

#pragma mark - 下载量
  cell.detailTextLabel.text = app.download;

#pragma mark - 图片
  // 1.先从内存缓存中取出图片
  UIImage *image = self.imageCache[app.icon];

  // 2.判断内存中是否有图片
  if (image) {
    // 2.1 内存中有图片，直接设置图片
    cell.imageView.image = image;
  } else {
    // 2.2 内存中没有图片，将图片文件数据写入沙盒中

    //（1）获得Library/Caches文件夹
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(
        NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //（2）获得文件名
    NSString *filename = [app.icon lastPathComponent];
    //（3）计算出文件的全路径
    NSString *file = [cachesPath stringByAppendingPathComponent:filename];
    //（4）加载沙盒的文件数据
    NSData *data = [NSData dataWithContentsOfFile:file];

    // 2.3 判断沙盒中是否有图片
    if (data) {

      // 有图片，直接利用沙盒中图片，设置图片
      UIImage *image = [UIImage imageWithData:data];
      cell.imageView.image = image;
      // 并将图片存到字典中
      self.imageCache[app.icon] = image;

    } else {

      // 没有图片,先设置一个占位图
      cell.imageView.image = [UIImage imageNamed:@"placeholder"];

      // 取出图片，并判断这张图片是否有下载操作
      NSOperation *operation = self.operations[app.icon];
      if (operation == nil) {
        // 如果这张图片暂时没有下载操作，则需要创建一个下载操作
        // 下载图片是耗时操作，放到子线程
        operation = [NSBlockOperation blockOperationWithBlock:^{
          // 下载图片
          NSData *data =
              [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
          // 如果数据下载失败
          if (data == nil) {
            // 下载失败，移除操作
            [self.operations removeObjectForKey:app.icon];
            return;
          }

            // 下载成功，将图片放在 image 中
          UIImage *image = [UIImage imageWithData:data];
          // 存到字典中
          self.imageCache[app.icon] = image;

          //回到主线程显示图片
          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [tableView reloadRowsAtIndexPaths:@[ indexPath ]
                             withRowAnimation:UITableViewRowAnimationNone];
          }];

          // 将图片文件数据写入沙盒中
          [data writeToFile:file atomically:YES];
          // 下载完毕，移除操作
          [self.operations removeObjectForKey:app.icon];
        }];

        // 添加到队列中（队列的操作不需要移除，会自动移除）
        [self.queue addOperation:operation];
        // 并将图片存到字典中
        self.operations[app.icon] = operation;
      }
    }
  }

  return cell;
}

#pragma mark - 数据懒加载
- (NSArray *)apps {
  if (!_apps) {
    NSArray *dictArray =
        [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                             pathForResource:@"apps.plist"
                                                      ofType:nil]];

    NSMutableArray *appArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
      [appArray addObject:[TDApp appWithDict:dict]];
    }
    _apps = appArray;
  }
  return _apps;
}

#pragma mark - 懒加载
- (NSMutableDictionary *)imageCache {
  if (!_imageCache) {
    _imageCache = [NSMutableDictionary dictionary];
  }
  return _imageCache;
}

#pragma mark - 懒加载
- (NSOperationQueue *)queue {
  if (!_queue) {
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 3;
  }
  return _queue;
}

#pragma mark - 懒加载
- (NSMutableDictionary *)operations {
  if (!_operations) {
    _operations = [NSMutableDictionary dictionary];
  }
  return _operations;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
