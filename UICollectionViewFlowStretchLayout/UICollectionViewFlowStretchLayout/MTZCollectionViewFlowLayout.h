//
//  MTZCollectionViewFlowLayout.h
//  MTZCollectionViewFlowLayout
//
//  Created by Matt Zanchelli on 5/29/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTZCollectionViewFlowLayout : UICollectionViewFlowLayout

///	Treat itemSize as a minimum item size, and stretch the cell in the dimension opposite of @c scrollDirection to fill space.
/// @discussion This will not work if @c collectionView:layout:sizeForItemAtIndexPath: is implemented by @c collectionView 's delegate.
@property (nonatomic, getter = treatsSizeAsMinimumSize) BOOL treatSizeAsMinimumSize;

@end
