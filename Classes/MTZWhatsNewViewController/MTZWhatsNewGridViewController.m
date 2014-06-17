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

/// All the features pooled together sorted by version number.
@property (strong, nonatomic) NSArray *allFeatures;

///	The collection view to display all the new features.
@property (strong, nonatomic) MTZCollectionView *collectionView;

///	The layout for the collection view.
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

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

- (void)__MTZWhatsNewGridViewController_Setup
{
	// Feature collection view.
	self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
	self.flowLayout.minimumLineSpacing = 2;
	self.flowLayout.minimumInteritemSpacing = 0;
	self.flowLayout.headerReferenceSize = self.flowLayout.footerReferenceSize = CGSizeZero;
	
	self.collectionView = [[MTZCollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
	[self.contentView addSubview:self.collectionView];
	self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:self.collectionView]];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"whatsnew"];
	[self.collectionView registerClass:[MTZWhatsNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:@"feature"];
	self.collectionView.backgroundColor = [UIColor clearColor];
	self.collectionView.contentInset = self.contentInset;
	self.collectionView.scrollIndicatorInsets = self.contentInset;
	[self calculateLayoutItemSize];
	
	// Defaults.
	self.templatedIcons = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.collectionView performSelector:@selector(flashScrollIndicators) withObject:nil afterDelay:0];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	[self calculateLayoutItemSize];
}

- (void)calculateLayoutItemSize
{
	CGSize itemSize = [self shouldUseGridLayout] ? CGSizeMake(270, 187) : CGSizeMake(320, 108);
	
	if ( CGSizeEqualToSize(self.flowLayout.itemSize, itemSize) ) return;
	
	self.flowLayout.itemSize = itemSize;
	
	UICollectionViewFlowLayoutInvalidationContext *ctx = [[UICollectionViewFlowLayoutInvalidationContext alloc] init];
	ctx.invalidateFlowLayoutAttributes = YES;
	ctx.invalidateFlowLayoutDelegateMetrics = YES;
	[self.flowLayout invalidateLayoutWithContext:ctx];
}

- (void)styleDidChange
{
	[super styleDidChange];
	
	// Reload collection view to change styles.
	[self.collectionView reloadData];
	
	switch (self.style) {
		case MTZWhatsNewViewControllerStyleDarkContent:
			self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
			break;
		case MTZWhatsNewViewControllerStyleLightContent:
			self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
			break;
	}
}

- (void)contentInsetDidChange
{
	[super contentInsetDidChange];
	self.collectionView.contentInset = self.contentInset;
	self.collectionView.scrollIndicatorInsets = self.contentInset;
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
	
	NSArray *orderedKeys = [[self.features allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj2 compare:obj1 options:NSNumericSearch];
	}];
	
	
	NSMutableArray *allFeatures = [[NSMutableArray alloc] init];
	for ( NSString *versionKey in orderedKeys ) {
		[allFeatures addObjectsFromArray:self.features[versionKey]];
	}
	self.allFeatures = allFeatures;
	
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
			return CGSizeMake(collectionView.bounds.size.width, 115);
		} else {
			return CGSizeMake(collectionView.bounds.size.width, 70);
		}
	}
	
	// No header for section.
	return CGSizeZero;
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
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.allFeatures count];
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
	[view addConstraints:[NSLayoutConstraint constraintsToStretchVerticallyToSuperview:label]];
	label.text = NSLocalizedString(@"What’s New", nil);
	label.textColor = [self contentColor];
	label.textAlignment = NSTextAlignmentCenter;
	
	// Larger font and divider.
	if ( [self shouldUseGridLayout] ) {
		label.font = [UIFont fontWithName:@"HelveticaNeue-Ultralight" size:62];
		label.translatesAutoresizingMaskIntoConstraints = NO;
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
	
	NSDictionary *feature = self.allFeatures[indexPath.row];
	
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
	return self.collectionView.bounds.size.width >= 540;
}

@end
