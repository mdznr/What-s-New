//
//  MTZButton.h
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/// A button with a filled background
@interface MTZButton : UIButton

/// Whether or not the colors are inverted. Default is @c NO
/// @discussion When inverted, the background color is white and the text color is the tint color. Otherwise, the background color is the tint color and the text is white or black.
@property (nonatomic, assign, getter=isInverted) BOOL inverted;

@end

NS_ASSUME_NONNULL_END
