//
//  CustomCalloutCell.m
//  FEMADemo
//
//  Created by Frank on 3/19/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import "CustomCalloutCell.h"

@implementation CustomCalloutCell

@synthesize valueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
