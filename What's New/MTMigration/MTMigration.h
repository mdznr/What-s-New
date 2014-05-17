//
//  MTMigration.h
//  Tracker
//
//  Created by Parker Wightman on 2/7/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MTZWhatsNewBlock)(NSDictionary *whatsNew);

@interface MTMigration : NSObject

///	Show what's new in this update, if anything.
+ (void)handleWhatsNewWithBlock:(MTZWhatsNewBlock)whatsNewBlock;

///	Clears the last migration remembered by @c MTMigration. Causes all migration to run from the beginning.
+ (void)reset;

@end
