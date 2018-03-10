//
//  UIColor+AppColors.h
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (AppColors)

/// The color to use as the tint color for the application
@property (class, nonatomic, copy, readonly) UIColor *appTintColor;

/// The color to use as the top color of a gradient for this application
@property (class, nonatomic, copy, readonly) UIColor *appGradientTopColor;

/// The color to use as the bottom color of a gradient for this application
@property (class, nonatomic, copy, readonly) UIColor *appGradientBottomColor;

@end

NS_ASSUME_NONNULL_END
