//
//  NSBundle+DisplayName.m
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "NSBundle+DisplayName.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSBundle (DisplayName)

- (nullable NSString *)displayName
{
	static NSString *BundleDisplayNameKey = @"CFBundleDisplayName";
	return self.localizedInfoDictionary[BundleDisplayNameKey] ?: self.infoDictionary[BundleDisplayNameKey];
}

@end

NS_ASSUME_NONNULL_END
