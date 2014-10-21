//
//  UIView+GMAutolayoutAdditions.h
//  GoldenManager
//
//  Created by Joan Romano on 19/05/14.
//  Copyright (c) 2014 Kerad Games. All rights reserved.
//

extern CGFloat const GMAutolayoutStandardFixedViewToViewSpace;
extern CGFloat const GMAutolayoutStandardFixedViewToSuperviewSpace;

typedef NS_ENUM(NSUInteger, UIViewLayoutDirection){
    UIViewLayoutDirectionHorizontal,
    UIViewLayoutDirectionVertical
};

@interface UIView (GMAutolayoutAdditions)

+ (instancetype)newAutolayoutView;

- (void)removeOwnAndSubviewsContraints;

- (void)constrainToSize:(CGSize)size;
- (void)constrainToWidth:(CGFloat)width;
- (void)constrainToHeight:(CGFloat)height;
- (void)equalSizeOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview;
- (void)equalWidthOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview multiplier:(CGFloat)multiplier;
- (void)equalHeightOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview multiplier:(CGFloat)multiplier;

- (void)centerInSuperview;
- (void)centerXInSuperview;
- (void)centerYInSuperview;

- (void)fillInSuperview;
- (void)verticallyFillInSuperview;
- (void)horizontallyFillInSuperview;

- (void)fillViewGroup:(NSArray *)views withDirection:(UIViewLayoutDirection)direction;
- (void)fillViewGroup:(NSArray *)views withDirection:(UIViewLayoutDirection)direction options:(NSLayoutFormatOptions)options;
- (void)fillViewGroup:(NSArray *)views withDirection:(UIViewLayoutDirection)direction options:(NSLayoutFormatOptions)options fixedSpace:(CGFloat)space;

- (void)alignLeftInSuperview;
- (void)alignRightInSuperview;
- (void)alignBottomInSuperview;
- (void)alignTopInSuperview;

- (void)pinSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview withDirection:(UIViewLayoutDirection)direction;
- (void)pinSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview withDirection:(UIViewLayoutDirection)direction fixedSpace:(CGFloat)space;
- (void)pinSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview withDirection:(UIViewLayoutDirection)direction fixedSpace:(CGFloat)space options:(NSLayoutFormatOptions)options;

- (void)centerXOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview;
- (void)centerYOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview;
- (void)equalCenterOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview;

- (void)centerViewGroup:(NSArray *)views;
- (void)centerViewGroupInX:(NSArray *)views;
- (void)centerViewGroupInY:(NSArray *)views;
- (void)centerViewGroupInX:(NSArray *)views withFixedSpace:(CGFloat)space;
- (void)centerViewGroupInY:(NSArray *)views withFixedSpace:(CGFloat)space;
- (void)centerViewGroupInX:(NSArray *)views withFixedSpace:(CGFloat)space options:(NSLayoutFormatOptions)options;
- (void)centerViewGroupInY:(NSArray *)views withFixedSpace:(CGFloat)space options:(NSLayoutFormatOptions)options;
- (void)centerViewGroup:(NSArray *)views withDirection:(UIViewLayoutDirection)direction fixedSpace:(CGFloat)space options:(NSLayoutFormatOptions)options;

@end
