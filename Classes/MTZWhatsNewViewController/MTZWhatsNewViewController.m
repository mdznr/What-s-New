//
//  MTZWhatsNewViewController.m
//  What's New
//
//  Created by Matt Zanchelli on 5/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

#import "MTZCollectionView.h"
#import "MTZWhatsNewFeatureCollectionViewCell.h"

#import "SAMGradientView.h"

#import "UICollectionView+initWithCollectionViewLayout.h"
#import "NSLayoutConstraint+Common.h"

static const NSString *kTitle = @"title";
static const NSString *kDetail = @"detail";
static const NSString *kIconName = @"icon";

///	Describes the effective style of the view controller.
typedef NS_ENUM(NSUInteger, MTZWhatsNewViewControllerEffectiveStyle) {
	///	Describes a view controller with light text and content.
	MTZWhatsNewViewControllerEffectiveStyleLightContent,
	///	Describes a view controller with dark text and content.
	MTZWhatsNewViewControllerEffectiveStyleDarkContent,
};

@interface MTZWhatsNewViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

///	An ordered list of the versions from newest to oldest.
@property (strong, nonatomic) NSArray *orderedKeys;

///	The collection view to display all the new features.
@property (strong, nonatomic) MTZCollectionView *collectionView;

///	The gradient presented as the background.
@property (strong, nonatomic) SAMGradientView *backgroundGradientView;

///	The button to dismiss the view controller.
@property (strong, nonatomic) UIButton *dismissButton;

///	The effective style to use when @c style is @c MTZWhatsNewViewControllerStyleAutomatic.
@property (nonatomic) MTZWhatsNewViewControllerEffectiveStyle effectiveStyle;

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
	
	CGFloat buttonHeight = [self shouldUseGridLayout] ? 82.0f : 50.0f;
	CGSize itemSize = [self shouldUseGridLayout] ? CGSizeMake(270, 187) : CGSizeMake(320, 108);
	UIFont *buttonFont = [self shouldUseGridLayout] ? [UIFont fontWithName:@"HelveticaNeue-Light" size:29.0f] : [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
	
	// Background.
	self.backgroundGradientView = [[SAMGradientView alloc] init];
	[self.view addSubview:self.backgroundGradientView];
	self.backgroundGradientView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:self.backgroundGradientView]];
	self.backgroundGradientView.gradientColors = @[[UIColor clearColor], [UIColor clearColor]];
	self.backgroundGradientView.gradientLocations = @[@0.0, @1.0];
	
	// Feature collection view.
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.minimumLineSpacing = 2;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.itemSize = itemSize;
	flowLayout.sectionInset = UIEdgeInsetsZero;
	flowLayout.headerReferenceSize = flowLayout.footerReferenceSize = CGSizeZero;
	
	self.collectionView = [[MTZCollectionView alloc] initWithCollectionViewLayout:flowLayout];
	[self.view addSubview:self.collectionView];
	self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:self.collectionView]];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"whatsnew"];
	[self.collectionView registerClass:[MTZWhatsNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:@"feature"];
	UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, buttonHeight, 0);
	self.collectionView.contentInset = edgeInsets;
	self.collectionView.backgroundColor = [UIColor clearColor];
	self.collectionView.scrollIndicatorInsets = edgeInsets;
	
	// Get Started.
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
	self.backgroundGradientTopColor = [UIColor blackColor];
	self.backgroundGradientBottomColor = [UIColor blackColor];
	self.style = MTZWhatsNewViewControllerStyleAutomatic;
	self.dismissButtonText = NSLocalizedString(@"Get Started", nil);
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.collectionView flashScrollIndicators];
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
	_orderedKeys = [[_features allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj2 compare:obj1 options:NSNumericSearch];
	}];
	
	// Reload the collection view's data.
	[self.collectionView reloadData];
}

- (void)setStyle:(MTZWhatsNewViewControllerStyle)style
{
	_style = style;
	
	switch (_style) {
		case MTZWhatsNewViewControllerStyleLightContent:
			_effectiveStyle = MTZWhatsNewViewControllerEffectiveStyleDarkContent;
			break;
		case MTZWhatsNewViewControllerStyleDarkContent:
			_effectiveStyle = MTZWhatsNewViewControllerEffectiveStyleLightContent;
			break;
		case MTZWhatsNewViewControllerStyleAutomatic:
		default:
			_effectiveStyle = [self appropriateStyleForBackgroundColor:[self backgroundGradientTopColor]];
			break;
	}
	
	// Reload collection view to change styles.
	[self.collectionView reloadData];
	
	switch (_effectiveStyle) {
		case MTZWhatsNewViewControllerEffectiveStyleDarkContent:
			self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
			break;
		case MTZWhatsNewViewControllerEffectiveStyleLightContent:
			self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
			break;
	}
}

- (void)setBackgroundGradientTopColor:(UIColor *)topColor
{
	_backgroundGradientTopColor = [topColor copy];
	self.backgroundGradientView.gradientColors = @[_backgroundGradientTopColor, self.backgroundGradientView.gradientColors[1]];
}

- (void)setBackgroundGradientBottomColor:(UIColor *)bottomColor
{
	_backgroundGradientBottomColor = [bottomColor copy];
	self.backgroundGradientView.gradientColors = @[self.backgroundGradientView.gradientColors[0], _backgroundGradientBottomColor];
}

- (void)setDismissButtonText:(NSString *)dismissButtonText
{
	_dismissButtonText = dismissButtonText;
	[self.dismissButton setTitle:_dismissButtonText forState:UIControlStateNormal];
}


#pragma mark - Style

- (MTZWhatsNewViewControllerEffectiveStyle)appropriateStyleForBackgroundColor:(UIColor *)backgroundColor
{
	CGFloat r, g, b, a;
	[backgroundColor getRed:&r green:&g blue:&b alpha:&a];
	
	// Equation from http://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color/596243#596243
    CGFloat perception = 1.0f - ((0.299f * r) + (0.587f * g) + (0.114f * b));
	
    if ( perception < 0.5 ) {
		return MTZWhatsNewViewControllerEffectiveStyleDarkContent;
	} else {
		return MTZWhatsNewViewControllerEffectiveStyleLightContent;
	}
}

- (UIColor *)contentColor
{
	switch (_effectiveStyle) {
		case MTZWhatsNewViewControllerEffectiveStyleLightContent: return [UIColor whiteColor];
		case MTZWhatsNewViewControllerEffectiveStyleDarkContent:  return [UIColor blackColor];
	}
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
	// "What's New"
	if ( section == 0 ) {
		if ( [self shouldUseGridLayout] ) {
			return CGSizeMake(self.view.bounds.size.width, 115);
		} else {
			return CGSizeMake(self.view.bounds.size.width, 70);
		}
	}
	
	// No header for section.
	return CGSizeZero;
}


#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return [self.features count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	NSString *key = self.orderedKeys[section];
	return [self.features[key] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
		   viewForSupplementaryElementOfKind:(NSString *)kind
								 atIndexPath:(NSIndexPath *)indexPath
{
	UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"whatsnew" forIndexPath:indexPath];
	
	// Create label for "What's New" title.
	UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
	[view addSubview:label];
	label.translatesAutoresizingMaskIntoConstraints = NO;
	[view addConstraints:[NSLayoutConstraint constraintsToStretchHorizontallyToSuperview:label]];
	label.text = NSLocalizedString(@"What’s New", nil);
	label.textColor = [self contentColor];
	label.textAlignment = NSTextAlignmentCenter;
	
	// Larger font and divider.
	if ( [self shouldUseGridLayout] ) {
		label.font = [UIFont fontWithName:@"HelveticaNeue-Ultralight" size:62];
		label.translatesAutoresizingMaskIntoConstraints = NO;
		[label addConstraint:[NSLayoutConstraint constraintToSetStaticHeight:103 toView:label]];
		[view addConstraints:[NSLayoutConstraint constraintsToStickView:label toEdges:UIRectEdgeLeft|UIRectEdgeTop|UIRectEdgeRight]];
		
		// Add a visual divider.
		UIView *divider = [[UIView alloc] init];
		[view addSubview:divider];
		divider.translatesAutoresizingMaskIntoConstraints = NO;
		[divider addConstraint:[NSLayoutConstraint constraintToSetStaticWidth:296 toView:divider]];
		[divider addConstraint:[NSLayoutConstraint constraintToSetStaticHeight:0.5 toView:divider]];
		[view addConstraint:[NSLayoutConstraint constraintWithItem:divider attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
		[view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label][divider]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"label": label, @"divider": divider}]];
		divider.backgroundColor = [[self contentColor] colorWithAlphaComponent:0.75f];
	} else {
		label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
	}
	
	return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	MTZWhatsNewFeatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"feature" forIndexPath:indexPath];
	
	NSDictionary *feature = self.features[self.orderedKeys[indexPath.section]][indexPath.row];
	
	cell.title = feature[kTitle];
	cell.detail = feature[kDetail];
	NSString *iconName = feature[kIconName];
	if ( iconName ) {
		cell.icon = [UIImage imageNamed:iconName];
	}
	cell.contentColor = [self contentColor];
	cell.layoutStyle = [self shouldUseGridLayout] ? MTZWhatsNewFeatureCollectionViewCellLayoutStyleGrid : MTZWhatsNewFeatureCollectionViewCellLayoutStyleList;
	
	return cell;
}


#pragma mark - Helpers

- (BOOL)shouldUseGridLayout
{
	// iPhone width = 320
	// iPad's UIModalPresentationFormSheet width = 540
	return self.view.frame.size.width >= 512;
}


@end
