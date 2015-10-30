//
// MTZWhatsNewFeatureCollectionViewCell.m
// What’s New
//
// Created by Matt Zanchelli on 5/23/14.
// Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewFeatureCollectionViewCell.h"

#import "NSLayoutConstraint+Common.h"

@interface MTZWhatsNewFeatureCollectionViewCell ()

@property (nonatomic, strong) UIView *myContentView;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *detailTextLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MTZWhatsNewFeatureCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
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

- (id)init
{
	self = [super init];
	if (self) {
		[self commonInit];
	}
	return self;
}

/// Initialization code
- (void)commonInit
{
	self.backgroundColor = [UIColor clearColor];
	
	self.myContentView = [[UIView alloc] init];
	[self.contentView addSubview:self.myContentView];
	self.myContentView.translatesAutoresizingMaskIntoConstraints = NO;
	
	self.textLabel = [[UILabel alloc] init];
	[self.myContentView addSubview:self.textLabel];
	self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.textLabel.textColor = [UIColor whiteColor];
	self.textLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightRegular];
	
	self.detailTextLabel = [[UILabel alloc] init];
	[self.myContentView addSubview:self.detailTextLabel];
	self.detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.detailTextLabel.textColor = [UIColor whiteColor];
	self.detailTextLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightLight];
	self.detailTextLabel.numberOfLines = 0;
	self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
	
	self.imageView = [[UIImageView alloc] init];
	[self.myContentView addSubview:self.imageView];
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
	
	// Default of no style.
	_layoutStyle = -1;
}

- (void)setLayoutStyle:(MTZWhatsNewFeatureCollectionViewCellLayoutStyle)layoutStyle
{
	// Avoid reapplying layout, if it’s not necessary.
	if (layoutStyle == _layoutStyle) {
		return;
	}
	
	_layoutStyle = layoutStyle;
	switch (_layoutStyle) {
		case MTZWhatsNewFeatureCollectionViewCellLayoutStyleList:
			[self layoutForList];
			break;
			
		case MTZWhatsNewFeatureCollectionViewCellLayoutStyleGrid:
			[self layoutForGrid];
			break;
	}
}

- (void)layoutForList
{
	[self removeAllConstraints];
	
	self.textLabel.textAlignment = NSTextAlignmentLeft;
	self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
	
	// The views to be referencing in visual format.
	NSDictionary *views = @{@"myContentView" : self.myContentView, @"icon" : self.imageView, @"title" : self.textLabel, @"detail" : self.detailTextLabel};
	
	// Stretch myContentView to its parent.
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[myContentView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[myContentView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	
	// Vertically center image view.
	[self.myContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.myContentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
	
	// Horizontally space icon and labels.
	[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(26)-[icon(64)]-(10)-[title(>=194)]-(26)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:views]];
	[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(26)-[icon(64)]-(10)-[detail(>=194)]-(26)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:views]];
	// Vertically align labels.
	[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[title(20)]-(0)-[detail(>=34)]-(>=29)-|" options:0 metrics:nil views:views]];
}

- (void)layoutForGrid
{
	[self removeAllConstraints];
	
	self.textLabel.textAlignment = NSTextAlignmentCenter;
	self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
	
	// The views to be referencing in visual format.
	NSDictionary *views = @{@"myContentView" : self.myContentView, @"icon" : self.imageView, @"title" : self.textLabel, @"detail" : self.detailTextLabel};
	
	// Stretch myContentView to its parent.
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[myContentView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[myContentView]-(>=0)-|" options:NSLayoutFormatDirectionLeadingToTrailing | NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
	
	// Horizontal alignment.
	[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[icon(64)]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
	[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(32)-[title(>=206)]-(32)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
	[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(32)-[detail(>=206)]-(32)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
	// Vertical alignment.
	[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[icon(64)]-10-[title(20)]-4-[detail(34)]-(>=28)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}

- (void)prepareForReuse
{
	self.title = nil;
	self.detail = nil;
	self.icon = nil;
}

- (void)removeAllConstraints
{
	// Remove all constraints. Start from a clean state.
	[self.contentView removeConstraints:self.contentView.constraints];
	[self.textLabel removeConstraints:self.textLabel.constraints];
	[self.detailTextLabel removeConstraints:self.detailTextLabel.constraints];
	[self.imageView removeConstraints:self.imageView.constraints];
}


#pragma mark - Properties

- (void)setTitle:(NSString *)title
{
	self.textLabel.text = [title copy];
}

- (NSString *)title
{
	return self.textLabel.text;
}

- (void)setDetail:(NSString *)detail
{
	self.detailTextLabel.text = [detail copy];
}

- (NSString *)detail
{
	return self.detailTextLabel.text;
}

- (void)setIcon:(UIImage *)icon
{
	self.imageView.image = [icon copy];
}

- (UIImage *)icon
{
	return self.imageView.image;
}

- (void)setContentColor:(UIColor *)contentColor
{
	_contentColor = contentColor;
	
	self.textLabel.textColor = _contentColor;
	self.detailTextLabel.textColor = _contentColor;
	self.imageView.tintColor = _contentColor;
}

@end
