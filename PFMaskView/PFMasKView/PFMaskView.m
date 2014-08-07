//
//  PFMaskView.m
//  PFMaskView
//
//  Created by PFei_He on 14-7-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "PFMaskView.h"

typedef void(^PFMaskViewBlock)(id sender);

@interface PFMaskView ()

///是否被显示
@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, copy) PFMaskViewBlock block;

@end

@implementation PFMaskView

@synthesize delegate = _delegate;

@synthesize isShow = _isShow;

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutSubviews:CGRectZero usingBlock:NO];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubviews:frame usingBlock:NO];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame usingBlock:(BOOL)usingBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubviews:frame usingBlock:usingBlock];
    }
    return self;
}

#pragma mark - Mask View Management

//设置MaskView
- (void)layoutSubviews:(CGRect)frame usingBlock:(BOOL)usingBlock
{
    if (frame.size.height) {
        self.frame = frame;
    } else {
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.frame = frame;
    }
    
    //打开用户交互
    self.userInteractionEnabled = YES;

    //点击手势
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
    if (usingBlock) [recognizer addTarget:self action:@selector(tappedUsingBlock:)];
    else [recognizer addTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:recognizer];
}

//显示MaskView，覆盖于上方
- (void)maskViewShowInView:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [self insertSubview:view aboveSubview:siblingSubview];
}

//显示MaskView，覆盖于下方
- (void)maskViewShowInView:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [self insertSubview:view belowSubview:siblingSubview];
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

#pragma mark - Events Management

//点击屏幕时回调代理方法
- (void)tapped:(id)sender
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(maskViewDidTapped:)])
        [self.delegate maskViewDidTapped:self];
}

//点击屏幕时回调块方法
- (void)tappedUsingBlock:(id)sender
{
    if (self.block) self.block(sender);
}

//MasKView被点击
- (void)maskViewDidTappedUsingBlock:(void (^)(id))sender
{
    self.block = sender;
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
