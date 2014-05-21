//
//  MTZWhatsNewViewController.m
//  What's New
//
//  Created by Matt Zanchelli on 5/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewViewController.h"

#import "MTZWhatsNewFeatureTableViewCell.h"
#import "MTZTableView.h"

@interface MTZWhatsNewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *orderedKeys;

@property (strong, nonatomic) MTZTableView *tableView;

@end

@implementation MTZWhatsNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Background.
	self.view.backgroundColor = [UIColor colorWithRed:133.0f/255.0f green:44.0f/255.0f blue:194.0f/255.0f alpha:1.0f];
	
	// Feature table view.
	self.tableView = [[MTZTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView registerClass:[MTZWhatsNewFeatureTableViewCell class] forCellReuseIdentifier:@"feature"];
	UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 50, 0);
	self.tableView.scrollIndicatorInsets = edgeInsets;
	self.tableView.contentInset = edgeInsets;
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	[self.view addSubview:self.tableView];
	
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


#pragma mark - Properties

- (void)setFeatures:(NSDictionary *)features
{
	_features = features;
	_orderedKeys = [[_features allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj2 compare:obj1 options:NSNumericSearch];
	}];
	
	// Reload the table view's data.
	[self.tableView reloadData];
}


#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
	label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0f];
	label.text = NSLocalizedString(@"What's New", nil);
	
	return label;
}

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
	
	NSDictionary *feature = self.features[self.orderedKeys[indexPath.section]][indexPath.row];
	
	cell.title = feature[@"Title"];
	cell.detail = feature[@"Detail"];
	NSString *iconName = feature[@"Icon"];
	if ( iconName ) {
		cell.icon = [UIImage imageNamed:iconName];
	} else {
		cell.icon = nil;
	}
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.features count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString *key = self.orderedKeys[section];
	return [self.features[key] count];
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
