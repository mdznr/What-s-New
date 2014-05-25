//
//  MTZWhatsNewFeatureCollectionViewCell.m
//  What's New
//
//  Created by Matt Zanchelli on 5/23/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewFeatureCollectionViewCell.h"

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
	self.textLabel.textColor = [UIColor whiteColor];
	self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:20.0f];
	[self.contentView addSubview:self.textLabel];
	
	self.detailTextLabel = [[UILabel alloc] init];
	self.detailTextLabel.textColor = [UIColor whiteColor];
	self.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
	self.detailTextLabel.numberOfLines = 2;
	[self.contentView addSubview:self.detailTextLabel];

	self.imageView = [[UIImageView alloc] init];
	[self.contentView addSubview:self.imageView];
	
	[self layoutForGrid];
}

- (void)layoutForList
{
	self.frame = CGRectMake(0, 0, 320, 112);
	
	self.imageView.frame = CGRectMake(26, 24, 64, 64);
	
	self.textLabel.frame = CGRectMake(100, 30, 194, 20);
	self.textLabel.textAlignment = NSTextAlignmentLeft;
	
	self.detailTextLabel.frame = CGRectMake(100, 50, 194, 34);
	self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)layoutForGrid
{
	self.frame = CGRectMake(0, 0, 540/2, 374/2);
	
	self.imageView.frame = CGRectMake(103, 55/2, 64, 64);
	
	self.textLabel.frame = CGRectMake(32, 101, 412/2, 20);
	self.textLabel.textAlignment = NSTextAlignmentCenter;
	
	self.detailTextLabel.frame = CGRectMake(32, 125, 412/2, 34);
	self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
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