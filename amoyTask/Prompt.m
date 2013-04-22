//
//  Prompt.m
//  amoyTask
//
//  Created by wuliang on 13-4-15.
//  Copyright (c) 2013年 wuliang. All rights reserved.
//

#import "Prompt.h"

@implementation Prompt
@synthesize maskView = _maskView, showText = _showText, showView = _showView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[_maskView setFrame:CGRectMake(_showView.frame.size.width-50, _showView.frame.size.height-50, 100, 100)];
    }
    return self;
}

- (void)dealloc {
    [_showText release];
    [_maskView release];
    [_showView release];
    [super dealloc];
}
@end
