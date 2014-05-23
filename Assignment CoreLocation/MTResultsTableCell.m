//
//  MTResultsTableCell.m
//  Assignment CoreLocation
//
//  Created by Michael Tirenin on 5/22/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTResultsTableCell.h"

@implementation MTResultsTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
