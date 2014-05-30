//
//  MTZCollectionViewFlowLayout.m
//  MTZCollectionViewFlowLayout
//
//  Created by Matt Zanchelli on 5/29/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZCollectionViewFlowLayout.h"

@implementation MTZCollectionViewFlowLayout

- (id)init
{
	self = [super init];
	if (self) {
		self.treatSizeAsMinimumSize = YES;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.treatSizeAsMinimumSize = YES;
	}
	return self;
}


#pragma mark - Properties

- (void)setTreatSizeAsMinimumSize:(BOOL)treatSizeAsMinimumSize
{
	_treatSizeAsMinimumSize = treatSizeAsMinimumSize;
	
	UICollectionViewFlowLayoutInvalidationContext *ctx = [[UICollectionViewFlowLayoutInvalidationContext alloc] init];
	ctx.invalidateFlowLayoutDelegateMetrics = YES;
	[self invalidateLayoutWithContext:ctx];
}


#pragma mark - Invalidating the Layout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
	// Only bother if this option is set.
	if ( self.treatSizeAsMinimumSize ) {
		// The new and old dimension (that we care about)
		CGFloat newDimension, oldDimension;
		// Set the new/old dimension according to scroll direction.
		switch (self.scrollDirection) {
			case UICollectionViewScrollDirectionVertical:
				newDimension = newBounds.size.width;
				oldDimension = self.collectionView.bounds.size.width;
				break;
			case UICollectionViewScrollDirectionHorizontal:
				newDimension = newBounds.size.height;
				oldDimension = self.collectionView.bounds.size.height;
				break;
		}
		
		// If the dimension we care about changed, invalidate.
		if ( newDimension != oldDimension ) {
			return YES;
		}
	}
	
	return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

@end
