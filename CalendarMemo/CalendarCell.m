//
//  CalendarCell.m
//  CalendarMemo
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        self.cellLabel.center = self.center;
        self.cellLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundView = self.cellLabel;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
