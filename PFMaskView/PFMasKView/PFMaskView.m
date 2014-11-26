//
//  PFMaskView.m
//  PFMaskView
//
//  Created by PFei_He on 14-7-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "PFMaskView.h"

typedef void(^tapBlock)();

@interface PFMaskView ()

///点击事件
@property (nonatomic, copy) tapBlock block;

@end

@implementation PFMaskView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.size.height ? (self.frame = frame) : (self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height));

        //点击手势
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

#pragma mark - Public Mathods

//显示覆盖层
- (void)showInView:(UIView *)view
{
    view ? [view addSubview:self] : [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

//覆盖层被点击
- (void)didTappedUsingBlock:(void (^)())block
{
    if (block) self.block = block, block = nil;
}

#pragma mark - Events Management

//点击事件
- (void)tapped:(UIGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(maskViewDidTapped)]) {//监听代理并回调
        [self.delegate maskViewDidTapped];
    } else if (self.block) {//监听块并回调
        self.block();
    }
}

#pragma mark - Memory Management

- (void)dealloc
{
#if __has_feature(objc_arc)
    self.block      = nil;
    self.delegate   = nil;
#else
#endif
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
