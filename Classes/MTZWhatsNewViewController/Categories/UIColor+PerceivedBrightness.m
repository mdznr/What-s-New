//
//  UIColor+PerceivedBrightness.m
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "UIColor+PerceivedBrightness.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIColor (PerceivedBrightness)

- (CGFloat)perceivedBrightness
{
	// Equation from http://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color/596243#596243
	CGFloat r, g, b, a;
	[self getRed:&r green:&g blue:&b alpha:&a];
	return (1.0f - ((0.299f * r) + (0.587f * g) + (0.114f * b)));
}

@end

NS_ASSUME_NONNULL_END
