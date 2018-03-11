//
//  MTZTableView.m
//  What’s New
//
//  Created by Matt Zanchelli on 5/23/14.
//  Copyright © 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZTableView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIScrollView (ScrollingAbility)

- (void)determineScrollingAbility
{
	if ((self.contentSize.height > self.workingHeight) || (self.contentSize.width > self.workingWidth)) {
		self.scrollEnabled = YES;
	} else {
		self.scrollEnabled = NO;
		[self centerContent];
	}
}

- (void)centerContent
{
	CGFloat yOffset = ((self.contentSize.height - self.workingHeight) / 2.0);
	CGFloat xOffset = ((self.contentSize.width - self.workingWidth) / 2.0);
	[self setContentOffset:CGPointMake(xOffset, yOffset) animated:NO];
}

- (CGFloat)workingHeight
{
	return (self.frame.size.height - self.contentInset.top - self.contentInset.bottom);
}

- (CGFloat)workingWidth
{
	return (self.frame.size.width - self.contentInset.left - self.contentInset.right);
}

@end

@implementation MTZTableView

- (void)setContentSize:(CGSize)contentSize
{
	[super setContentSize:contentSize];
	[self determineScrollingAbility];
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	[self determineScrollingAbility];
}

@end

NS_ASSUME_NONNULL_END
