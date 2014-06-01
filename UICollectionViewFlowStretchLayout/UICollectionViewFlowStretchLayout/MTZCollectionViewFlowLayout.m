//
//  MTZCollectionViewFlowLayout.m
//  MTZCollectionViewFlowLayout
//
//  Created by Matt Zanchelli on 5/29/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

// With some left alignment help: https://github.com/mokagio/UICollectionViewLeftAlignedLayout
//
// Copyright (c) 2014 Giovanni Lodi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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


#pragma mark - Providing Layout Attributes

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
	NSArray *allAttributes = [super layoutAttributesForElementsInRect:rect];
    for ( UICollectionViewLayoutAttributes *attributes in allAttributes ) {
        if ( !attributes.representedElementKind ) {
            NSIndexPath *indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
	
	// Return early if not treating as minimum size.
	if ( !self.treatsSizeAsMinimumSize ) return attributes;
	
	// Get some basic measurements.
	UIEdgeInsets sectionInset;
	if ( [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)] ) {
		[((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate) collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];
	} else {
		sectionInset = self.sectionInset;
	}
	
	CGFloat interItemSpacing;
	if ( [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)] ) {
		interItemSpacing = [((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate) collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:indexPath.section];
	} else {
		interItemSpacing = self.minimumInteritemSpacing;
	}
	
	// Measurements dependent on scroll direction.
	CGFloat totalDimension, totalSectionInset, minimumItemDimension;
	switch (self.scrollDirection) {
		case UICollectionViewScrollDirectionVertical:
			totalDimension = self.collectionView.bounds.size.width - self.collectionView.contentInset.left - self.collectionView.contentInset.right;
			totalSectionInset = sectionInset.left + sectionInset.right;
			minimumItemDimension = self.itemSize.width;
			break;
		case UICollectionViewScrollDirectionHorizontal:
			totalDimension = self.collectionView.bounds.size.height - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom;
			totalSectionInset = sectionInset.top + sectionInset.bottom;
			minimumItemDimension = self.itemSize.height;
			break;
	}
	
	// Calculate the new dimension based on working dimension and number of items in a line.
	CGFloat workingDimension = totalDimension - totalSectionInset;
	CGFloat numberOfItemsInLine = floor((workingDimension - interItemSpacing) / (minimumItemDimension + interItemSpacing));
	CGFloat newDimension = MAX(minimumItemDimension, workingDimension / numberOfItemsInLine);
	
	// Set the new size.
	switch (self.scrollDirection) {
		case UICollectionViewScrollDirectionVertical:
			attributes.size = CGSizeMake(newDimension, attributes.size.height);
			
			// Align to the left.
			if ( indexPath.item == 0 ) {
				CGRect frame = attributes.frame;
				frame.origin.x = 0;
				attributes.frame = frame;
			} else {
				NSIndexPath *previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
				CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
				CGRect stretchedCurrentFrame = CGRectMake(0, attributes.frame.origin.y, workingDimension, attributes.frame.size.height);
				
				// If the current frame, once aligned to the left and stretched to the full collection view width, intersects the previous frame, then they are on the same line.
				if ( !CGRectIntersectsRect(previousFrame, stretchedCurrentFrame) ) {
					// Make sure the first item on a line is left aligned.
					CGRect frame = attributes.frame;
					frame.origin.x = 0;
					attributes.frame = frame;
				} else {
					attributes.frame = CGRectMake(CGRectGetMaxX(previousFrame) + interItemSpacing, attributes.frame.origin.y, attributes.frame.size.width, attributes.frame.size.height);
				}
			}
			
			break;
		case UICollectionViewScrollDirectionHorizontal:
			attributes.size = CGSizeMake(attributes.size.width, newDimension);
			
			// Align to the top.
			if ( indexPath.item == 0 ) {
				CGRect frame = attributes.frame;
				frame.origin.y = 0;
				attributes.frame = frame;
			} else {
				NSIndexPath *previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
				CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
				CGRect stretchedCurrentFrame = CGRectMake(attributes.frame.origin.x, 0, attributes.frame.size.width, workingDimension);
				
				// If the current frame, once aligned to the top and stretched to the full collection view height, intersects the previous frame, then they are on the same line.
				if ( !CGRectIntersectsRect(previousFrame, stretchedCurrentFrame) ) {
					// Make sure the first item on a line is top aligned.
					CGRect frame = attributes.frame;
					frame.origin.y = 0;
					attributes.frame = frame;
				} else {
					attributes.frame = CGRectMake(attributes.frame.origin.x, CGRectGetMaxY(previousFrame) + interItemSpacing, attributes.frame.size.width, attributes.frame.size.height);
				}
			}
			
			break;
	}
	
	return attributes;
}


#pragma mark - Invalidating the Layout

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds
{
	// This cast should hopefully never cause issues. `super` should always return `UICollectionViewFlowLayoutInvalidationContext`.
	UICollectionViewFlowLayoutInvalidationContext *ctx = (UICollectionViewFlowLayoutInvalidationContext *) [super invalidationContextForBoundsChange:newBounds];
	ctx.invalidateFlowLayoutDelegateMetrics = YES;
	return ctx;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
	/*
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
	 */
	
	return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

@end
