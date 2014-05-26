//
//  UICollectionView+initWithCollectionViewLayout.h
//  What's New
//
//  Created by Matt Zanchelli on 5/25/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (initWithCollectionViewLayout)

///	Initializes and returns a newly allocated collection view object with the specified layout.
///	@param layout The layout object to use for organizing items. The collection view stores a strong reference to the specified object. Must not be @c nil.
///	@return An initialized collection view object or nil if the object could not be created.
/// @discussion Use this method when initializing a collection view object programmatically.
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;

@end
