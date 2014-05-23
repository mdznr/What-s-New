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
	///	Describes a view controller with light text and content.
	MTZWhatsNewViewControllerStyleLightContent,
	///	Describes a view controller with dark text and content.
	MTZWhatsNewViewControllerStyleDarkContent
};

@interface MTZWhatsNewViewController : UIViewController

///	All the features to display in the view controller.
@property (nonatomic, copy) NSDictionary *features;


#pragma mark - Appearance Customization

#warning Option for  scrollview or wordcloud?

///	The style of what's new view controller.
/// Default is @c MTZWhatsNewViewControllerStyleLightContent.
@property (nonatomic) MTZWhatsNewViewControllerStyle style;

///	The color to display on the top of the background gradient.
@property (nonatomic, copy) UIColor *topColor;

///	The color to display on the top of the background gradient.
@property (nonatomic, copy) UIColor *bottomColor;

@end
