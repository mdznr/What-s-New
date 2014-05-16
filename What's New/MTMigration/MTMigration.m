//
//  MTMigration.m
//  Tracker
//
//  Created by Parker Wightman on 2/7/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTMigration.h"

static NSString * const MTMigrationLastVersionKey      = @"MTMigration.lastMigrationVersion";
static NSString * const MTMigrationLastAppVersionKey   = @"MTMigration.lastAppVersion";

@implementation MTMigration

+ (void) migrateToVersion:(NSString *)version block:(MTExecutionBlock)migrationBlock {
	// version > lastMigrationVersion && version <= appVersion
    if ([version compare:[self lastMigrationVersion] options:NSNumericSearch] == NSOrderedDescending &&
        [version compare:[self appVersion] options:NSNumericSearch]           != NSOrderedDescending) {
		
            migrationBlock();
		
            #if DEBUG
                NSLog(@"MTMigration: Running migration for version %@", version);
            #endif
		
            [self setLastMigrationVersion:version];
        
        
        
	}
}


+ (void) applicationUpdateBlock:(MTExecutionBlock)updateBlock {
    if (![[self lastAppVersion] isEqualToString:[self appVersion]]) {
        
        updateBlock();
        
        #if DEBUG
            NSLog(@"MTMigration: Running update Block");
        #endif
        
        [self setLastAppVersion:[self appVersion]];
    }
}



+ (void) reset {
    [self setLastMigrationVersion:nil];
    [self setLastAppVersion:nil];
}




+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (void) setLastMigrationVersion:(NSString *)version {
    [[NSUserDefaults standardUserDefaults] setValue:version forKey:MTMigrationLastVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) lastMigrationVersion {
    NSString *res = [[NSUserDefaults standardUserDefaults] valueForKey:MTMigrationLastVersionKey];

    return (res ? res : @"");
}

+ (void)setLastAppVersion:(NSString *)version {
    [[NSUserDefaults standardUserDefaults] setValue:version forKey:MTMigrationLastAppVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) lastAppVersion {
    NSString *res = [[NSUserDefaults standardUserDefaults] valueForKey:MTMigrationLastAppVersionKey];
    
    return (res ? res : @"");
}

@end
