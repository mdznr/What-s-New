//
//  MTZWhatsNewViewController.m
//  What's New
//
//  Created by Matt Zanchelli on 5/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

@interface MTZWhatsNewViewController ()

@property (strong, nonatomic) UILabel *title1;
@property (strong, nonatomic) UILabel *description1;
@property (strong, nonatomic) UIImageView *icon1;

@property (strong, nonatomic) UILabel *title2;
@property (strong, nonatomic) UILabel *description2;
@property (strong, nonatomic) UIImageView *icon2;

@property (strong, nonatomic) UILabel *title3;
@property (strong, nonatomic) UILabel *description3;
@property (strong, nonatomic) UIImageView *icon3;

@property (strong, nonatomic) UILabel *title4;
@property (strong, nonatomic) UILabel *description4;
@property (strong, nonatomic) UIImageView *icon4;

@end

@implementation MTZWhatsNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Background.
	self.view.backgroundColor = [UIColor colorWithRed:133.0f/255.0f green:44.0f/255.0f blue:194.0f/255.0f alpha:1.0f];
	
	// What's New.
	UILabel *whatsNewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.view.bounds.size.width, 33)];
	whatsNewLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	whatsNewLabel.text = NSLocalizedString(@"What's New", nil);
	whatsNewLabel.textAlignment = NSTextAlignmentCenter;
	whatsNewLabel.textColor = [UIColor whiteColor];
	whatsNewLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0f];
	[self.view addSubview:whatsNewLabel];
	
	// Get Started.
	CGRect frame = CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50);
	UIView *buttonBackground = [[UIView alloc] initWithFrame:frame];
	buttonBackground.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2f];
	buttonBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	[self.view addSubview:buttonBackground];
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	[button setTitle:NSLocalizedString(@"Get Started", nil) forState:UIControlStateNormal];
	button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
	[button addTarget:self action:@selector(didTapContinueButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
	NSArray *titleLabels = @[self.title1, self.title2, self.title3, self.title4];
	NSArray *descriptionLabels = @[self.description1, self.description2, self.description3, self.description4];
	NSArray *imageViews = @[self.icon1, self.icon2, self.icon3, self.icon4];
	for ( NSUInteger i=0; i<[titleLabels count]; ++i ) {
		UILabel *titleLabel = titleLabels[i];
		UILabel *descriptionLabel = descriptionLabels[i];
		UIImageView *imageView = imageViews[i];
		
		titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 88, 194, 21)];
		titleLabel.numberOfLines = 1;
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:18.0f];
		[self.view addSubview:titleLabel];
		
		descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 108, 194, 34)];
		descriptionLabel.numberOfLines = 0;
		descriptionLabel.textColor = [UIColor whiteColor];
		descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
		[self.view addSubview:descriptionLabel];
		
		imageView = [[UIImageView alloc] initWithFrame:CGRectMake(26, 82, 60, 60)];
		[self.view addSubview:imageView];
	}
	
	self.title1.text = @"Unplayed Episodes";
	self.description1.text = @"Quickly find episodes you haven’t played yet.";
}

- (IBAction)didTapContinueButton:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

@end
