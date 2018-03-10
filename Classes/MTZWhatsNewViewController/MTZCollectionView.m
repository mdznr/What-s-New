//
// MTZCollectionView.m
// What’s New
//
// Created by Matt Zanchelli on 5/23/14.
// Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIScrollView (ScrollingAbility)

- (void)determineScrollingAbility
{
	self.scrollEnabled = self.contentSize.height > self.frame.size.height || self.contentSize.width > self.frame.size.width;
}

@end

@implementation MTZCollectionView

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
