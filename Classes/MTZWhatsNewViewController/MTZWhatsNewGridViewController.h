//
// MTZWhatsNewGridViewController.h
// Podcasts
//
// Created by Matt Zanchelli on 5/27/14.
// Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

/// A What’s New View Controller subclass that presents the features in a list or grid.
@interface MTZWhatsNewGridViewController : MTZWhatsNewViewController

///	Whether or not the icons should be treated as templates.
/// @discussion The default is @c YES.
@property (nonatomic) BOOL templatedIcons;

@end
