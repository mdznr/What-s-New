//
//  MTZAppDelegate.m
//  What's New
//
//  Created by Matt Zanchelli on 5/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZAppDelegate.h"

#import "MTZWhatsNew.h"

@implementation MTZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	
	[MTZWhatsNew handleWhatsNewWithBlock:^(NSDictionary *whatsNew) {
		NSLog(@"%@", whatsNew);
	}];
	
    return YES;
}

@end
