//
//  PFMaskView.m
//  PFMaskView
//
//  Created by PFei_He on 14-7-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "PFMaskView.h"

@interface PFMaskView ()

///是否被显示
@property (nonatomic, assign) BOOL isShow;

@end

@implementation PFMaskView

@synthesize color = _color;
@synthesize delegate = _delegate;

@synthesize isShow = _isShow;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutSubviews:CGRectZero];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubviews:frame];
    }
    return self;
}

//设置MaskView
- (void)layoutSubviews:(CGRect)frame
{
    if (frame.size.height) {
        self.frame = frame;
    } else {
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.frame = frame;
    }

    //打开用户交互
    self.userInteractionEnabled = YES;

    //设置背景颜色
    if (self.color) self.backgroundColor = self.color;
    else self.backgroundColor = [UIColor clearColor];

    //点击手势
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:recognizer];
}

//点击屏幕时回调代理方法
- (void)tapped:(id)sender
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(maskViewDidTapped:)])
        [self.delegate maskViewDidTapped:self];
}

//显示MaskView，覆盖于上方
- (void)maskViewShowInView:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [view insertSubview:self aboveSubview:siblingSubview];
}

//显示MaskView，覆盖于下方
- (void)maskViewShowInView:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [view insertSubview:self belowSubview:siblingSubview];
}

//显示MaskView
- (void)maskViewShowInView:(UIView *)view
{
    self.isShow = YES;
    if (!view) [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    else [view addSubview:self];
}

//隐藏MaskView
- (void)maskViewHidden
{
    [self removeFromSuperview];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
