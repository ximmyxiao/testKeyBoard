//
//  TPInputComponent.m
//  testKeyBoard
//
//  Created by Piao Piao on 14/12/8.
//  Copyright (c) 2014年 Piao Piao. All rights reserved.
//

#import "TPInputComponent.h"

@implementation TPInputComponent

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)commonInit
{
    self.backgroundColor = [UIColor redColor];
    self.headView = [[UIView alloc] initWithFrame:CGRectZero];
    self.headView.backgroundColor = [UIColor blueColor];
    self.headView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.headView];
    
    self.inputTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.inputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.inputTextView.delegate = self;
    [self.headView addSubview:self.inputTextView];
    
    self.faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.faceButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.faceButton setTitle:@"表情" forState:UIControlStateNormal];
    [self.faceButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.faceButton addTarget:self action:@selector(faceButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.faceButton];
    
    self.QQFaceView = [[TPQQFaceBoardView alloc] initWithDelegate:self];
    [self addSubview:self.QQFaceView];
    
    [self constructAllConstraints];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];

}

#pragma mark Keyboard
- (void)keyboardWillChangeFrame:(NSNotification*)notif{
    float animationDuration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [[[notif userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    CGRect keyboardEndFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"set frame to %@",NSStringFromCGRect(keyboardEndFrame));

    CGFloat height = self.superview.frame.size.height - keyboardEndFrame.origin.y;
    [UIView beginAnimations:@"Animation" context:NULL];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
//    _tablePaddingBottom.constant=self.view.height-keyboardEndFrame.origin.y;
    self.bottomConstraint.constant = height;
    [self.superview layoutIfNeeded];
    [UIView commitAnimations];
}


- (void)keyboardWillShow
{
    self.isShowFace = NO;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}


- (void)constructAllConstraints
{
    NSDictionary *vs = NSDictionaryOfVariableBindings(_headView,_inputTextView,_faceButton,_QQFaceView);
    [self addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_headView]|"
      options:0 metrics:nil views:vs]];
    
    [self addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[_headView]-0-[_QQFaceView(160)]"
      options:0 metrics:nil views:vs]];
    
    [self addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_QQFaceView]|"
      options:0 metrics:nil views:vs]];
    
    self.totalHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.headView attribute:NSLayoutAttributeHeight multiplier:1 constant:self.faceBoardHeight];
    [self addConstraint:self.totalHeightConstraint];
    
    NSDictionary *vs2 = NSDictionaryOfVariableBindings(_inputTextView,_faceButton);

    [_headView addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|-40-[_inputTextView(220)]"
      options:0 metrics:nil views:vs2]];
    [_headView addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|-10-[_inputTextView]-10-|"
      options:0 metrics:nil views:vs2]];
    
    self.textViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.inputTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:25];
    [self.inputTextView addConstraint:self.textViewHeightConstraint];
    
    [_headView addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|-5-[_faceButton(25)]"
      options:0 metrics:nil views:vs2]];
    [_headView addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"H:[_faceButton(40)]-20-|"
      options:0 metrics:nil views:vs2]];
    
}


- (void)faceButtonAction
{
    self.isShowFace = !self.isShowFace;
}


- (void)setIsShowFace:(BOOL) isShowFace
{
    _isShowFace = isShowFace;
    if (self.isShowFace)
    {
        [self endEditing:YES];
        self.faceBoardHeight = 160;
        
    }
    else
    {
        self.faceBoardHeight = 0;
    }
    
    [UIView beginAnimations:@"Animation" context:NULL];
    [UIView setAnimationCurve:7];
    [UIView setAnimationDuration:0.3];
    self.totalHeightConstraint.constant = self.faceBoardHeight;
    [self.superview layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString* text = textView.text;
    
    CGRect orgRect = textView.frame;//获取原始UITextView的frame
    CGFloat pad = textView.textContainer.lineFragmentPadding;
    CGSize  size = [text boundingRectWithSize:CGSizeMake(orgRect.size.width - pad*2, 2000)  options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
//    orgRect.size.height=size.height+10;//获取自适应文本内容高度
    self.textViewHeightConstraint.constant = size.height+10;
    [self.headView layoutIfNeeded];
}

- (void)didSelectQQFaceView:(NSString *)faceContent
{
    self.inputTextView.text = [NSString stringWithFormat:@"%@%@",self.inputTextView.text,faceContent];
    [self textViewDidChange:self.inputTextView];
}

@end
