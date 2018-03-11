//
//  UITableView+CellReuse.m
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "UITableView+CellReuse.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UITableView (CellReuse)

- (void)registerCellClass:(Class)cellClass
{
	NSString *nibName = NSStringFromClass(cellClass);
	NSBundle *nibBundle = [NSBundle bundleForClass:cellClass];
	UINib *nib = [UINib nibWithNibName:nibName bundle:nibBundle];
	NSString *reuseIdentifier = [cellClass respondsToSelector:@selector(reuseIdentifier)] ? [cellClass reuseIdentifier] : nibName;
	[self registerNib:nib forCellReuseIdentifier:reuseIdentifier];
}

@end

NS_ASSUME_NONNULL_END
