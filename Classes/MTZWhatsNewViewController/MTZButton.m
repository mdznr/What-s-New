//
//  MTZButton.m
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "MTZButton.h"

#import "UIColor+PerceivedBrightness.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MTZButton

- (instancetype)init
{
	self = [super init];
	if (self) {
		_inverted = NO;
		self.titleLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
		self.layer.cornerRadius = 8.0f;
		[self _refreshColors];
	}
	return self;
}

- (void)tintColorDidChange
{
	[super tintColorDidChange];
	
	[self _refreshColors];
}

- (void)setInverted:(BOOL)isInverted
{
	_inverted = isInverted;
	
	[self _refreshColors];
}

- (void)_refreshColors
{
	UIColor *tintColor = self.tintColor;
	
	UIColor * _Nullable backgroundColor;
	UIColor * _Nullable textColor;
	if ([self isInverted]) {
		textColor = tintColor;
		backgroundColor = [UIColor whiteColor];
	} else {
		if (tintColor.perceivedBrightness < 0.5) {
			textColor = [UIColor blackColor];
		} else {
			textColor = [UIColor whiteColor];
		}
		backgroundColor = tintColor;
	}
	
	if ([self isHighlighted]) {
		backgroundColor = [backgroundColor colorWithAlphaComponent:0.5];
	}
	
	self.backgroundColor = backgroundColor;
	[self setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	
	[self _refreshColors];
}

@end

NS_ASSUME_NONNULL_END
