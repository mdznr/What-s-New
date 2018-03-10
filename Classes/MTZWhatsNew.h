//
// MTZWhatsNew.h
//
// MTZWhatsNew created by Matt Zanchelli on 5/16/14.
// Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

//
// Based off of MTMigration created by Parker Wightman on 2/7/13.
// Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

/*
 Copyright (c) 2012, Mysterious Trousers
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

@import Foundation;

#import "MTZWhatsNewViewController.h"

/// A block that gets called when there’s new stuff to handle.
/// @discussion At the root of the features dictionary should be strings representing the app versions. Corresponding to each version string should be an array of features. Each feature should be a dictionary containing string values for any and all of the following: "title", "detail", and "icon". The value of "title" will be displayed in larger/bolder type. The value of "detail" will be displayed below title. The value of "icon" will be used to find an image resource in the app’s bundle to use as a representation of the feature.
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
typedef void (^MTZWhatsNewHandler)(NSDictionary<NSString *, id> *whatsNew);

/// The class that manages what’s new in an application.
@interface MTZWhatsNew : NSObject

///	Show what’s new in this update, if anything.
/// @param whatsNewHandler A block called to handle what’s new, if there’s anything new at all.
/// @discussion Call this on every app launch to keep track of used versions.
+ (void)handleWhatsNew:(MTZWhatsNewHandler)whatsNewHandler;

///
/// @param whatsNewHandler A block called to handle what’s new, if there’s anything new at all.
/// @param versionString A string representing the version to show changes since.
/// @discussion Only use this if you wish to show changes since a specific version. Typically, only the @c handleWhatsNew: method is need. If wishing to only show the changes since the last version used, use @c handleWhatsNew: instead.
+ (void)handleWhatsNew:(MTZWhatsNewHandler)whatsNewHandler sinceVersion:(NSString *)versionString;

///	Clears the last migration remembered by @c MTZWhatsNew. Causes migration to run from the beginning.
+ (void)reset;

@end
