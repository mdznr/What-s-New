//
//  MTZTableView.m
//  What's New
//
//  Created by Matt Zanchelli on 5/19/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZTableView.h"

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

- (void)determineScrollingAbility
{
	if (self.contentSize.height <= self.frame.size.height &&
		self.contentSize.width <= self.frame.size.width) {
		self.scrollEnabled = NO;
	} else {
		self.scrollEnabled = YES;
	}
}

@end
