//
//  MTMigration.h
//  Tracker
//
//  Created by Parker Wightman on 2/7/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^MTExecutionBlock)(void);


@interface MTMigration : NSObject

/** 
 Executes a block of code for a specific version number and remembers this version as the latest migration done by MTMigration.
 
 @param version A string with a specific version number
 @param migrationBlock A block object to be executed when the application version matches the string 'version'. This parameter can't be nil.
 
 */

+ (void) migrateToVersion:(NSString *)version block:(MTExecutionBlock)migrationBlock;

/** 
 
 Executes a block of code for every time the application version changes.
 
 @param updateBlock A block object to be executed when the application version changes. This parameter can't be nil.
 
 */

+ (void) applicationUpdateBlock:(MTExecutionBlock)updateBlock;

/** Clears the last migration remembered by MTMigration. Causes all migration to run from the beginning. */

+ (void) reset;

@end
