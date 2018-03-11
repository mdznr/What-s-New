//
//  UIColor+PerceivedBrightness.h
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (PerceivedBrightness)

/// The perceived brightness of a color on a scale from 0.0 to 1.0
@property (nonatomic, assign, readonly) CGFloat perceivedBrightness;

@end

NS_ASSUME_NONNULL_END
