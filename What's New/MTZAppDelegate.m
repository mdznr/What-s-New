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

@implementation MTZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	self.window.rootViewController = [[MTZViewController alloc] init];
	
	[MTZWhatsNew handleWhatsNewWithBlock:^(NSDictionary *whatsNew) {
		NSLog(@"%@", whatsNew);
		MTZWhatsNewViewController *vc = [[MTZWhatsNewViewController alloc] init];
		vc.features = whatsNew;
		[self.window.rootViewController presentViewController:vc animated:YES completion:nil];
	}];
	
    return YES;
}

@end
