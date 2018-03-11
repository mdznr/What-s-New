//
//  PDCAppDelegate.m
//  Podcasts
//
//  Created by Matt Zanchelli on 5/26/14.
//  Copyright © 2014 Matt Zanchelli. All rights reserved.
//

#import "PDCAppDelegate.h"

#import "UIColor+AppColors.h"

#import "PDCViewController.h"

#import "MTZWhatsNew.h"
#import "MTZWhatsNewGridViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PDCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	self.window.rootViewController = [[PDCViewController alloc] init];
	self.window.tintColor = [UIColor appTintColor];
	
#ifdef DEBUG
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
	
	// For the sake of debugging, manually set the last version of the app used to 0.
	// Do not include this in shipping code.
	[MTZWhatsNew performSelector:@selector(setLastAppVersion:) withObject:@"0.0"];
	
#pragma clang diagnostic pop
#endif
	
	[MTZWhatsNew handleWhatsNew:^(NSDictionary *whatsNew) {
		// Creating the view controller with features.
		MTZWhatsNewGridViewController *vc = [[MTZWhatsNewGridViewController alloc] initWithFeatures:whatsNew];
		// Presenting the what’s new view controller.
		[self.window.rootViewController presentViewController:vc animated:NO completion:nil];
	}];
	
	return YES;
}

@end

NS_ASSUME_NONNULL_END
