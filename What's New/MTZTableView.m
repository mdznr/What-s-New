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
	
#warning call thsi when frame or contentSize changes?
	if (self.contentSize.height < self.frame.size.height) {
		self.scrollEnabled = NO;
	} else {
		self.scrollEnabled = YES;
	}
}

@end
