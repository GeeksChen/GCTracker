//   ControlViewController.m
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import "ControlViewController.h"
#import "GestureViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface ControlViewController ()

@end

@implementation ControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"埋点统计";
    
    UIButton *gestureBtn = [self customButtonWithTitle:@"Gesture" withBackgroundColor:[UIColor redColor] withSelector:@selector(toGestureVC)];
    gestureBtn.frame = CGRectMake(10, 100, self.view.frame.size.width-20, 50);
    [self.view addSubview:gestureBtn];
    
    UIButton *tableViewBtn = [self customButtonWithTitle:@"TableView" withBackgroundColor:[UIColor redColor] withSelector:@selector(toTableViewVC)];
    tableViewBtn.frame = CGRectMake(10, 160, self.view.frame.size.width-20, 50);
    [self.view addSubview:tableViewBtn];
    
    UIButton *collectionViewBtn = [self customButtonWithTitle:@"CollectionView" withBackgroundColor:[UIColor redColor] withSelector:@selector(toCollectionViewVC)];
    collectionViewBtn.frame = CGRectMake(10, 220, self.view.frame.size.width-20, 50);
    [self.view addSubview:collectionViewBtn];

}

- (void)toGestureVC {
    
    GestureViewController *controlVC = [GestureViewController new];
    [self.navigationController pushViewController:controlVC animated:YES];
}

- (void)toTableViewVC {
    
    TableViewController *tableViewVC = [TableViewController new];
    [self.navigationController pushViewController:tableViewVC animated:YES];
}

- (void)toCollectionViewVC {
    
    CollectionViewController *collectionViewVC = [CollectionViewController new];
    [self.navigationController pushViewController:collectionViewVC animated:YES];
}

- (UIButton *)customButtonWithTitle:(NSString *)title
                withBackgroundColor:(UIColor *)bgColor
                       withSelector:(SEL)selector
{
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setBackgroundColor:bgColor];
    [button addTarget:self action:selector forControlEvents:(UIControlEventTouchUpInside)];
    return button;
    
}
@end
