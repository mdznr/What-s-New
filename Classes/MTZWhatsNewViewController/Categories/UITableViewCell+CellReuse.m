//
//  UITableViewCell+CellReuse.m
//  Podcasts
//
//  Created by Matt Zanchelli on 3/10/18.
//  Copyright © 2018 Matt Zanchelli. All rights reserved.
//

#import "UITableViewCell+CellReuse.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UITableViewCell (CellReuse)

+ (NSString *)reuseIdentifier
{
	return NSStringFromClass([self class]);
}

@end

NS_ASSUME_NONNULL_END
