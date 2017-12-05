//
//  ViewController.m
//  TV_TV_2
//
//  Created by liyy on 2017/12/5.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "ViewController.h"
#import "PointViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PointViewController *controller = [[PointViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
