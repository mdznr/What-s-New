//
//  SAMGradientView.m
//  SAMGradientView
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright (c) 2009-2014 Sam Soffes. All rights reserved.
//

#import "SAMGradientView.h"

@interface SAMGradientView ()
@property (nonatomic) CGGradientRef gradient;
@end

@implementation SAMGradientView

#pragma mark - Accessors

@synthesize gradient = _gradient;
@synthesize gradientColors = _gradientColors;
@synthesize gradientLocations = _gradientLocations;
@synthesize gradientMode = _gradientMode;
@synthesize gradientDirection = _gradientDirection;
@synthesize useThinBorders = _useThinBorders;
@synthesize topBorderColor = _topBorderColor;
@synthesize topInsetColor = _topInsetColor;
@synthesize rightBorderColor = _rightBorderColor;
@synthesize rightInsetColor = _rightInsetColor;
@synthesize bottomBorderColor = _bottomBorderColor;
@synthesize bottomInsetColor = _bottomInsetColor;
@synthesize leftBorderColor = _leftBorderColor;
@synthesize leftInsetColor = _leftInsetColor;

#ifdef __IPHONE_7_0
@synthesize dimmedGradientColors = _dimmedGradientColors;
#endif


- (void)setGradient:(CGGradientRef)gradient {
	if (_gradient) {
		CGGradientRelease(_gradient);
	}

	_gradient = gradient;
	[self setNeedsDisplay];
}


- (void)setGradientColors:(NSArray *)colors {
	_gradientColors = colors;
	[self refreshGradient];
}


- (void)setGradientLocations:(NSArray *)locations {
	_gradientLocations = locations;
	[self refreshGradient];
}


- (void)setGradientDirection:(SAMGradientViewDirection)direction {
	_gradientDirection = direction;
	[self setNeedsDisplay];
}


#ifdef __IPHONE_7_0
- (NSArray *)dimmedGradientColors {
	if (!_dimmedGradientColors) {
		NSMutableArray *dimmed = [self.gradientColors mutableCopy];
		[dimmed enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger index, BOOL *stop) {
			CGFloat hue, saturation, brightness, alpha;
			if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
				[dimmed replaceObjectAtIndex:index withObject:[UIColor colorWithHue:hue saturation:0.0f brightness:brightness alpha:alpha]];
			}
		}];
		return dimmed;
	}
	return _dimmedGradientColors;
}


- (void)setDimmedGradientColors:(NSArray *)colors {
	_dimmedGradientColors = colors;
	[self refreshGradient];
}
#endif


- (void)setUseThinBorders:(BOOL)useThinBorders {
	_useThinBorders = useThinBorders;
	[self setNeedsDisplay];
}


- (void)setTopBorderColor:(UIColor *)topBorderColor {
	_topBorderColor = topBorderColor;
	[self setNeedsDisplay];
}


- (void)setTopInsetColor:(UIColor *)topInsetColor {
	_topInsetColor = topInsetColor;
	[self setNeedsDisplay];
}


- (void)setRightBorderColor:(UIColor *)rightBorderColor {
	_rightBorderColor = rightBorderColor;
	[self setNeedsDisplay];
}


- (void)setRightInsetColor:(UIColor *)rightInsetColor {
	_rightInsetColor = rightInsetColor;
	[self setNeedsDisplay];
}


- (void)setBottomBorderColor:(UIColor *)bottomBorderColor {
	_bottomBorderColor = bottomBorderColor;
	[self setNeedsDisplay];
}


- (void)setBottomInsetColor:(UIColor *)bottomInsetColor {
	_bottomInsetColor = bottomInsetColor;
	[self setNeedsDisplay];
}


- (void)setLeftBorderColor:(UIColor *)leftBorderColor {
	_leftBorderColor = leftBorderColor;
	[self setNeedsDisplay];
}


- (void)setLeftInsetColor:(UIColor *)leftInsetColor {
	_leftInsetColor = leftInsetColor;
	[self setNeedsDisplay];
}


#pragma mark - NSObject

- (void)dealloc {
	self.gradient = nil;
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self initialize];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self initialize];
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGSize size = self.bounds.size;
	CGFloat borderWidth = self.useThinBorders ? 1.0f / [[UIScreen mainScreen] scale] : 1.0f;

	// Gradient
	if (self.gradient) {
		// Linear
		if (self.gradientMode == SAMGradientViewModeLinear) {
			CGPoint start = CGPointMake(0.0f, 0.0f);
			CGPoint end = (self.gradientDirection == SAMGradientViewDirectionVertical ? CGPointMake(0.0f, size.height) :
						   CGPointMake(size.width, 0.0f));
			CGContextDrawLinearGradient(context, self.gradient, start, end, kNilOptions);
		}

		// Radial
		else {
			CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
			CGContextDrawRadialGradient(context, self.gradient, center, 0.0f, center, size.width / 2.0f, kCGGradientDrawsAfterEndLocation);
		}
	}

	// Top
	if (self.topBorderColor) {
		// Top border
		CGContextSetFillColorWithColor(context, self.topBorderColor.CGColor);
		CGContextFillRect(context, CGRectMake(0.0f, 0.0f, size.width, borderWidth));

		// Top inset
		if (self.topInsetColor) {
			CGContextSetFillColorWithColor(context, self.topInsetColor.CGColor);
			CGContextFillRect(context, CGRectMake(0.0f, borderWidth, size.width, borderWidth));
		}
	}

	CGFloat sideY = self.topBorderColor ? borderWidth : 0.0f;
	CGFloat sideHeight = size.height;
	if (self.topBorderColor) {
		sideHeight -= borderWidth;
	}

	if (self.bottomBorderColor) {
		sideHeight -= borderWidth;
	}

	// Right
	if (self.rightBorderColor) {
		// Right inset
		if (self.rightInsetColor) {
			CGContextSetFillColorWithColor(context, self.rightInsetColor.CGColor);
			CGContextFillRect(context, CGRectMake(size.width - borderWidth - borderWidth, sideY, borderWidth, sideHeight));
		}

		// Right border
		CGContextSetFillColorWithColor(context, self.rightBorderColor.CGColor);
		CGContextFillRect(context, CGRectMake(size.width - borderWidth, sideY, borderWidth, sideHeight));
	}

	// Bottom
	if (self.bottomBorderColor) {
		// Bottom inset
		if (self.bottomInsetColor) {
			CGContextSetFillColorWithColor(context, self.bottomInsetColor.CGColor);
			CGContextFillRect(context, CGRectMake(0.0f, rect.size.height - borderWidth - borderWidth, size.width, borderWidth));
		}

		// Bottom border
		CGContextSetFillColorWithColor(context, self.bottomBorderColor.CGColor);
		CGContextFillRect(context, CGRectMake(0.0f, rect.size.height - borderWidth, size.width, borderWidth));
	}

	// Left
	if (self.leftBorderColor) {
		// Left inset
		if (self.leftInsetColor) {
			CGContextSetFillColorWithColor(context, self.leftInsetColor.CGColor);
			CGContextFillRect(context, CGRectMake(borderWidth, sideY, borderWidth, sideHeight));
		}

		// Left border
		CGContextSetFillColorWithColor(context, self.leftBorderColor.CGColor);
		CGContextFillRect(context, CGRectMake(0.0f, sideY, borderWidth, sideHeight));
	}
}


#ifdef __IPHONE_7_0
- (void)tintColorDidChange {
    [super tintColorDidChange];
	[self refreshGradient];
}
#endif


#pragma mark - Private

- (void)initialize {
	self.contentMode = UIViewContentModeRedraw;
}


- (void)refreshGradient {
#ifndef __clang_analyzer__ // It thinks the CGGradient is leaking, but we manage it in the property, so it's all good.
#ifdef __IPHONE_7_0
	if ([self respondsToSelector:@selector(tintAdjustmentMode)] && self.tintAdjustmentMode == UIViewTintAdjustmentModeDimmed) {
		NSArray *locations = self.dimmedGradientColors.count == self.gradientLocations.count ? self.gradientLocations : nil;
		self.gradient = SAMGradientCreateWithColorsAndLocations(self.dimmedGradientColors, locations);
		return;
	}
#endif
	self.gradient = SAMGradientCreateWithColorsAndLocations(self.gradientColors, self.gradientLocations);
#endif
}

@end


#pragma mark - Drawing Functions

CGGradientRef SAMGradientCreateWithColors(NSArray *colors) {
	return SAMGradientCreateWithColorsAndLocations(colors, nil);
}


CGGradientRef SAMGradientCreateWithColorsAndLocations(NSArray *colors, NSArray *locations) {
	NSUInteger colorsCount = [colors count];
	if (colorsCount < 2) {
		return nil;
	}

	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors objectAtIndex:0] CGColor]);

	NSMutableArray *gradientColors = [[NSMutableArray alloc] initWithCapacity:colorsCount];
	[colors enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[gradientColors addObject:(id)[(UIColor *)object CGColor]];
	}];

	CGFloat *gradientLocations = NULL;
	NSUInteger locationsCount = [locations count];
	if (locationsCount == colorsCount) {
		gradientLocations = (CGFloat *)malloc(sizeof(CGFloat) * locationsCount);
		[locations enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
			gradientLocations[index] = [object floatValue];
		}];
	}

	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);

	if (gradientLocations) {
		free(gradientLocations);
	}

	return gradient;
}


void SAMDrawGradientInRect(CGContextRef context, CGGradientRef gradient, CGRect rect) {
	CGContextSaveGState(context);
	CGContextClipToRect(context, rect);
	CGPoint start = CGPointMake(rect.origin.x, rect.origin.y);
	CGPoint end = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
	CGContextDrawLinearGradient(context, gradient, start, end, 0);
	CGContextRestoreGState(context);
}
