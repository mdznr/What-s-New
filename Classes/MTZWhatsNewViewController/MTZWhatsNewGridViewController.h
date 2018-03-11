//
//  MTZWhatsNewGridViewController.h
//  Podcasts
//
//  Created by Matt Zanchelli on 5/27/14.
//  Copyright © 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

NS_ASSUME_NONNULL_BEGIN

///	Describes the style of the title in the Whats New Grid View Controller.
typedef NS_ENUM(NSUInteger, MTZWhatsNewGridViewControllerTitleStyle) {
	/// The title is simply “What’s New”.
	MTZWhatsNewGridViewControllerTitleStyleSimple,
	/// The title is “What’s New in <APP NAME>”.
	MTZWhatsNewGridViewControllerTitleStyleRegular,
};

/// A What’s New View Controller subclass that presents the features in a list or grid.
@interface MTZWhatsNewGridViewController : MTZWhatsNewViewController

/// The style of the header of this view controller. See @c MTZWhatsNewGridViewControllerTitleStyle for more information.
/// @discussion The default is @c MTZWhatsNewGridViewControllerTitleStyleRegular.
@property (nonatomic, assign) MTZWhatsNewGridViewControllerTitleStyle titleStyle;

@end

NS_ASSUME_NONNULL_END
