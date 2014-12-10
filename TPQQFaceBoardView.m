//
//  TPQQFaceBoardView.m
//  testKeyBoard
//
//  Created by Piao Piao on 14/12/10.
//  Copyright (c) 2014年 Piao Piao. All rights reserved.
//

#import "TPQQFaceBoardView.h"

@implementation TPQQFaceBoardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.scrollView];
        
        [self constructAllConstraints];
    }
    
    return self;
}

- (void)constructAllConstraints
{
    NSDictionary *vs = NSDictionaryOfVariableBindings(_scrollView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:0 metrics:nil views:vs]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:0 metrics:nil views:vs]];

}

@end
