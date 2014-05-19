//
//  MTZAppDelegate.m
//  What's New
//
//  Created by Matt Zanchelli on 5/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZAppDelegate.h"

#import "MTZViewController.h"

#import "MTZWhatsNew.h"
#import "MTZWhatsNewViewController.h"

#ifdef DEBUG
@interface MTZWhatsNew ()
+ (void)setLastAppVersion:(NSString *)version;
@end
#endif

@implementation MTZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	self.window.rootViewController = [[MTZViewController alloc] init];
	
#ifdef DEBUG
	[MTZWhatsNew setLastAppVersion:@"2.0"];
#endif
	
	[MTZWhatsNew handleWhatsNewWithBlock:^(NSDictionary *whatsNew) {
		MTZWhatsNewViewController *vc = [[MTZWhatsNewViewController alloc] init];
		vc.features = whatsNew;
		[self.window.rootViewController presentViewController:vc animated:YES completion:nil];
	}];
	
    return YES;
}

@end
