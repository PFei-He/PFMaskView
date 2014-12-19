//
//  PFMaskView.m
//  PFMaskView
//
//  Created by PFei_He on 14-7-3.
//  Copyright (c) 2014年 PF-Lib. All rights reserved.
//
//  https://github.com/PFei-He/PFMaskView
//
//  vesion: 0.1.1
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:recognizer]; recognizer = nil;
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
- (void)didTappedUsingBlock:(void (^)(void))block
{
    if (block) self.block = block;
}

#pragma mark - Events Management

//点击事件
- (void)tap
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
    self.block = nil, self.delegate = nil;
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
