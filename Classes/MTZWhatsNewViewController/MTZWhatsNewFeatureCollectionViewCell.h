//
//  MTZWhatsNewFeatureCollectionViewCell.h
//  What's New
//
//  Created by Matt Zanchelli on 5/23/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTZWhatsNewFeatureCollectionViewCell : UICollectionViewCell

///	The title of the feature.
@property (nonatomic, copy) NSString *title;

///	A short description of the feature.
@property (nonatomic, copy) NSString *detail;

/// An image represeting the feature.
@property (nonatomic, copy) UIImage *icon;

@end