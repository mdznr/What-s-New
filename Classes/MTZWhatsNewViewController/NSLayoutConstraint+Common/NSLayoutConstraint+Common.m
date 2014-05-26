//
//  NSLayoutConstraint+Common.m
//  What's New
//
//  Created by Matt Zanchelli on 5/25/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "NSLayoutConstraint+Common.h"

@implementation NSLayoutConstraint (Common)


#pragma mark - Stretching to fill dimensions

+ (NSArray *)constraintsToFillToSuperview:(UIView *)view
{
	return [[self constraintsToStretchHorizontallyToSuperview:view] arrayByAddingObjectsFromArray:[self constraintsToStretchVerticallyToSuperview:view]];
}

+ (NSArray *)constraintsToStretchHorizontallyToSuperview:(UIView *)view;
{
	return [self constraintsToStretchToSuperview:view horizontallyOrVertically:@"H"];
}

+ (NSArray *)constraintsToStretchVerticallyToSuperview:(UIView *)view
{
	return [self constraintsToStretchToSuperview:view horizontallyOrVertically:@"V"];
}

///	Create constraints to fill a particular view to it's superview in one dimension.
///	@param view The subview to stretch fill to it's superview in one dimension.
///	@param horizontallyOrVertically @c @"H" or @c @"V" to signify horizontal or vertical stretch to superview.
///	@return An array of constraints to add to the superview to fill @c view to itself in one dimension.
+ (NSArray *)constraintsToStretchToSuperview:(UIView *)view horizontallyOrVertically:(NSString *)horizontallyOrVertically
{
	return [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"%@:|-0-[view]-0-|", horizontallyOrVertically] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"view": view}];
}


#pragma mark - Sticking to edges

+ (NSArray *)constraintsToStickView:(UIView *)view toEdges:(UIRectEdge)edges;
{
	NSArray *top, *left, *bottom, *right;
	
	if ( edges & UIRectEdgeTop ) {
		top = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[view]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"view": view}];
	}
	
	if ( edges & UIRectEdgeLeft ) {
		left = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[view]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"view": view}];
	}
	
	if ( edges & UIRectEdgeBottom ) {
		bottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-(0)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"view": view}];
	}
	
	if ( edges & UIRectEdgeRight ) {
		right = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]-(0)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"view": view}];
	}
	
	// Add all the constraints together and return them.
	NSArray *constraints = [[[[NSArray arrayWithArray:top] arrayByAddingObjectsFromArray:left] arrayByAddingObjectsFromArray:bottom] arrayByAddingObjectsFromArray:right];
	return constraints;
}


#pragma mark - Centering to superview

+ (NSLayoutConstraint *)constraintToCenterViewHorizontallyToSuperview:(UIView *)view
{
	return [NSLayoutConstraint constraintWithItem:view
										attribute:NSLayoutAttributeCenterX
										relatedBy:NSLayoutRelationEqual
										   toItem:view.superview
										attribute:NSLayoutAttributeCenterX
									   multiplier:1
										 constant:0];
}

+ (NSLayoutConstraint *)constraintToCenterViewVerticallyToSuperview:(UIView *)view
{
	return [NSLayoutConstraint constraintWithItem:view
										attribute:NSLayoutAttributeCenterY
										relatedBy:NSLayoutRelationEqual
										   toItem:view.superview
										attribute:NSLayoutAttributeCenterY
									   multiplier:1
										 constant:0];
}


#pragma mark - Setting size

+ (NSLayoutConstraint *)constraintToSetStaticHeight:(CGFloat)height toView:(UIView *)view
{
	return [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0f constant:height];
}

+ (NSLayoutConstraint *)constraintToSetStaticWidth:(CGFloat)width toView:(UIView *)view
{
	return [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0f constant:width];
}

@end
