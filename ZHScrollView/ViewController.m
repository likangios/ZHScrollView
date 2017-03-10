//
//  ViewController.m
//  ZHScrollView
//
//  Created by macdev on 2017/3/10.
//  Copyright © 2017年 jimo. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _mainScrollView.backgroundColor = [UIColor orangeColor];
    _mainScrollView.contentSize = CGSizeMake(width, height * 10);
    _mainScrollView.scrollEnabled = NO;
    [self.view addSubview:_mainScrollView];
    
    for (int i = 0; i<10; i++) {
        UIScrollView *subScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, height*i, width, height)];
        subScro.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
        subScro.delegate = self;
        subScro.contentSize = CGSizeMake(width, height * 2);
        [_mainScrollView addSubview:subScro];
        
        MJRefreshBackNormalFooter *backStateFooter =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [subScro.mj_footer endRefreshing];
                double offsetY = _mainScrollView.contentOffset.y;
                if (_mainScrollView.contentOffset.y < (_mainScrollView.contentSize.height - CGRectGetHeight(_mainScrollView.frame))) {
                    offsetY += self.view.bounds.size.height;
                    [_mainScrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
                    subScro.contentOffset = CGPointMake(0, 0);
                }
        }];
        backStateFooter.arrowView.hidden = YES;
        if (i == 9) {
            [backStateFooter setTitle:@"已经是最后一篇了" forState:MJRefreshStateIdle];
            [backStateFooter setTitle:@"已经是最后一篇了" forState:MJRefreshStatePulling];
            [backStateFooter setTitle:@"已经是最后一篇了" forState:MJRefreshStateRefreshing];
            [backStateFooter setTitle:@"已经是最后一篇了" forState:MJRefreshStateWillRefresh];
        }else{
            [backStateFooter setTitle:@"载入下一篇" forState:MJRefreshStateIdle];
            [backStateFooter setTitle:@"载入下一篇" forState:MJRefreshStatePulling];
            [backStateFooter setTitle:@"载入下一篇" forState:MJRefreshStateRefreshing];
            [backStateFooter setTitle:@"载入下一篇" forState:MJRefreshStateWillRefresh];
        }
        subScro.mj_footer = backStateFooter;
        
        
        
        MJRefreshNormalHeader *norhead = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [subScro.mj_header endRefreshing];
                double offsetY = _mainScrollView.contentOffset.y;
                if (_mainScrollView.contentOffset.y > 0) {
                    offsetY -= self.view.bounds.size.height;
                    [_mainScrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
                    subScro.contentOffset = CGPointMake(0, 0);
                }
        }];
        norhead.lastUpdatedTimeLabel.hidden = YES;
        if (i == 0) {
            [norhead setTitle:@"已经是第一篇了" forState:MJRefreshStateIdle];
            [norhead setTitle:@"已经是第一篇了" forState:MJRefreshStatePulling];
            [norhead setTitle:@"已经是第一篇了" forState:MJRefreshStateRefreshing];
            [norhead setTitle:@"已经是第一篇了" forState:MJRefreshStateWillRefresh];
        }else{
            [norhead setTitle:@"载入上一篇" forState:MJRefreshStateIdle];
            [norhead setTitle:@"载入上一篇" forState:MJRefreshStatePulling];
            [norhead setTitle:@"载入上一篇" forState:MJRefreshStateRefreshing];
            [norhead setTitle:@"载入上一篇" forState:MJRefreshStateWillRefresh];
        }
        subScro.mj_header = norhead;
        
    }
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
