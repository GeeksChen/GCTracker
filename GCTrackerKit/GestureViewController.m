//   GestureViewController.m
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import "GestureViewController.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [redView addGestureRecognizer:tap];
    
}

- (void)tapAction {

    NSLog(@"Tap");
}

@end
