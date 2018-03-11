//
//  UITableViewCell+CellReuse.h
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (CellReuse)

/// The reuse identifier for this table view cell class.
/// @discussion By default, this is just the name of the class.
@property (class, nonatomic, copy, readonly) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
