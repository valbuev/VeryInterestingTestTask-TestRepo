//
//  CityTableViewCell.m
//  VeryInterestingTestTask
//
//  Created by Valeriy Buev on 27.05.14.
//  Copyright (c) 2014 bva. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell


- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self custom_init];
    }
    return self;
}

- (void) custom_init{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    label.text = @"this is label";
//    [label setBackgroundColor:[UIColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:0.7f]];
//    [self addSubview:label];
//    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight
//                                 relatedBy:NSLayoutRelationEqual toItem:self
//                                 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
//    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft
//                                 relatedBy:NSLayoutRelationEqual toItem:self
//                                 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
//    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop
//                                 relatedBy:NSLayoutRelationEqual toItem:self
//                                 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
//    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom
//                                 relatedBy:NSLayoutRelationEqual toItem:self
//                                 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self custom_init];
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
