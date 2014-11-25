//
//  PFMaskView.h
//  PFMaskView
//
//  Created by PFei_He on 14-7-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
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
 *  @brief 隐藏覆盖层
 */
-(void)hidden;

/**
 *  @brief 覆盖层被点击
 */
- (void)didTappedUsingBlock:(void (^)())block;

@end
