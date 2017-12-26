//
//  ViewController.m
//  TV_TV_3
//
//  Created by liyy on 2017/12/26.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "ViewController.h"
#import "BrandHomeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BrandHomeViewController *controller = [[BrandHomeViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
