//
//  MTZWhatsNewGridViewController.m
//  Podcasts
//
//  Created by Matt Zanchelli on 5/27/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewGridViewController.h"

#import "MTZCollectionView.h"
#import "MTZWhatsNewFeatureCollectionViewCell.h"

#import "NSLayoutConstraint+Common.h"

static const NSString *kTitle = @"title";
static const NSString *kDetail = @"detail";
static const NSString *kIconName = @"icon";

@interface MTZWhatsNewGridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

///	An ordered list of the versions from newest to oldest.
@property (strong, nonatomic) NSArray *orderedKeys;

///	The collection view to display all the new features.
@property (strong, nonatomic) MTZCollectionView *collectionView;

@end


@implementation MTZWhatsNewGridViewController

#pragma mark - Initialization

- (instancetype)initWithFeatures:(NSDictionary *)features
{
	self = [super initWithFeatures:features];
	if (self) {
		[self __MTZWhatsNewGridViewController_Setup];
	}
	return self;
}

- (id)init
{
	self = [super init];
	if (self) {
		[self __MTZWhatsNewGridViewController_Setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self __MTZWhatsNewGridViewController_Setup];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[self __MTZWhatsNewGridViewController_Setup];
	}
	return self;
}

- (void)__MTZWhatsNewGridViewController_Setup
{
	// Feature collection view.
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.minimumLineSpacing = 2;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.headerReferenceSize = flowLayout.footerReferenceSize = CGSizeZero;
	
	self.collectionView = [[MTZCollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:flowLayout];
	[self.contentView addSubview:self.collectionView];
	self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:self.collectionView]];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"whatsnew"];
	[self.collectionView registerClass:[MTZWhatsNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:@"feature"];
	self.collectionView.backgroundColor = [UIColor clearColor];
//	UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, buttonHeight, 0);
//	self.collectionView.contentInset = edgeInsets;
//	self.collectionView.scrollIndicatorInsets = edgeInsets;
	
	// Defaults.
	self.templatedIcons = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.collectionView flashScrollIndicators];
}

- (void)styleDidChange
{
	// Reload collection view to change styles.
	[self.collectionView reloadData];
	
	switch (self.style) {
		case MTZWhatsNewViewControllerStyleDarkContent:
			self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
			break;
		case MTZWhatsNewViewControllerStyleLightContent:
			self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
			break;
		default:
			break;
	}
}

- (UIColor *)contentColor
{
	switch ( self.style ) {
		case MTZWhatsNewViewControllerStyleLightContent: return [UIColor whiteColor];
		case MTZWhatsNewViewControllerStyleDarkContent:  return [UIColor blackColor];
		default: return nil;
	}
}


#pragma mark - Properties

- (void)setFeatures:(NSDictionary *)features
{
	[super setFeatures:features];
	
	_orderedKeys = [[self.features allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj2 compare:obj1 options:NSNumericSearch];
	}];
	
	// Reload the collection view's data.
	[self.collectionView reloadData];
}

- (void)setTemplatedIcons:(BOOL)templatedIcons
{
	_templatedIcons = templatedIcons;
	// TODO: reload icons.
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if ( [self shouldUseGridLayout] ) {
		return CGSizeMake(270, 187);
	} else {
		return CGSizeMake(320, 108);
	}
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
						layout:(UICollectionViewLayout *)collectionViewLayout
		insetForSectionAtIndex:(NSInteger)section
{
	if ( section == 0 && [self shouldUseGridLayout] && [collectionView numberOfSections] <= 1 && [collectionView numberOfItemsInSection:section] <= 4 ) {
		return UIEdgeInsetsMake(16, 0, 0, 0);
	}
	
	return UIEdgeInsetsZero;
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
		if ( self.templatedIcons ) {
			cell.icon = [[UIImage imageNamed:iconName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		} else {
			cell.icon = [[UIImage imageNamed:iconName] imageWithRenderingMode:UIImageRenderingModeAutomatic];
		}
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
	return self.collectionView.frame.size.width >= 540;
}

@end
