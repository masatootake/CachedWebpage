//
//  RootViewController.m
//  CachedWebpage
//
//  Created by 大竹 雅登 on 13/09/23.
//  Copyright (c) 2013年 Masato. All rights reserved.
//

#import "RootViewController.h"

#import "WebViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) NSMutableArray *urls;

@end

@implementation RootViewController

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"URL";
    
    // tableの設定
    _tableView.delegate = self;
    _tableView.dataSource = self;

    // urlの配列
    _urls = [NSMutableArray array];
    [_urls addObject:@"http://cnn.com"];
    [_urls addObject:@"http://bbc.com"];
    [_urls addObject:@"http://yahoo.com"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 選択を解除
    [_tableView deselectRowAtIndexPath:_tableView.indexPathForSelectedRow animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _urls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // urlを表示
    cell.textLabel.text = _urls[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // urlを渡して、遷移
    WebViewController *controller = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    controller.urlString = _urls[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
