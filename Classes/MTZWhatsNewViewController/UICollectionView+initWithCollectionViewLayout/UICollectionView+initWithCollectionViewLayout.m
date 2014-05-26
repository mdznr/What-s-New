//
//  UICollectionView+initWithCollectionViewLayout.m
//  What's New
//
//  Created by Matt Zanchelli on 5/25/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "UICollectionView+initWithCollectionViewLayout.h"

@implementation UICollectionView (initWithCollectionViewLayout)

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
	return [self initWithFrame:CGRectZero collectionViewLayout:layout];
}

@end
