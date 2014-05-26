//
//  MTZWhatsNewFeatureCollectionViewCell.h
//  What's New
//
//  Created by Matt Zanchelli on 5/23/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

///	Describes the kind of layout of the cell.
typedef NS_ENUM(NSUInteger, MTZWhatsNewFeatureCollectionViewCellLayoutStyle){
	///	For use in a list. The image appears on the left and the left-align text appears stacked to the right of the image.
	MTZWhatsNewFeatureCollectionViewCellLayoutStyleList,
	///	For use in a grid. The image appears above the text and everything is center aligned.
	MTZWhatsNewFeatureCollectionViewCellLayoutStyleGrid
};

@interface MTZWhatsNewFeatureCollectionViewCell : UICollectionViewCell

///	The title of the feature.
@property (nonatomic, copy) NSString *title;

///	A short description of the feature.
@property (nonatomic, copy) NSString *detail;

/// An image represeting the feature.
@property (nonatomic, copy) UIImage *icon;

///	The color to use for the content.
@property (nonatomic, copy) UIColor *contentColor;

///	The style of the layout.
@property (nonatomic) MTZWhatsNewFeatureCollectionViewCellLayoutStyle layoutStyle;

@end