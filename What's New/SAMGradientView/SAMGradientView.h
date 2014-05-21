//
//  SAMGradientView.h
//  SAMGradientView
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright (c) 2009-2014 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Availability.h>

/**
 The mode of the gradient.
 */
typedef NS_ENUM(NSUInteger, SAMGradientViewMode) {
	/** A linear gradient. */
	SAMGradientViewModeLinear,

	/** A radial gradient. */
	SAMGradientViewModeRadial
};

/**
 The direction of the gradient.
 */
typedef NS_ENUM(NSUInteger, SAMGradientViewDirection) {
	/** The gradient is verticle. */
	SAMGradientViewDirectionVertical,

	/** The gradient is horizontal. */
	SAMGradientViewDirectionHorizontal
};


/**
 Simple `UIView` wrapper for `CGGradient`.
 */
@interface SAMGradientView : UIView

///---------------------------
/// @name Drawing the Gradient
///---------------------------

/**
 An array of `UIColor` objects used to draw the gradient. If the value is `nil`, the `backgroundColor` will be drawn
 instead of a gradient.

 The default is `nil`.
 */
@property (nonatomic, copy) NSArray *gradientColors;

#ifdef __IPHONE_7_0
/**
 An array of `UIColor` objects used to draw the dimmed gradient. If the value is `nil`, `gradientColors` will be
 converted to grayscale. This will use the same `gradientLocations` as `gradientColors`. If they don't match, bad things
 will happen. It is a good idea to make sure the number of dimmed colors equals the number of regular colors.

 The default is `nil`.
 */

@property (nonatomic, copy) NSArray *dimmedGradientColors;
#endif

/**
 An optional array of `NSNumber` objects defining the location of each gradient stop.

 The gradient stops are specified as values between `0` and `1`. The values must be monotonically
 increasing. If `nil`, the stops are spread uniformly across the range. Defaults to `nil`.
 */

@property (nonatomic, copy) NSArray *gradientLocations;

/**
 The mode of the gradient.

 The default is `SAMGradientViewModeLinear`.
 */
@property (nonatomic) SAMGradientViewMode gradientMode;

/**
 The direction of the gradient. Only valid for the `SAMGradientViewModeLinear` mode.

 The default is `SAMGradientViewDirectionVertical`.
 */
@property (nonatomic) SAMGradientViewDirection gradientDirection;


///--------------------------
/// @name Drawing the Borders
///--------------------------

/**
 Use thin borders.

 1px borders will be drawn instead of 1pt borders. The default is `NO`.
 */
@property (nonatomic) BOOL useThinBorders;

/**
 The top border color. The default is `nil`.

 @see topInsetColor
 */
@property (nonatomic, strong) UIColor *topBorderColor;

/**
 The top inset color. The default is `nil`.

 @see topBorderColor
 */
@property (nonatomic, strong) UIColor *topInsetColor;

/**
 The right border color. The default is `nil`.

 @see rightInsetColor
 */
@property (nonatomic, strong) UIColor *rightBorderColor;

/**
 The right inset color. The default is `nil`.

 @see rightBorderColor
 */
@property (nonatomic, strong) UIColor *rightInsetColor;

/**
 The bottom border color. The default is `nil`.

 @see bottomInsetColor
 */
@property (nonatomic, strong) UIColor *bottomBorderColor;

/**
 The bottom inset color. The default is `nil`.

 @see bottomBorderColor
 */
@property (nonatomic, strong) UIColor *bottomInsetColor;

/**
 The left border color. The default is `nil`.

 @see leftInsetColor
 */
@property (nonatomic, strong) UIColor *leftBorderColor;

/**
 The left inset color. The default is `nil`.

 @see leftBorderColor
 */
@property (nonatomic, strong) UIColor *leftInsetColor;

@end


///-------------------------
/// @name Creating Gradients
///-------------------------

/**
 Create a CGGradient with an array of UIColors.

 @return CGGradientRef
 */
extern CGGradientRef SAMGradientCreateWithColors(NSArray *colors) CF_RETURNS_RETAINED;

/**
 Create a CGGradient with an array of UIColors and NSNumbers for locations.

 @return CGGradientRef
 */
extern CGGradientRef SAMGradientCreateWithColorsAndLocations(NSArray *colors, NSArray *locations) CF_RETURNS_RETAINED;


///------------------------
/// @name Drawing Gradients
///------------------------

/**
 Draw a CGGraident into a rect. This handles cliping the gradient for you.
 */
extern void SAMDrawGradientInRect(CGContextRef context, CGGradientRef gradient, CGRect rect);
