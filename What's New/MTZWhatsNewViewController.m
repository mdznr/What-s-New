//
//  MTZWhatsNewViewController.m
//  What's New
//
//  Created by Matt Zanchelli on 5/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

#import "MTZWhatsNewFeatureTableViewCell.h"

@interface MTZWhatsNewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MTZWhatsNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Background.
	self.view.backgroundColor = [UIColor colorWithRed:133.0f/255.0f green:44.0f/255.0f blue:194.0f/255.0f alpha:1.0f];
	
	// Feature table view.
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView registerClass:[MTZWhatsNewFeatureTableViewCell class] forCellReuseIdentifier:@"feature"];
	self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0);
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	[self.view addSubview:self.tableView];
	
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
}

- (IBAction)didTapContinueButton:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 112.0f;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	MTZWhatsNewFeatureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feature" forIndexPath:indexPath];
	if ( !cell ) {
		cell = [[MTZWhatsNewFeatureTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"feature"];
	}
	
	cell.title = @"Unplayed Episodes";
	cell.detail = @"Quickly find episodes you haven’t played yet.";
	cell.icon = [UIImage imageNamed:@"Feed"];
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return NSLocalizedString(@"What's New", nil);
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}


@end
