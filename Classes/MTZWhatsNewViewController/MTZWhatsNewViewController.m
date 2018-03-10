//
// MTZWhatsNewViewController.m
// What’s New
//
// Created by Matt Zanchelli on 5/17/14.
// Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

#import "SAMGradientView.h"

#import "NSLayoutConstraint+Common.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTZWhatsNewViewController ()

///	A private read/write property of `contentView`.
@property (readwrite) UIView *contentView;

///	A private read/write property of `contentInset`.
@property (readwrite) UIEdgeInsets contentInset;

///	The button to dismiss the view controller.
@property (nonatomic, strong) UIButton *dismissButton;

///	The background behind the dismiss button.
@property (nonatomic, strong) UIView *buttonBackground;

/// The constraint responsible for setting the height of the “Continue” button.
@property (nonatomic, strong) NSLayoutConstraint *buttonHeightConstraint;

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
	[self.view addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:self.contentView]];
	
	// Dismiss Button.
	self.buttonBackground = [[UIView alloc] init];
	[self.view addSubview:self.buttonBackground];
	self.buttonBackground.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraints:[NSLayoutConstraint constraintsToStickView:self.buttonBackground toEdges:UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight]];
	
	/* Blur Effect & Hairline */ {
		UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
		UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		[self.buttonBackground addSubview:blurView];
		blurView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:blurView]];
		UIView *hair = [[UIView alloc] init];
		hair.backgroundColor = [UIColor colorWithWhite:0.87f alpha:1];
		[self.buttonBackground addSubview:hair];
		hair.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addConstraints:[NSLayoutConstraint constraintsToStickView:hair toEdges:UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight]];
		CGFloat lineThickness = 1.0f / [[UIScreen mainScreen] scale];
		[hair addConstraint:[NSLayoutConstraint constraintToSetStaticHeight:lineThickness toView:hair]];
	}
	
	self.dismissButton = [[UIButton alloc] init];
	self.dismissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[self.buttonBackground addSubview:self.dismissButton];
	self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.dismissButton addTarget:self action:@selector(didTapContinueButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.buttonBackground attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.dismissButton attribute:NSLayoutAttributeTop  multiplier:1.0 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop  multiplier:1.0 constant:0]];
	[self.view addConstraints:[NSLayoutConstraint constraintsToStickView:self.dismissButton toEdges:UIRectEdgeLeft | UIRectEdgeRight]];
	
	self.buttonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0f constant:50];
	[self.view addConstraint:self.buttonHeightConstraint];
	
	[self reloadButtonHeight];
	
	// Defaults.
	self.backgroundGradientTopColor = [UIColor whiteColor];
	self.backgroundGradientBottomColor = [UIColor whiteColor];
	_style = MTZWhatsNewViewControllerStyleDarkContent;
	_automaticallySetStyle = YES;
	self.dismissButtonTitle = NSLocalizedStringFromTable(@"MTZWhatsNewContinueButtonTitle", @"WhatsNew", nil);
}

- (void)reloadButtonHeight
{
	UIFont *buttonFont = [UIFont systemFontOfSize:18.0f weight:UIFontWeightRegular];
	self.dismissButton.titleLabel.font = buttonFont;
	
	CGFloat buttonHeight = 50.0f;
	self.buttonHeightConstraint.constant = buttonHeight;
	
	self.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length + buttonHeight, 0);
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	[self reloadButtonHeight];
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
	CGFloat r, g, b, a;
	[color getRed:&r green:&g blue:&b alpha:&a];
	
	// Equation from http://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color/596243#596243
	CGFloat perception = 1.0f - ((0.299f * r) + (0.587f * g) + (0.114f * b));
	
	if (perception < 0.5) {
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
	// An empty implementation.
}
@end

NS_ASSUME_NONNULL_END
