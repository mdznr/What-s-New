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
	MTZWhatsNewViewControllerStyleDarkContent,
};

@interface MTZWhatsNewViewController : UIViewController

#pragma mark - Initialization

///	Initializes and returns a What's new view controller object having the given features.
///	@param features The features to display.
///	@return Returns an initialized @c MTZWhatsNewViewController object or @c nil if the object could not be successfully initialized.
/// @discussion See the documentation for @c features to see the expected format.
- (instancetype)initWithFeatures:(NSDictionary *)features;


#pragma mark - Managing the Content

///	All the features to display in the view controller.
@property (nonatomic, copy) NSDictionary *features;


#pragma mark - Accessing Views

///	Returns the content view of view controller. (read-only)
/// @discussion The content view of a @c MTZWhatsNewViewController object is the default superview for content displayed by the controller. If you want to customize it by simply adding additional views, you should add them to the content view so they will be positioned appropriately.
@property (nonatomic, readonly, retain) UIView *contentView;

///	The view used as the background of the view controller.
/// @discussion @c MTZWhatsNewViewController adds the background view as a subview behind all other views and uses its current frame location.
@property (nonatomic, retain) UIView *backgroundView;


#pragma mark - Appearance Customization

///	The style of what's new view controller.
/// @discussion Setting this turns @c automaticallySetStyle to @c NO . When @c automaticallySetStyle is set to @c YES , do not expect this value to be constant.
@property (nonatomic) MTZWhatsNewViewControllerStyle style;

///	Whether or not the style should be set automatically.
/// Default is @c YES. When @c automaticallySetStyle is set to @c YES , do not expect the value of @c style to be constant.
@property (nonatomic, getter = automaticallySetsStyle) BOOL automaticallySetStyle;

///	The color to display on the top of the background gradient.
@property (nonatomic, copy) UIColor *backgroundGradientTopColor;

///	The color to display on the top of the background gradient.
@property (nonatomic, copy) UIColor *backgroundGradientBottomColor;

///	The title of the dismiss button.
/// @discussion The default is @c NSLocalizedString(@"Get Started", nil).
@property (nonatomic, copy) NSString *dismissButtonTitle;


#pragma mark - Responding to Style Change

///	Notifies the view controller that the effective style has been changed.
/// @discussion This method is called when the style has been changed. You should override this method to perform custom tasks associated with changing the style. If you override this method, you must call super at some point in your implementation. Note that this can be called when the receiver's @c automaticallySetStyle is set to @c YES and not only after changes are made directly to the @c style property.
- (void)styleDidChange __attribute__((objc_requires_super));

///	The content inset to use in a subclss.
@property (nonatomic, readonly) UIEdgeInsets contentInset;

///	Notifies the view controller that the content inset has changed.
- (void)contentInsetDidChange __attribute__((objc_requires_super));

@end
