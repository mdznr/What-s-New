//
//  PDCAppDelegate.m
//  Podcasts
//
//  Created by Matt Zanchelli on 5/26/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "PDCAppDelegate.h"

#import "PDCViewController.h"

#import "MTZWhatsNew.h"
#import "MTZWhatsNewGridViewController.h"

@implementation PDCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	self.window.rootViewController = [[PDCViewController alloc] init];
	self.window.tintColor = [UIColor colorWithHue:0.77 saturation:0.77 brightness:0.76 alpha:1];
	
	
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
		// Customizing the background gradient.
		vc.backgroundGradientTopColor = [UIColor colorWithHue:0.77 saturation:0.77 brightness:0.76 alpha:1];
		vc.backgroundGradientBottomColor = [UIColor colorWithHue:0.78 saturation:0.6 brightness:0.95 alpha:1];
		// Presenting the what's new view controller.
		[self.window.rootViewController presentViewController:vc animated:NO completion:nil];
//		vc.view.superview.frame = CGRectMake(40, 40, 320, 568);
	}];
	
    return YES;
}

@end
