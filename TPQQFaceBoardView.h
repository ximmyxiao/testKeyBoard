//
//  TPQQFaceBoardView.h
//  testKeyBoard
//
//  Created by Piao Piao on 14/12/10.
//  Copyright (c) 2014年 Piao Piao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQFaceViewDelegate <NSObject>
- (void)didSelectQQFaceView:(NSString*)faceContent;
@end

@interface QQFaceView : UIView
@property(nonatomic,strong) UIImageView* imageView;
@property(nonatomic,strong) UIImage* image;
@property(nonatomic,strong) NSString* faceContent;
@property(nonatomic,weak) id<QQFaceViewDelegate> delegate;
+ (instancetype) faceViewWithImage:(UIImage*) image andContent:(NSString*) content;
@end

@interface TPQQFaceBoardView : UIView<QQFaceViewDelegate>
@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UIView* scrollContentView;
@property(nonatomic,strong) NSMutableArray* allFaces;
@property(nonatomic,assign) NSInteger columnCount;
@property(nonatomic,assign) NSInteger padding;
@property(nonatomic,weak) id<QQFaceViewDelegate> delegate;

- (instancetype) initWithDelegate:(id<QQFaceViewDelegate>) delegate;
@end
