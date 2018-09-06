//
//  ViewController.m
//  ShowLoadingDemo
//
//  Created by livesxu on 2018/9/6.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "ViewController.h"

#import "UIView+ShowExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imgLoading=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 100, 100)];
    
    UIImage *imgs_little=[UIImage animatedImageWithImages:@[[UIImage imageNamed:@"rssloading1"],
                                                            [UIImage imageNamed:@"rssloading2"],
                                                            [UIImage imageNamed:@"rssloading3"]] duration:.6];
    
    imgLoading.image=imgs_little;
    
    [LXLoadingView shareLoading].loadingView = imgLoading;
    
//    [LXLoadingView shareLoading].delayTime = 2;
    
    BeginLoading();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
