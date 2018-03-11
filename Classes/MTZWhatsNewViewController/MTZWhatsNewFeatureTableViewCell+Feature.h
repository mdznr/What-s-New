//
//  MTZWhatsNewFeatureTableViewCell+Feature.h
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewFeatureTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTZWhatsNewFeatureTableViewCell (Feature)

/// Configure this cell for a given feature
/// @param feature The feature to represent in this cell
- (void)configureForFeature:(NSDictionary<NSString *, id> *)feature;

@end

NS_ASSUME_NONNULL_END
