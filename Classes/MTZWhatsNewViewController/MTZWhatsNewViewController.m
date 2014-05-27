//
//  MTZWhatsNewViewController.m
//  What's New
//
//  Created by Matt Zanchelli on 5/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

#import "SAMGradientView.h"

#import "NSLayoutConstraint+Common.h"

@interface MTZWhatsNewViewController ()

///	A private read/write property of `contentView`.
@property (readwrite) UIView *contentView;

///	A private read/write property of `contentInsets`.
@property (readwrite) UIEdgeInsets contentInsets;

///	The button to dismiss the view controller.
@property (strong, nonatomic) UIButton *dismissButton;

@end


@implementation MTZWhatsNewViewController

- (instancetype)initWithFeatures:(NSDictionary *)features
{
	self = [super init];
	if (self) {
		[self commonInit];
		self.features = features;
	}
	return self;
}

- (id)init
{
	self = [super init];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit
{
	// Default modal transition and presentation styles.
	self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	self.modalPresentationStyle = UIModalPresentationFormSheet;
	
	CGFloat buttonHeight = [self shouldUseLargeButton] ? 82.0f : 50.0f;
	UIFont *buttonFont = [self shouldUseLargeButton] ? [UIFont fontWithName:@"HelveticaNeue-Light" size:29.0f] : [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
	self.contentInsets = UIEdgeInsetsMake(0, 0, buttonHeight, 0);
	
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
	UIToolbar *buttonBackground = [[UIToolbar alloc] init];
	[self.view addSubview:buttonBackground];
	buttonBackground.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraints:[NSLayoutConstraint constraintsToStickView:buttonBackground toEdges:UIRectEdgeLeft|UIRectEdgeBottom|UIRectEdgeRight]];
	[buttonBackground addConstraint:[NSLayoutConstraint constraintToSetStaticHeight:buttonHeight toView:buttonBackground]];
	
	self.dismissButton = [[UIButton alloc] init];
	self.dismissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[buttonBackground addSubview:self.dismissButton];
	self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.dismissButton.superview addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:self.dismissButton]];
	self.dismissButton.titleLabel.font = buttonFont;
	[self.dismissButton addTarget:self action:@selector(didTapContinueButton:) forControlEvents:UIControlEventTouchUpInside];
	
	// Defaults.
	self.backgroundGradientTopColor = [UIColor whiteColor];
	self.backgroundGradientBottomColor = [UIColor whiteColor];
	_style = MTZWhatsNewViewControllerStyleDarkContent;
	_automaticallySetStyle = YES;
	self.dismissButtonTitle = NSLocalizedString(@"Get Started", nil);
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
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


#pragma mark - Style

- (void)reloadAutomaticStyle
{
	if ( [self automaticallySetsStyle] ) {
		MTZWhatsNewViewControllerStyle newStyle = [self appropriateStyleForBackgroundOfColor:[self backgroundGradientTopColor]];
		if ( _style != newStyle ) {
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
	
    if ( perception < 0.5 ) {
		return MTZWhatsNewViewControllerStyleDarkContent;
	} else {
		return MTZWhatsNewViewControllerStyleLightContent;
	}
}

- (void)styleDidChange
{
	// An empty implementation.
}

- (BOOL)shouldUseLargeButton
{
	return self.view.frame.size.height >= 620 && self.view.frame.size.width >= 540;
}

@end
