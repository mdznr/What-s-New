//
//  MTZWhatsNewFeatureCollectionViewCell.m
//  What's New
//
//  Created by Matt Zanchelli on 5/23/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewFeatureCollectionViewCell.h"

#import "NSLayoutConstraint+Common.h"

@interface MTZWhatsNewFeatureCollectionViewCell ()

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *detailTextLabel;
@property (strong, nonatomic) UIImageView *imageView;

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
	
	self.textLabel = [[UILabel alloc] init];
	[self.contentView addSubview:self.textLabel];
	self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.textLabel.textColor = [UIColor whiteColor];
	self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:20.0f];
	
	self.detailTextLabel = [[UILabel alloc] init];
	[self.contentView addSubview:self.detailTextLabel];
	self.detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.detailTextLabel.textColor = [UIColor whiteColor];
	self.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
	self.detailTextLabel.numberOfLines = 0;
	self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;

	self.imageView = [[UIImageView alloc] init];
	[self.contentView addSubview:self.imageView];
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
	
	// Default of no style.
	_layoutStyle = -1;
}

- (void)setLayoutStyle:(MTZWhatsNewFeatureCollectionViewCellLayoutStyle)layoutStyle
{
	// Avoid reapplying layout, if not necessary..
	if ( layoutStyle == _layoutStyle ) return;
		
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
	
	// Thew views to be referencing in visual format.
	NSDictionary *views = @{@"icon": self.imageView, @"title": self.textLabel, @"detail": self.detailTextLabel};
	
	// Vertically center image view.
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
	
	// Horizontally space icon and labels.
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(26)-[icon(64)]-(10)-[title(>=194)]-(26)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:views]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(26)-[icon(64)]-(10)-[detail(>=194)]-(26)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:views]];
	// Vertically align labels.
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[title(20)]-(0)-[detail(>=34)]-(>=29)-|" options:0 metrics:nil views:views]];
}

- (void)layoutForGrid
{
	[self removeAllConstraints];
	
	self.textLabel.textAlignment = NSTextAlignmentCenter;
	self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
	
	// Thew views to be referencing in visual format.
	NSDictionary *views = @{@"icon": self.imageView, @"title": self.textLabel, @"detail": self.detailTextLabel};
	
	// Horizontal alignment.
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[icon(64)]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(32)-[title(>=206)]-(32)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(32)-[detail(>=206)]-(32)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
	// Vertical alignment.
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[icon(64)]-10-[title(20)]-4-[detail(34)]-(>=28)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
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