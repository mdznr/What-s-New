//
//  MTZWhatsNewViewController.m
//  What’s New
//
//  Created by Matt Zanchelli on 5/17/14.
//  Copyright © 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

#import "SAMGradientView.h"

#import "NSLayoutConstraint+Common.h"
#import "UIColor+PerceivedBrightness.h"

#import "MTZButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTZWhatsNewViewController ()

///	A private read/write property of `contentView`.
@property (readwrite) UIView *contentView;

///	A private read/write property of `contentInset`.
@property (readwrite) UIEdgeInsets contentInset;

///	The button to dismiss the view controller.
@property (nonatomic, strong) MTZButton *dismissButton;

@end


@implementation MTZWhatsNewViewController

- (instancetype)initWithFeatures:(NSDictionary<NSString *, id> *)features
{
	self = [super init];
	if (self) {
		[self __MTZWhatsNewViewController_SetUp];
		self.features = features;
	}
	return self;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self __MTZWhatsNewViewController_SetUp];
	}
	return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self __MTZWhatsNewViewController_SetUp];
	}
	return self;
}

- (void)__MTZWhatsNewViewController_SetUp
{
	// Default modal transition and presentation styles.
	self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	self.modalPresentationStyle = UIModalPresentationFormSheet;
	
	// Background View.
	SAMGradientView *gradientView = [[SAMGradientView alloc] init];
	self.backgroundView = gradientView;
	[self.view addSubview:self.backgroundView];
	self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:self.backgroundView]];
	gradientView.gradientColors = @[[UIColor clearColor], [UIColor clearColor]];
	gradientView.gradientLocations = @[@0.0, @1.0];
	
	// Content View.
	self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.contentView];
	self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
	[NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsToStickView:self.contentView toEdges:UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight]];
	
	// Dismiss Button.
	self.dismissButton = [[MTZButton alloc] init];
	[self.dismissButton addTarget:self action:@selector(didTapContinueButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.dismissButton];
	self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
	[NSLayoutConstraint activateConstraints:@[
		[NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:50.0f],
		[NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:288.0f],
		[NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f],
		[NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1.0f constant:-10.0f],
		[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.dismissButton attribute:NSLayoutAttributeTop multiplier:1.0f constant:-10.0f],
	]];
	
	[self _refreshInsets];
	
	// Defaults.
	self.backgroundGradientTopColor = [UIColor whiteColor];
	self.backgroundGradientBottomColor = [UIColor whiteColor];
	_style = MTZWhatsNewViewControllerStyleDarkContent;
	_automaticallySetStyle = YES;
	self.dismissButtonTitle = NSLocalizedStringFromTable(@"MTZWhatsNewContinueButtonTitle", @"WhatsNew", nil);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return (self.style == MTZWhatsNewViewControllerStyleLightContent) ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	[self _refreshInsets];
}

- (void)viewSafeAreaInsetsDidChange
{
	[super viewSafeAreaInsetsDidChange];

	[self _refreshInsets];
}

- (void)_refreshInsets
{
	if (@available(iOS 11.0, *)) {
		self.contentInset = UIEdgeInsetsMake(self.view.safeAreaInsets.top, self.view.safeAreaInsets.left, 0.0f, self.view.safeAreaInsets.right);
	} else {
		self.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0.0, 0.0, 0.0);
	}
}


#pragma mark - Actions

- (IBAction)didTapContinueButton:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Properties

- (void)setFeatures:(NSDictionary *)features
{
	_features = [features copy];
}

- (void)setStyle:(MTZWhatsNewViewControllerStyle)style
{
	_style = style;
	self.automaticallySetStyle = NO;
	
	[self styleDidChange];
}

- (void)setAutomaticallySetStyle:(BOOL)automaticallySetStyle
{
	_automaticallySetStyle = automaticallySetStyle;
	[self reloadAutomaticStyle];
}

- (void)setBackgroundGradientTopColor:(UIColor *)topColor
{
	_backgroundGradientTopColor = [topColor copy];
	SAMGradientView *gradientView = (SAMGradientView *) self.backgroundView;
	gradientView.gradientColors = @[_backgroundGradientTopColor, gradientView.gradientColors[1]];
	
	[self reloadAutomaticStyle];
}

- (void)setBackgroundGradientBottomColor:(UIColor *)bottomColor
{
	_backgroundGradientBottomColor = [bottomColor copy];
	SAMGradientView *gradientView = (SAMGradientView *) self.backgroundView;
	gradientView.gradientColors = @[gradientView.gradientColors[0], _backgroundGradientBottomColor];
	
	[self reloadAutomaticStyle];
}

- (void)setDismissButtonTitle:(NSString *)dismissButtonText
{
	_dismissButtonTitle = dismissButtonText;
	[self.dismissButton setTitle:_dismissButtonTitle forState:UIControlStateNormal];
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
	_contentInset = contentInset;
	[self contentInsetDidChange];
}


#pragma mark - Style

- (void)reloadAutomaticStyle
{
	if ([self automaticallySetsStyle]) {
		MTZWhatsNewViewControllerStyle newStyle = [self appropriateStyleForBackgroundOfColor:[self backgroundGradientTopColor]];
		if (_style != newStyle) {
			_style = newStyle;
			[self styleDidChange];
		}
	}
}

- (MTZWhatsNewViewControllerStyle)appropriateStyleForBackgroundOfColor:(UIColor *)color
{
	if (color.perceivedBrightness < 0.5) {
		return MTZWhatsNewViewControllerStyleDarkContent;
	} else {
		return MTZWhatsNewViewControllerStyleLightContent;
	}
}

- (void)contentInsetDidChange
{
	// An empty implementation.
}

- (void)styleDidChange
{
	[self setNeedsStatusBarAppearanceUpdate];
	
	self.dismissButton.inverted = (self.style == MTZWhatsNewViewControllerStyleLightContent);
}

@end

NS_ASSUME_NONNULL_END
