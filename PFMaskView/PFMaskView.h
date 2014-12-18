//
//  PFMaskView.h
//  PFMaskView
//
//  Created by PFei_He on 14-7-3.
//  Copyright (c) 2014年 PF-Lib. All rights reserved.
//
//  https://github.com/PFei-He/PFMaskView
//
//  vesion: 0.1.1-beta2
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

#import <UIKit/UIKit.h>

/**
 *  弱引用`self`。用于解决代码块（block）与强引用self之间的循环引用问题
 *  调用方式: `@weakify_self`实现弱引用转换，而后使用`weakSelf`代替`self`
 *
 *  示例:
 *  @weakify_self
 *  [obj block:^{
 *      weakSelf.property = something;
 *  }];
 *
 */
#ifndef	weakify_self
    #if __has_feature(objc_arc)
        #define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
    #else
        #define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
    #endif
#endif

/**
 *  弱引用`object`。用于解决代码块（block）与强引用对象之间的循环引用问题
 *  调用方式: `@weakify`实现弱引用转换，`@normalize`把转换后的对象改回原来的对象名
 *
 *  示例:
 *  @weakify(object)
 *  [obj block:^{
 *      @normalize(object)
 *      object = something;
 *  }];
 *
 */
#ifndef	weakify
    #if __has_feature(objc_arc)
        #define weakify(object)	autoreleasepool{} __weak __typeof__(object) __weak_##x##__ = x;
    #else
        #define weakify(object)	autoreleasepool{} __block __typeof__(object) __block_##x##__ = x;
    #endif
#endif
#ifndef	normalize
    #if __has_feature(objc_arc)
        #define normalize(object) try{} @finally{} __typeof__(object) x = __weak_##x##__;
    #else
        #define normalize(object) try{} @finally{} __typeof__(object) x = __block_##x##__;
    #endif
#endif

@protocol PFMaskViewDelegate <NSObject>

@optional

/**
 *  @brief 覆盖层被点击
 */
- (void)maskViewDidTapped;

@end

@interface PFMaskView : UIView

///代理
@property (nonatomic, weak) id<PFMaskViewDelegate> delegate;

/**
 *  @brief 显示覆盖层（设置为nil时显示于所有视图的最上层）
 */
- (void)showInView:(UIView *)view;

/**
 *  @brief 覆盖层被点击
 */
- (void)didTappedUsingBlock:(void (^)(void))block;

@end
