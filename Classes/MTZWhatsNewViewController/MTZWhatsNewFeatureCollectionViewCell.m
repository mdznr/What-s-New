//
// MTZWhatsNewFeatureCollectionViewCell.m
// What’s New
//
// Created by Matt Zanchelli on 5/23/14.
// Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewFeatureCollectionViewCell.h"

#import "NSLayoutConstraint+Common.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTZWhatsNewFeatureCollectionViewCell ()

@property (nonatomic, strong) UIView *myContentView;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *detailTextLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MTZWhatsNewFeatureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (instancetype)init
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
	self.textLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightSemibold];
	
	self.detailTextLabel = [[UILabel alloc] init];
	[self.myContentView addSubview:self.detailTextLabel];
	self.detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.detailTextLabel.textColor = [UIColor whiteColor];
	self.detailTextLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightRegular];
	self.detailTextLabel.numberOfLines = 0;
	self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
	
	self.imageView = [[UIImageView alloc] init];
	[self.myContentView addSubview:self.imageView];
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
	
	/* Layout */ {
		self.textLabel.textAlignment = NSTextAlignmentLeft;
		self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
		
		// The views to be referencing in visual format.
		NSDictionary<NSString *, UIView *> *views = @{
			@"myContentView" : self.myContentView,
			@"icon" : self.imageView,
			@"title" : self.textLabel,
			@"detail" : self.detailTextLabel,
		};
		
		// Stretch myContentView to its parent.
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[myContentView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[myContentView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
		
		// Align the image view to the top.
		[self.myContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.myContentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
		
		// Horizontally space icon and labels.
		[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(18)-[icon(47)]-(26)-[title(>=211)]-(18)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:views]];
		[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(18)-[icon(47)]-(26)-[detail(>=211)]-(18)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:views]];
		// Vertically align labels.
		[self.myContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[title]-(0)-[detail]-(>=0)-|" options:0 metrics:nil views:views]];
	}
}

- (void)prepareForReuse
{
	self.title = nil;
	self.detail = nil;
	self.icon = nil;
}


#pragma mark - Properties

- (void)setTitle:(nullable NSString *)title
{
	self.textLabel.text = [title copy];
}

- (nullable NSString *)title
{
	return self.textLabel.text;
}

- (void)setDetail:(nullable NSString *)detail
{
	self.detailTextLabel.text = [detail copy];
}

- (nullable NSString *)detail
{
	return self.detailTextLabel.text;
}

- (void)setIcon:(nullable UIImage *)icon
{
	self.imageView.image = [icon copy];
}

- (nullable UIImage *)icon
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

NS_ASSUME_NONNULL_END
