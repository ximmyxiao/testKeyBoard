//
//  TPInputComponent.h
//  testKeyBoard
//
//  Created by Piao Piao on 14/12/8.
//  Copyright (c) 2014年 Piao Piao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPQQFaceBoardView.h"

@protocol TPInputComponentDelegate <NSObject>
- (void)didSelectFaceBoard;

@end


@interface TPInputComponent : UIView<UITextViewDelegate,QQFaceViewDelegate>
@property(nonatomic,strong) UIView* headView;
@property(nonatomic,strong) UITextView* inputTextView;
@property(nonatomic,strong) UIButton* faceButton;
@property(nonatomic,assign) BOOL isShowFace;
@property(nonatomic,strong) NSLayoutConstraint* bottomConstraint;
@property(nonatomic,assign) CGFloat faceBoardHeight;
@property(nonatomic,strong) NSLayoutConstraint* totalHeightConstraint;
@property(nonatomic,strong) NSLayoutConstraint* textViewHeightConstraint;
@property(nonatomic,strong) NSLayoutConstraint* QQFaceYOriginConstraint;
@property(nonatomic,strong) TPQQFaceBoardView* QQFaceView;
@end
