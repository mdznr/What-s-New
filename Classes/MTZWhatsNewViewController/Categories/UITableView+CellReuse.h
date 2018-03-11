//
//  UITableView+CellReuse.h
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

@import UIKit;

#import "UITableViewCell+CellReuse.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (CellReuse)

/// Register a particular class of cell for reuse
/// @param cellClass The class of the cell to register for reuse. Must be a subclass of @c UITableViewCell
/// @discussion The reuse identifier is set to the value of @c +reuseIdentifier as implemented by the cell class.
- (void)registerCellClass:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
