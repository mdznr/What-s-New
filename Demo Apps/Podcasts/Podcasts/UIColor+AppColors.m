//
//  UIColor+AppColors.m
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "UIColor+AppColors.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIColor (AppColors)

+ (UIColor *)appTintColor
{
	return [UIColor colorWithRed:0.4462 green:0.1423 blue:0.8474 alpha:1.0];
}

+ (UIColor *)appGradientTopColor
{
	return [UIColor colorWithRed:0.5166 green:0.1717 blue:0.7602 alpha:1.0];
}

+ (UIColor *)appGradientBottomColor
{
	return [UIColor colorWithRed:0.8392 green:0.4353 blue:0.9961 alpha:1.0];
}

@end

NS_ASSUME_NONNULL_END
