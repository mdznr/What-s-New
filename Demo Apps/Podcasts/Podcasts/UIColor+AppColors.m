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
	return [UIColor colorWithHue:0.77 saturation:0.77 brightness:0.76 alpha:1.0];
}

+ (UIColor *)appGradientTopColor
{
	return [UIColor colorWithHue:0.77 saturation:0.77 brightness:0.76 alpha:1.0];
}

+ (UIColor *)appGradientBottomColor
{
	return [UIColor colorWithHue:0.78 saturation:0.60 brightness:0.95 alpha:1.0];
}

@end

NS_ASSUME_NONNULL_END
