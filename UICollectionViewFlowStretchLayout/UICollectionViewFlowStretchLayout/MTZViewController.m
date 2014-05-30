//
//  MTZViewController.m
//  UICollectionViewFlowStretchLayout
//
//  Created by Matt Zanchelli on 5/29/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZViewController.h"

@interface MTZViewController ()

@end

@implementation MTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	UIToolbar *controls = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
	[self.view addSubview:controls];
	UISlider *widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 7, 748, 30)];
	widthSlider.translatesAutoresizingMaskIntoConstraints = NO;
	[controls addSubview:widthSlider];
	[controls addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(10)-[slider]-(10)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"slider": widthSlider}]];
	[widthSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)sliderDidChange:(UISlider *)sender
{
}

@end
