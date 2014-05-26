//
//  MTZWhatsNewViewController.h
//  What's New
//
//  Created by Matt Zanchelli on 5/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

///	Describes the style of the view controller.
typedef NS_ENUM(NSUInteger, MTZWhatsNewViewControllerStyle) {
	///	Describes a view controller that automatically determines whether to use light or dark text.
	MTZWhatsNewViewControllerStyleAutomatic,
	///	Describes a view controller with light text and content.
	MTZWhatsNewViewControllerStyleLightContent,
	///	Describes a view controller with dark text and content.
	MTZWhatsNewViewControllerStyleDarkContent,
};

@interface MTZWhatsNewViewController : UIViewController

///	Initializes and returns a What's new view controller object having the given features.
///	@param features The features to display.
///	@return Returns an initialized @c MTZWhatsNewViewController object or @c nil if the object could not be successfully initialized.
/// @discussion See the documentation for @c features to see the expected format.
- (instancetype)initWithFeatures:(NSDictionary *)features;

///	All the features to display in the view controller.
/// @discussion At the root of the dictionary should be the version strings. Corresponding to each version string should be an array of features. Each feature should be a dictionary containing string values for any and all of the following: "title", "detail", and "icon". The value of "title" will be displayed in larger/bolder type. The value of "detail" will be displayed below title. The value of "icon" will be used to find an image resource in the app's bundle to use as a representation of the feature.
/*
 Example:
 {
	 "1.1" = (
		 {
			 detail = "More easily refresh a subscription or playlist.";
			 title = "Pull to Refresh";
		 }
	 );
	 "1.2" = (
		 {
			 detail = "Create custom stations of your favorite podcasts.";
			 icon = Stations;
			 title = "Custom Stations";
		 }
	 );
	 "2.0" = (
		 {
			 detail = "Podcasts has a beautiful new look and feel that fits right in with iOS 7.";
			 icon = "iOS 7";
			 title = "Designed for iOS 7";
		 },
		 {
			 detail = "Podcasts now automatically updates with new episodes.";
			 icon = "Up To Date";
			 title = "Stay up to date";
		 }
	 );
	 "3.0" = (
		 {
			 detail = "Quickly find episodes you haven\U2019t played yet.";
			 icon = Podcast;
			 title = "Unplayed Episodes";
		 },
		 {
			 detail = "Stream available episodes or download them to play later.";
			 icon = Feed;
			 title = "Browse the Feed";
		 },
		 {
			 detail = "Save your favorite episodes to ensure you\U2019ll always have them.";
			 icon = Saved;
			 title = "Saved Episodes";
		 },
		 {
			 detail = "Episodes can be automatically deleted after they are played.";
			 icon = Delete;
			 title = "Delete Played Episodes";
		 }
	 );
 }
 */
@property (nonatomic, copy) NSDictionary *features;


#pragma mark - Appearance Customization

///	The style of what's new view controller.
/// Default is @c MTZWhatsNewViewControllerStyleAutomatic.
@property (nonatomic) MTZWhatsNewViewControllerStyle style;

///	The color to display on the top of the background gradient.
@property (nonatomic, copy) UIColor *backgroundGradientTopColor;

///	The color to display on the top of the background gradient.
@property (nonatomic, copy) UIColor *backgroundGradientBottomColor;

///	The text to display on the dismiss button.
/// @discussion The default is @c @"Get Started".
@property (nonatomic, copy) NSString *dismissButtonText;

@end
