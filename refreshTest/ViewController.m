//
//  ViewController.m
//  refreshTest
//
//  Created by golven on 15/7/31.
//  Copyright (c) 2015年 magicEngineer. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+GResfresh.h"
#import "GMyRefreshView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UITableView *tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tableView];
    
    GMyRefreshView *view =[[GMyRefreshView alloc] initWithFrame:CGRectMake(0, -60, [UIScreen mainScreen].bounds.size.width, 60)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud"]];
    tableView.header = view;
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"停止刷新" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [tableView addSubview:btn];
}

- (void)stop {
    [tableView.header stopRefresh];
}

@end
