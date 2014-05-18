//
//  MTZWhatsNewFeatureTableViewCell.m
//  What's New
//
//  Created by Matt Zanchelli on 5/18/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZWhatsNewFeatureTableViewCell.h"

@implementation MTZWhatsNewFeatureTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		
		self.textLabel.textColor = [UIColor whiteColor];
		self.detailTextLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
