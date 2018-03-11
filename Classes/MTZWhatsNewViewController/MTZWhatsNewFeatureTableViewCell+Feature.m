//
//  MTZWhatsNewFeatureTableViewCell+Feature.m
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewFeatureTableViewCell+Feature.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *kTitle = @"title";
static NSString *kDetail = @"detail";
static NSString *kIconName = @"icon";

@implementation MTZWhatsNewFeatureTableViewCell (Feature)

- (void)configureForFeature:(NSDictionary<NSString *, id> *)feature
{
	// Title & Detail
	self.title = feature[kTitle];
	self.detail = feature[kDetail];
	
	/* Icon */ {
		NSString *iconName = feature[kIconName];
		self.icon = [UIImage imageNamed:iconName];
	}
}

@end

NS_ASSUME_NONNULL_END
