//
//  PDCViewController.m
//  Podcasts
//
//  Created by Matt Zanchelli on 5/26/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "PDCViewController.h"

#import "NSLayoutConstraint+Common.h"

@implementation PDCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// Add a tab bar.
	UITabBar *tabBar = [[UITabBar alloc] init];
	[self.view addSubview:tabBar];
	tabBar.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraints:[NSLayoutConstraint constraintsToStickView:tabBar toEdges:UIRectEdgeLeft|UIRectEdgeBottom|UIRectEdgeRight]];
	
	// Add a navigation bar.
	UINavigationBar *navBar = [[UINavigationBar alloc] init];
	[self.view addSubview:navBar];
	navBar.translatesAutoresizingMaskIntoConstraints = NO;
	[navBar addConstraint:[NSLayoutConstraint constraintToSetStaticHeight:64 toView:navBar]];
	[self.view addConstraints:[NSLayoutConstraint constraintsToStickView:navBar toEdges:UIRectEdgeLeft|UIRectEdgeTop|UIRectEdgeRight]];
	
	// Add a label explaining the nature of the demo app.
	UILabel *label = [[UILabel alloc] init];
	[self.view addSubview:label];
	label.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[label(<=400)]-(>=20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"label": label}]];
	[label.superview addConstraint:[NSLayoutConstraint constraintToCenterViewHorizontallyToSuperview:label]];
	[self.view addConstraints:[NSLayoutConstraint constraintsToStretchVerticallyToSuperview:label]];
	label.text = NSLocalizedString(@"This is just a demo application showing off the “Whats New View Controller”. Nothing else.", nil);
	label.numberOfLines = 0;
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor grayColor];
}

@end
