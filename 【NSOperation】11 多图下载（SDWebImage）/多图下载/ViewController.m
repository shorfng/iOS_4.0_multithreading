//
//  ViewController.m
//  多图下载
//
//  Created by 蓝田 on 16/3/22.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "TDApp.h"
#import "UIImageView+WebCache.h"
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
  // expectedSize: 图片的总字节数   receivedSize: 已经接收的图片字节数
  [cell.imageView sd_setImageWithURL:[NSURL URLWithString:app.icon]
      placeholderImage:[UIImage imageNamed:@"placeholder"]
      options:0 // 0 表示什么都不做
      progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        NSLog(@"下载进度：%f", 1.0 * receivedSize / expectedSize);
      }
      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,
                  NSURL *imageURL) {
        NSLog(@"下载完图片");
      }];
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

#pragma mark - 设置控制器的内存警告
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];

  self.imageCache = nil;
  self.operations = nil;
  [self.queue cancelAllOperations];
}

@end
