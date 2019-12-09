//
//  ViewController.m
//  MultipleScroll
//
//  Created by YinLinLin on 2019/1/3.
//  Copyright © 2019 Yiche. All rights reserved.
//

#import "ViewController.h"

@interface MyScrollView : UIScrollView


@end

@implementation MyScrollView

///允许同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) MyScrollView *scrollView1;

@property (nonatomic, strong) MyScrollView *scrollView2;

@property (nonatomic, strong) UIView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat viewHeight = self.view.bounds.size.height;
    CGFloat viewWidth = self.view.bounds.size.width;
    _scrollView1 = [[MyScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView1.delegate = self;
    _scrollView1.backgroundColor = [UIColor redColor];
    _scrollView1.contentSize = CGSizeMake(viewWidth, viewHeight/2.0*3 - 60);
    [self.view addSubview:_scrollView1];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight/2.0)];
    _topView.backgroundColor = [UIColor lightGrayColor];
    [_scrollView1 addSubview:_topView];
    
    _scrollView2 = [[MyScrollView alloc] initWithFrame:CGRectMake(0, viewHeight/2.0, viewWidth, viewHeight - 60)];
    _scrollView2.delegate = self;
    _scrollView2.scrollEnabled = NO;
    _scrollView2.contentSize = CGSizeMake(viewWidth, viewHeight*3);
    _scrollView2.backgroundColor = [UIColor greenColor];
    [_scrollView1 addSubview:_scrollView2];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat topViewHeight = _topView.bounds.size.height;
    if (scrollView == _scrollView1) {
        CGFloat offset = scrollView.contentOffset.y;
        if (offset >= topViewHeight - 60) {
            _scrollView2.scrollEnabled = YES;
        } else {
            _scrollView2.scrollEnabled = NO;
        }
    } else if (scrollView == _scrollView2) {
        CGFloat offset = scrollView.contentOffset.y;
        if (offset <= 0) {
            _scrollView2.scrollEnabled = NO;
            _scrollView1.scrollEnabled = YES;
        } else {
            _scrollView1.contentOffset = CGPointMake(0, topViewHeight - 60);
            _scrollView1.scrollEnabled = NO;
        }
    }
}


@end
