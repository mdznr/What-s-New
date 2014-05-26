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
	self.detailTextLabel.numberOfLines = 2;

	self.imageView = [[UIImageView alloc] init];
	[self.contentView addSubview:self.imageView];
	self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self setLayoutStyle:MTZWhatsNewFeatureCollectionViewCellLayoutStyleList];
}

- (void)setLayoutStyle:(MTZWhatsNewFeatureCollectionViewCellLayoutStyle)layoutStyle
{
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
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 320, 112);
	
	// Image View Size
	[self.imageView removeConstraints:self.imageView.constraints];
	[self.imageView addConstraint:[NSLayoutConstraint constraintToSetStaticWidth:64 toView:self.imageView]];
	[self.imageView addConstraint:[NSLayoutConstraint constraintToSetStaticHeight:64 toView:self.imageView]];
	
	[self.textLabel removeConstraints:self.textLabel.constraints];
	[self.textLabel addConstraint:[NSLayoutConstraint constraintToSetStaticHeight:20 toView:self.textLabel]];
	self.textLabel.textAlignment = NSTextAlignmentLeft;
	
	[self.detailTextLabel removeConstraints:self.textLabel.constraints];
	[self.detailTextLabel addConstraint:[NSLayoutConstraint constraintToSetStaticHeight:34 toView:self.detailTextLabel]];
	self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
	
	// Remove all constraints. Start from a clean state.
	[self removeConstraints:self.constraints];
	
	// Vertically center image view.
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
	
	// Horizontally space icon and labels.
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(26)-[icon]-(10)-[label]-(26)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"icon": self.imageView, @"label": self.textLabel}]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(26)-[icon]-(10)-[label]-(26)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"icon": self.imageView, @"label": self.detailTextLabel}]];
	// Vertically align labels.
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[title]-(0)-[detail]-(>=32)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"title": self.textLabel, @"detail": self.detailTextLabel}]];
}

- (void)layoutForGrid
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 270, 187);
	
	[self.imageView removeConstraints:self.imageView.constraints];
//	self.imageView.frame = CGRectMake(103, 28, 64, 64);
	
	[self.textLabel removeConstraints:self.textLabel.constraints];
//	self.textLabel.frame = CGRectMake(24, 101, 222, 20);
	self.textLabel.textAlignment = NSTextAlignmentCenter;
	
	[self.detailTextLabel removeConstraints:self.detailTextLabel.constraints];
//	self.detailTextLabel.frame = CGRectMake(24, 125, 222, 34);
	self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
	
	[self removeConstraints:self.constraints];
	
	// Horizontal alignment.
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[icon(64)]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"icon": self.imageView}]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(32)-[title]-(32)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"title": self.textLabel}]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(32)-[detail]-(32)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"detail": self.detailTextLabel}]];
	// Vertical alignment.
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[icon(64)]-10-[title(20)]-8-[detail(34)]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"icon": self.imageView, @"title": self.textLabel, @"detail": self.detailTextLabel}]];
}

- (void)prepareForReuse
{
	self.title = nil;
	self.detail = nil;
	self.icon = nil;
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

@end