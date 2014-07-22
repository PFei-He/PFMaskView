//
//  PFMaskView.h
//  PFMaskView
//
//  Created by PFei_He on 14-7-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFMaskViewDelegate <NSObject>

/**
 *  @brief MasKView被点击
 */
- (void)maskViewDidTapped:(id)tapped;

@end

@interface PFMaskView : UIView

///代理
@property (nonatomic, assign) id<PFMaskViewDelegate> delegate;

/**
 *  @brief 显示MaskView
 */
- (void)maskViewShowInView:(UIView *)view;

/**
 *  @brief 显示MaskView
 *  @details 覆盖于上方
 */
-(void)maskViewShowInView:(UIView *)view aboveSubview:(UIView *)siblingSubview;

/**
 *  @brief 显示MaskView
 *  @details 覆盖于下方
 */
-(void)maskViewShowInView:(UIView *)view belowSubview:(UIView *)siblingSubview;

/**
 *  @brief 隐藏MaskView
 */
-(void)maskViewHidden;



@end
