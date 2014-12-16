//
//  PFMaskView.h
//  PFMaskView
//
//  Created by PFei_He on 14-7-3.
//  Copyright (c) 2014年 PF-Lib. All rights reserved.
//
//  https://github.com/PFei-He/PFMaskView
//
//  vesion: 0.1.0
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
