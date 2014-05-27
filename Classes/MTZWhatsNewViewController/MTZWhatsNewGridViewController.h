//
//  MTZWhatsNewGridViewController.h
//  Podcasts
//
//  Created by Matt Zanchelli on 5/27/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

/// A What's New View Controller subclass that presents the features in a list or grid.
/// @discussion At the root of the features dictionary should be strings representing the app versions. Corresponding to each version string should be an array of features. Each feature should be a dictionary containing string values for any and all of the following: "title", "detail", and "icon". The value of "title" will be displayed in larger/bolder type. The value of "detail" will be displayed below title. The value of "icon" will be used to find an image resource in the app's bundle to use as a representation of the feature.
/*
 Example:
 {
	 "1.1" = (
		 {
			 icon = "Pull to Refresh";
			 title = "Pull to Refresh";
			 detail = "More easily refresh a subscription or playlist.";
		 },
		 {
			 icon = Stations;
			 title = "Custom Stations";
			 detail = "Create custom stations of your favorite podcasts.";
		 }
	 );
	 "2.0" = (
		 {
			 icon = "iOS 7";
			 title = "Designed for iOS 7";
			 detail = "Podcasts has a beautiful new look and feel that fits right in with iOS 7.";
		 },
		 {
			 icon = "Up To Date";
			 title = "Stay up to date";
			 detail = "Podcasts now automatically updates with new episodes.";
		 }
	 );
	 "3.0" = (
		 {
			 icon = Podcast;
			 title = "Unplayed Episodes";
			 detail = "Quickly find episodes you haven\U2019t played yet.";
		 },
		 {
			 icon = Feed;
			 title = "Browse the Feed";
			 detail = "Stream available episodes or download them to play later.";
		 },
		 {
			 icon = Saved;
			 title = "Saved Episodes";
			 detail = "Save your favorite episodes to ensure you\U2019ll always have them.";
		 },
		 {
			 icon = Delete;
			 title = "Delete Played Episodes";
			 detail = "Episodes can be automatically deleted after they are played.";
		 }
	 );
 }
 */
@interface MTZWhatsNewGridViewController : MTZWhatsNewViewController

///	Whether or not the icons should be treated as templates.
/// @discussion The default is @c YES.
@property (nonatomic) BOOL templatedIcons;

@end
