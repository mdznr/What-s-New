//
//  MTZWhatsNewFeatureTableViewCell.m
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewFeatureTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTZWhatsNewFeatureTableViewCell ()

@property (nonatomic, strong) IBOutlet UIView *myContentView;

@property (nonatomic, strong) IBOutlet UIImageView *iconView;
@property (nonatomic, strong) IBOutlet UILabel *titleDetailLabel;

/// The attributed string to use in the text label. Calculated from `title` and `detail`.
@property (nonatomic, copy, readonly) NSAttributedString *attributedText;

@end

@implementation MTZWhatsNewFeatureTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	self.title = nil;
	self.detail = nil;
	self.icon = nil;
}


#pragma mark - Properties

- (void)setTitle:(nullable NSString *)title
{
	_title = [title copy];
	
	[self _refreshLabel];
}

- (void)setDetail:(nullable NSString *)detail
{
	_detail = [detail copy];
	
	[self _refreshLabel];
}

- (void)setIcon:(nullable UIImage *)icon
{
	self.iconView.image = [icon copy];
}

- (nullable UIImage *)icon
{
	return self.iconView.image;
}

- (void)setContentColor:(UIColor *)contentColor
{
	_contentColor = contentColor;
	
	self.titleDetailLabel.textColor = self.contentColor;
}

#pragma mark - Private

- (NSAttributedString *)attributedText
{
	NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
	
	/* Title */ {
		NSString *title = self.title;
		if (title) {
			NSDictionary<NSString *, id> *titleAttributes = @{
				NSFontAttributeName: [UIFont systemFontOfSize:15.0 weight:UIFontWeightSemibold],
			};
			NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:titleAttributes];
			[attributedText appendAttributedString:attributedTitle];
		}
	}
	
	/* Newline */ {
		[attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
	}
	
	/* Detail */ {
		NSString *detail = self.detail;
		if (detail) {
			NSDictionary<NSString *, id> *detailAttributes = @{
				NSFontAttributeName: [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular],
			};
			NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:detail attributes:detailAttributes];
			[attributedText appendAttributedString:attributedTitle];
		}
	}
	
	return attributedText;
}

- (void)_refreshLabel
{
	self.titleDetailLabel.attributedText = self.attributedText;
}

@end

NS_ASSUME_NONNULL_END
