//
//  MTMigration.m
//  Tracker
//
//  Created by Parker Wightman on 2/7/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTMigration.h"

static NSString * const MTMigrationLastAppVersionKey = @"MTMigration.lastAppVersion";

@implementation MTMigration

#pragma mark - Public API

+ (void)handleWhatsNewWithBlock:(MTZWhatsNewBlock)whatsNewBlock
{
	NSDictionary *newFeatures = [self whatsNew];
	
	if ( [newFeatures count] ) {
		whatsNewBlock(newFeatures);
	}
	
	[self updateLastAppVersion];
}

+ (void)reset
{
    [self setLastAppVersion:nil];
}


#pragma mark - Private API

+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (void)updateLastAppVersion
{
	[self setLastAppVersion:[self appVersion]];
}

+ (void)setLastAppVersion:(NSString *)version
{
    [[NSUserDefaults standardUserDefaults] setValue:version forKey:MTMigrationLastAppVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)lastAppVersion
{
	return [[NSUserDefaults standardUserDefaults] valueForKey:MTMigrationLastAppVersionKey];
}

+ (NSDictionary *)whatsNew
{
	// Nothing's new if this hasn't been registered before. (Shouldn't work on first launch).
	if ( ![self lastAppVersion] ) {
		return nil;
	}
	
	NSMutableDictionary *whatsNew = [[NSMutableDictionary alloc] init];
	NSDictionary *allFeatures = [self allFeatures];
	for ( NSString *version in [allFeatures allKeys] ) {
		if ( [version compare:[self appVersion] options:NSNumericSearch] != NSOrderedDescending &&
			 [version compare:[self lastAppVersion] options:NSNumericSearch] == NSOrderedDescending ) {
			[whatsNew setObject:allFeatures[version] forKey:version];
		}
	}
	
	return whatsNew;
}

+ (NSDictionary *)allFeatures
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"What's New" ofType:@"plist"];
	return [[NSDictionary alloc] initWithContentsOfFile:path];
}

@end
