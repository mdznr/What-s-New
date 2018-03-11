//
//  MTZWhatsNewListViewController.m
//  Podcasts
//
//  Created by Matt Zanchelli on 5/27/14.
//  Copyright © 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewListViewController.h"

#import "MTZTableView.h"
#import "MTZWhatsNewFeatureTableViewCell.h"
#import "MTZWhatsNewFeatureTableViewCell+Feature.h"

#import "NSBundle+DisplayName.h"
#import "NSLayoutConstraint+Common.h"
#import "UITableView+CellReuse.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MTZWhatsNewListViewControllerTitleStyle_Private) {
	/// The title is “What’s New in <APP NAME>” where “<APP NAME>” is dispalyed in the view controller’s tint color.
	MTZWhatsNewListViewControllerTitleStyleColored = 3,
};

@interface MTZWhatsNewListViewController ()

/// All the features pooled together sorted by version number.
@property (nonatomic, strong) NSArray *allFeatures;

///	The table view to display all the new features.
@property (nonatomic, strong) MTZTableView *tableView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface MTZWhatsNewListViewController (UITableViewDelegate) <UITableViewDelegate>

@end

@interface MTZWhatsNewListViewController (UITableViewDataSource) <UITableViewDataSource>

@end


@implementation MTZWhatsNewListViewController

#pragma mark - Initialization

- (instancetype)initWithFeatures:(NSDictionary<NSString *, id> *)features
{
	self = [super initWithFeatures:features];
	if (self) {
		[self __MTZWhatsNewListViewController_Setup];
	}
	return self;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self __MTZWhatsNewListViewController_Setup];
	}
	return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self __MTZWhatsNewListViewController_Setup];
	}
	return self;
}

- (void)__MTZWhatsNewListViewController_Setup
{
	self.tableView = [[MTZTableView alloc] initWithFrame:self.contentView.bounds];
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.contentView addSubview:self.tableView];
	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addConstraints:[NSLayoutConstraint constraintsToFillToSuperview:self.tableView]];
	
	[self.tableView registerCellClass:[MTZWhatsNewFeatureTableViewCell class]];
	
	// Set default property values.
	self.titleStyle = MTZWhatsNewListViewControllerTitleStyleRegular;
	
	/* Table Header View (“What’s New”) */ {
		CGRect frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 142.0);
		UIView *tableHeaderView = [[UIView alloc] initWithFrame:frame];
		tableHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		UILabel *label = [[UILabel alloc] init];
		label.numberOfLines = 0;
		label.font = [UIFont systemFontOfSize:34.0f weight:UIFontWeightBold];
		label.textColor = [self contentColor];
		label.textAlignment = NSTextAlignmentCenter;
		
		[tableHeaderView addSubview:label];
		label.translatesAutoresizingMaskIntoConstraints = NO;
		[NSLayoutConstraint activateConstraints:@[
			[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:tableHeaderView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0],
			[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:tableHeaderView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0],
			[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:tableHeaderView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-29.0],
			[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tableHeaderView attribute:NSLayoutAttributeTop multiplier:1.0 constant:30.0],
		]];
		
		self.tableView.tableHeaderView = tableHeaderView;
		self.titleLabel = label;
		
		[self _reloadTitle];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self.tableView performSelector:@selector(flashScrollIndicators) withObject:nil afterDelay:0];
}

- (void)contentInsetDidChange
{
	[super contentInsetDidChange];
	
	self.tableView.contentInset = self.contentInset;
}

- (void)styleDidChange
{
	[super styleDidChange];
	
	self.titleLabel.textColor = [self contentColor];
	
	// Reload table view to change styles for all the cells.
	[self.tableView reloadData];
	
	// Set the scroll view indicator style based on our style.
	UIScrollViewIndicatorStyle indicatorStyle;
	switch (self.style) {
		case MTZWhatsNewViewControllerStyleLightContent: {
			indicatorStyle = UIScrollViewIndicatorStyleWhite;
		} break;
			
		case MTZWhatsNewViewControllerStyleDarkContent: {
			indicatorStyle = UIScrollViewIndicatorStyleBlack;
		} break;
			
		default: {
			indicatorStyle = UIScrollViewIndicatorStyleDefault;
		} break;
	}
	self.tableView.indicatorStyle = indicatorStyle;
}

- (UIColor *)contentColor
{
	switch (self.style) {
		case MTZWhatsNewViewControllerStyleLightContent:
			return [UIColor whiteColor];
			
		case MTZWhatsNewViewControllerStyleDarkContent:
			return [UIColor blackColor];
			
		default:
			return nil;
	}
}


#pragma mark - Properties

- (void)setFeatures:(NSDictionary<NSString *, id> *)features
{
	[super setFeatures:features];
	
	NSArray *orderedKeys = [[self.features allKeys] sortedArrayUsingComparator:^NSComparisonResult (id obj1, id obj2) {
		return [obj2 compare:obj1 options:NSNumericSearch];
	}];
	
	
	NSMutableArray *allFeatures = [[NSMutableArray alloc] init];
	for (NSString *versionKey in orderedKeys) {
		[allFeatures addObjectsFromArray:self.features[versionKey]];
	}
	self.allFeatures = allFeatures;
	
	// Reload the table view’s data.
	[self.tableView reloadData];
}

- (void)setTitleStyle:(MTZWhatsNewListViewControllerTitleStyle)titleStyle
{
	_titleStyle = titleStyle;
	
	[self _reloadTitle];
}

- (void)_reloadTitle
{
	switch (self.titleStyle) {
		case MTZWhatsNewListViewControllerTitleStyleRegular: {
			NSString *displayName = NSBundle.mainBundle.displayName;
			if (displayName) {
				NSString *title = [NSString localizedStringWithFormat:NSLocalizedString(@"What’s New in %@", nil), displayName];
				self.titleLabel.text = title;
				self.title = title;
			} else {
				self.titleLabel.text = NSLocalizedStringFromTable(@"MTZWhatsNewTitle", @"WhatsNew", nil);
				self.title = NSLocalizedStringFromTable(@"MTZWhatsNewTitle", @"WhatsNew", nil);
			}
		} break;
			
		case MTZWhatsNewListViewControllerTitleStyleColored: {
			NSString *displayName = NSBundle.mainBundle.displayName;
			if (displayName) {
				NSString *title = [NSString localizedStringWithFormat:NSLocalizedString(@"What’s New in %@", nil), displayName];
				NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
				NSRange range = [title rangeOfString:displayName];
				if (range.location != NSNotFound) {
					// TODO: We need this text color to adjust dynamically based on the view’s tint color. This isn’t easily achievable from the view controller. We could subclass `UILabel` to refresh its attributed text when the tint color changes. And give some other attribute for tinted text.
					[attributedTitle addAttribute:NSForegroundColorAttributeName value:self.view.tintColor range:range];
					self.titleLabel.attributedText = attributedTitle;
				} else {
					self.titleLabel.text = title;
				}
				self.title = title;
			} else {
				self.titleLabel.text = NSLocalizedStringFromTable(@"MTZWhatsNewTitle", @"WhatsNew", nil);
				self.title = NSLocalizedStringFromTable(@"MTZWhatsNewTitle", @"WhatsNew", nil);
			}
		} break;
			
		case MTZWhatsNewListViewControllerTitleStyleSimple:
		default: {
			self.titleLabel.text = NSLocalizedStringFromTable(@"MTZWhatsNewTitle", @"WhatsNew", nil);
			self.title = NSLocalizedStringFromTable(@"MTZWhatsNewTitle", @"WhatsNew", nil);
		} break;
	}
}

@end

@implementation MTZWhatsNewListViewController (UITableViewDelegate)

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

@end

@implementation MTZWhatsNewListViewController (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
		case 0:
			return self.allFeatures.count;
			
		default:
			// This is some section we don’t know about.
			return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *feature = self.allFeatures[(NSUInteger)indexPath.row];
	MTZWhatsNewFeatureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MTZWhatsNewFeatureTableViewCell reuseIdentifier] forIndexPath:indexPath];
	[cell configureForFeature:feature];
	cell.contentColor = self.contentColor;
	return cell;
}

@end

NS_ASSUME_NONNULL_END
