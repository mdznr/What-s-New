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
#import "MTZWhatsNewViewController.h"

#ifdef DEBUG
// For the sake of debugging, unhide private method for setting the last version of the app used.
@interface MTZWhatsNew ()
+ (void)setLastAppVersion:(NSString *)version;
@end
#endif

@implementation PDCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	self.window.rootViewController = [[PDCViewController alloc] init];
	self.window.tintColor = [UIColor colorWithHue:0.77 saturation:0.77 brightness:0.76 alpha:1];
	
#ifdef DEBUG
	// For the sake of debugging, manually set the last version of the app used to 0.
	[MTZWhatsNew setLastAppVersion:@"0.0"];
#endif
	
	[MTZWhatsNew handleWhatsNew:^(NSDictionary *whatsNew) {
		MTZWhatsNewViewController *vc = [[MTZWhatsNewViewController alloc] initWithFeatures:whatsNew];
		vc.backgroundGradientTopColor = [UIColor colorWithHue:0.77 saturation:0.77 brightness:0.76 alpha:1];
		vc.backgroundGradientBottomColor = [UIColor colorWithHue:0.78 saturation:0.6 brightness:0.95 alpha:1];
		[self.window.rootViewController presentViewController:vc animated:NO completion:nil];
	}];
	
    return YES;
}

@end
