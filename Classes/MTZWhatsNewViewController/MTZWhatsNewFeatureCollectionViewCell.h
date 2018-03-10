//
// MTZWhatsNewFeatureCollectionViewCell.h
// What’s New
//
// Created by Matt Zanchelli on 5/23/14.
// Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface MTZWhatsNewFeatureCollectionViewCell : UICollectionViewCell

///	The title of the feature.
@property (nonatomic, copy, nullable) NSString *title;

///	A short description of the feature.
@property (nonatomic, copy, nullable) NSString *detail;

/// An image represeting the feature.
@property (nonatomic, copy, nullable) UIImage *icon;

///	The color to use for the content.
@property (nonatomic, copy) UIColor *contentColor;

@end

NS_ASSUME_NONNULL_END
