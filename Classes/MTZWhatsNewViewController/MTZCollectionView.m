//
// MTZCollectionView.m
// What’s New
//
// Created by Matt Zanchelli on 5/23/14.
// Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZCollectionView.h"

@implementation UIScrollView (ScrollingAbility)

- (void)determineScrollingAbility
{
    int buttonHeight;
    if(self.frame.size.height >= 620 && self.frame.size.width >= 540) {
        buttonHeight = 82;
    } else {
        buttonHeight = 50;
    }
    
    if (self.contentSize.height <= self.frame.size.height - buttonHeight &&
        self.contentSize.width <= self.frame.size.width) {
        self.scrollEnabled = NO;
    } else {
        self.scrollEnabled = YES;
    }
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
