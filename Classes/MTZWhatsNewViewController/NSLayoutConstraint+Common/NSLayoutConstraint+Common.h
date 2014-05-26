//
//  NSLayoutConstraint+Common.h
//  What's New
//
//  Created by Matt Zanchelli on 5/25/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Common)


#pragma mark - Stretching to fill dimensions

///	Create constraints to fill a particular view to its superview.
///	@param view The subview to fill to its superview.
///	@return An array of constraints to add to the superview to fill @c view to itself.
+ (NSArray *)constraintsToFillToSuperview:(UIView *)view;

///	Create constraints to horizontally stretch a particular view to its superview.
///	@param view The subview to fill to its superview.
///	@return An array of constraints to add to the superview to stretch @c view horizontally to itself.
+ (NSArray *)constraintsToStretchHorizontallyToSuperview:(UIView *)view;

///	Create constraints to vertically stretch a particular view to its superview.
///	@param view The subview to fill to its superview.
///	@return An array of constraints to add to the superview to stretch @c view vertically to itself.
+ (NSArray *)constraintsToStretchVerticallyToSuperview:(UIView *)view;


#pragma mark - Centering to superview

///	Create a constraint to horizontally center a particular view to its superview.
///	@param view The subview to horizontally center to its superview.
///	@return A constraint to add to the superview to center @c view horizontally.
+ (NSLayoutConstraint *)constraintToCenterViewHorizontallyToSuperview:(UIView *)view;

///	Create a constraint to vertically center a particular view to its superview.
///	@param view The subview to vertically center to its superview.
///	@return A constraint to add to the superview to center @c view vertically.
+ (NSLayoutConstraint *)constraintToCenterViewVerticallyToSuperview:(UIView *)view;


#pragma mark - Sticking to edges

///	Create constraints to stick a particular view to edges of its superview.
///	@param view The subview to stick to its superview.
///	@param edges The edges to stick the subview to.
///	@return An array of constraints to add to the superview to stick @c view to its edges.
+ (NSArray *)constraintsToStickView:(UIView *)view toEdges:(UIRectEdge)edges;


#pragma mark - Setting Size

///	Create constraints to set the height of a particular view.
///	@param height The desired height of the view.
///	@param view The view to set the height of.
///	@return An array of constraints to add to @c view to create a fixed height.
+ (NSLayoutConstraint *)constraintToSetStaticHeight:(CGFloat)height toView:(UIView *)view;

///	Create constraints to set the width of a particular view.
///	@param height The desired width of the view.
///	@param view The view to set the width of.
///	@return An array of constraints to add to @c view to create a fixed width.
+ (NSLayoutConstraint *)constraintToSetStaticWidth:(CGFloat)width toView:(UIView *)view;

@end
