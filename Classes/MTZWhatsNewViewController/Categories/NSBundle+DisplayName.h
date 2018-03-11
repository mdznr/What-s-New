//
//  NSBundle+DisplayName.h
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (DisplayName)

/// The display name of the bundle, if available
/// @discussion This is @c CFBundleDisplayName in the bundle’s Info.plist
@property (nonatomic, copy, readonly, nullable) NSString *displayName;

@end

NS_ASSUME_NONNULL_END
