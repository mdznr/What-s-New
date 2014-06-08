//
//  MTZViewController.m
//  UICollectionViewFlowStretchLayout
//
//  Created by Matt Zanchelli on 5/29/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZViewController.h"

#import "MTZCollectionViewFlowLayout.h"

#define CELL_SIZE 100
#define HORIZONTAL_SCROLL

@interface MTZViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

// The collection view.
@property (strong, nonatomic) UICollectionView *cv;

// The collection view layout.
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@end

@implementation MTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.view.backgroundColor = [UIColor blackColor];
	
	// Seed RNG.
	srand48(time(0));
	
	// Collection view and layout.
	self.layout = [[MTZCollectionViewFlowLayout alloc] init];
	self.layout.itemSize = CGSizeMake(CELL_SIZE, CELL_SIZE);
	self.layout.sectionInset = UIEdgeInsetsZero;
	self.layout.minimumLineSpacing = 0;
	self.layout.minimumInteritemSpacing = 0;
	self.layout.headerReferenceSize = self.layout.footerReferenceSize = CGSizeZero;
#ifdef HORIZONTAL_SCROLL
	self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
#endif
	
	self.cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
	[self.cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	self.cv.delegate = self;
	self.cv.dataSource = self;
	self.cv.backgroundColor = [UIColor whiteColor];
	UIEdgeInsets edgeInset = UIEdgeInsetsMake(0, 0, 44, 0);
	self.cv.contentInset = edgeInset;
	self.cv.scrollIndicatorInsets = edgeInset;
	[self.view addSubview:self.cv];
	
	// Control the width of the collection view for testing.
	UIToolbar *controls = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
	[self.view addSubview:controls];
	UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 7, 748, 30)];
	slider.translatesAutoresizingMaskIntoConstraints = NO;
	[controls addSubview:slider];
	[controls addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(10)-[slider]-(10)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"slider": slider}]];
	[slider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
	slider.value = 1.0f;
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

- (IBAction)sliderDidChange:(UISlider *)sender
{
#ifdef HORIZONTAL_SCROLL
	CGFloat height = MAX(CELL_SIZE, sender.value * self.view.bounds.size.height);
	self.cv.frame = CGRectMake(0, 0, self.view.bounds.size.width, height);
#else
	CGFloat width = MAX(CELL_SIZE, sender.value * self.view.bounds.size.width);
	self.cv.frame = CGRectMake(0, 0, width, self.view.bounds.size.height);
#endif
}


#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	cell.backgroundColor = [UIColor colorWithRed:drand48() green:drand48() blue:drand48() alpha:1.0f];
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
		   viewForSupplementaryElementOfKind:(NSString *)kind
								 atIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

@end
