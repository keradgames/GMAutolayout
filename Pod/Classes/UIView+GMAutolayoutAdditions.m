//
//  UIView+GMAutolayoutAdditions.m
//  GoldenManager
//
//  Created by Joan Romano on 19/05/14.
//  Copyright (c) 2014 Kerad Games. All rights reserved.
//

#import "UIView+GMAutolayoutAdditions.h"

CGFloat const GMAutolayoutStandardFixedViewToViewSpace = 8.0f;
CGFloat const GMAutolayoutStandardFixedViewToSuperviewSpace = 20.0f;

@implementation UIView (GMAutolayoutAdditions)

#pragma mark - Constructors

+ (instancetype)newAutolayoutView
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    return view;
}

#pragma mark - Remove constraints

- (void)removeOwnAndSubviewsContraints
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self removeConstraints:self.constraints];
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        [subview removeConstraints:subview.constraints];
    }];
}

#pragma mark - Size constraining

- (void)constrainToSize:(CGSize)size
{
    [self constrainToWidth:size.width];
    [self constrainToHeight:size.height];
}

- (void)constrainToWidth:(CGFloat)width
{
    NSString *formatString = @"H:[view(==width)]";
    NSDictionary *bindings = @{@"view": self};
    NSDictionary *metrics = @{@"width":@(width)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:metrics views:bindings];
    
    [self addConstraints:constraints];
}

- (void)constrainToHeight:(CGFloat)height
{
    NSString *formatString = @"V:[view(==height)]";
    NSDictionary *bindings = @{@"view": self};
    NSDictionary *metrics = @{@"height":@(height)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:metrics views:bindings];
    
    [self addConstraints:constraints];
}

- (void)equalSizeOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
}

- (void)equalWidthOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview multiplier:(CGFloat)multiplier
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeWidth multiplier:multiplier constant:0.0]];
}

- (void)equalHeightOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview multiplier:(CGFloat)multiplier
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeHeight multiplier:multiplier constant:0.0]];
}

#pragma mark - Align in superview constraining

- (void)alignLeftInSuperview
{
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0f constant:0.0f]];
}

- (void)alignRightInSuperview
{
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0f constant:0.0f]];
}

- (void)alignBottomInSuperview
{
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0f constant:0.0f]];
}

- (void)alignTopInSuperview
{
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0f constant:0.0f]];
}

#pragma mark - Align subviews

- (void)centerXOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
}

- (void)centerYOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (void)equalCenterOfSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview
{
    [self centerXOfSubview:firstSubview withSubview:secondSubview];
    [self centerYOfSubview:firstSubview withSubview:secondSubview];
}

#pragma mark - Pin subviews

- (void)pinSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview withDirection:(UIViewLayoutDirection)direction
{
    [self pinSubview:firstSubview withSubview:secondSubview withDirection:direction fixedSpace:GMAutolayoutStandardFixedViewToViewSpace];
}

- (void)pinSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview withDirection:(UIViewLayoutDirection)direction fixedSpace:(CGFloat)space
{
    [self pinSubview:firstSubview withSubview:secondSubview withDirection:direction fixedSpace:space options:0];
}

- (void)pinSubview:(UIView *)firstSubview withSubview:(UIView *)secondSubview withDirection:(UIViewLayoutDirection)direction fixedSpace:(CGFloat)space options:(NSLayoutFormatOptions)options
{
    NSString *formatString = [NSString stringWithFormat:@"%@:[firstSubview]-space-[secondSubview]", direction == UIViewLayoutDirectionHorizontal ? @"H" : @"V"];
    NSDictionary *bindings = @{@"firstSubview": firstSubview, @"secondSubview": secondSubview};
    NSDictionary *metrics = @{@"space":@(space)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:options metrics:metrics views:bindings];
    
    [self addConstraints:constraints];
}

#pragma mark - Fill in superview constraining

- (void)fillInSuperview
{
    [self horizontallyFillInSuperview];
    [self verticallyFillInSuperview];
}

- (void)verticallyFillInSuperview
{
    [self.superview fillViewGroup:@[self] withDirection:UIViewLayoutDirectionVertical];
}

- (void)horizontallyFillInSuperview
{
    [self.superview fillViewGroup:@[self] withDirection:UIViewLayoutDirectionHorizontal];
}

- (void)fillViewGroup:(NSArray *)views withDirection:(UIViewLayoutDirection)direction
{
    [self fillViewGroup:views withDirection:direction options:0 fixedSpace:0];
}

- (void)fillViewGroup:(NSArray *)views withDirection:(UIViewLayoutDirection)direction options:(NSLayoutFormatOptions)options
{
    [self fillViewGroup:views withDirection:direction options:options fixedSpace:0];
}

- (void)fillViewGroup:(NSArray *)views withDirection:(UIViewLayoutDirection)direction options:(NSLayoutFormatOptions)options fixedSpace:(CGFloat)space
{
    if (![views count])
    {
        return;   
    }
    
    NSDictionary *metrics = @{@"space":@(space)};
    NSMutableString *mutableConstraint = [[NSString stringWithFormat:@"%@:|",
                                           direction == UIViewLayoutDirectionHorizontal ? @"H" : @"V"] mutableCopy];
    NSMutableDictionary *viewsMutableDictionary = [NSMutableDictionary dictionary];
    
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop)
    {
        
        unsigned long index = (unsigned long) idx;
        
        NSString *viewConstraintString = index == 0 ? [NSString stringWithFormat:@"[view%lu]", index] :
        [NSString stringWithFormat:@"-space-[view%lu]", index],
        *viewKeyString = [NSString stringWithFormat:@"view%lu", index];
        
        [mutableConstraint appendString:viewConstraintString];
        [viewsMutableDictionary setObject:view forKey:viewKeyString];
    }];
    
    [mutableConstraint appendString:@"|"];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[mutableConstraint copy] options:options metrics:metrics views:[viewsMutableDictionary copy]]];
}

#pragma mark - Center in superview constraining

- (void)centerInSuperview
{
    [self centerXInSuperview];
    [self centerYInSuperview];
}

- (void)centerXInSuperview
{
    if (self.superview)
    {
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.superview
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0f
                                                                    constant:0.0f]];
    }
}

- (void)centerYInSuperview
{
    if (self.superview)
    {
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.superview
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.0f
                                                                    constant:0.0f]];
    }
}

- (void)centerViewGroup:(NSArray *)views
{
    [self centerViewGroupInX:views];
    [self centerViewGroupInY:views];
}

- (void)centerViewGroupInX:(NSArray *)views
{
    [self centerViewGroupInX:views withFixedSpace:GMAutolayoutStandardFixedViewToViewSpace];
}

- (void)centerViewGroupInX:(NSArray *)views withFixedSpace:(CGFloat)space
{
    [self centerViewGroupInX:views withFixedSpace:space options:0];
}

- (void)centerViewGroupInX:(NSArray *)views withFixedSpace:(CGFloat)space options:(NSLayoutFormatOptions)options
{
    [self centerViewGroup:views withDirection:UIViewLayoutDirectionHorizontal fixedSpace:space options:options];
}

- (void)centerViewGroupInY:(NSArray *)views
{
    [self centerViewGroupInY:views withFixedSpace:GMAutolayoutStandardFixedViewToViewSpace];
}

- (void)centerViewGroupInY:(NSArray *)views withFixedSpace:(CGFloat)space
{
    [self centerViewGroupInY:views withFixedSpace:space options:0];
}

- (void)centerViewGroupInY:(NSArray *)views withFixedSpace:(CGFloat)space options:(NSLayoutFormatOptions)options
{
    [self centerViewGroup:views withDirection:UIViewLayoutDirectionVertical fixedSpace:space options:options];
}

- (void)centerViewGroup:(NSArray *)views withDirection:(UIViewLayoutDirection)direction fixedSpace:(CGFloat)space options:(NSLayoutFormatOptions)options
{
    if (![views count])
    {
        return;   
    }
    
    NSMutableString *mutableConstraint = [[NSString stringWithFormat:@"%@:|[topSpacer(==bottomSpacer)]", direction == UIViewLayoutDirectionHorizontal ? @"H" : @"V"] mutableCopy];
    UIView *topSpacer, *bottomSpacer;
    NSDictionary *metrics = @{@"space":@(space)};
    NSMutableDictionary *viewsMutableDictionary = [NSMutableDictionary dictionary];
    
    topSpacer = [UIView newAutolayoutView];
    bottomSpacer = [UIView newAutolayoutView];
    
    [self insertSubview:topSpacer aboveSubview:views[0]];
    [self insertSubview:bottomSpacer belowSubview:[views lastObject]];
    
    [viewsMutableDictionary setObject:topSpacer forKey:@"topSpacer"];
    [viewsMutableDictionary setObject:bottomSpacer forKey:@"bottomSpacer"];
    
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop)
    {
        
        unsigned long index = (unsigned long) idx;
        
        NSString *viewConstraintString = index == 0 ? [NSString stringWithFormat:@"[view%lu]", index]
        : [NSString stringWithFormat:@"-space-[view%lu]", index],
        *viewKeyString = [NSString stringWithFormat:@"view%lu", index];
        [mutableConstraint appendString:viewConstraintString];
        [viewsMutableDictionary setObject:view forKey:viewKeyString];
    }];
    
    [mutableConstraint appendString:@"[bottomSpacer]|"];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[mutableConstraint copy] options:options metrics:metrics views:[viewsMutableDictionary copy]]];
}

@end
