//
//  TPQQFaceBoardView.m
//  testKeyBoard
//
//  Created by Piao Piao on 14/12/10.
//  Copyright (c) 2014年 Piao Piao. All rights reserved.
//

#import "TPQQFaceBoardView.h"
#import "TPQEmojiLabel.h"

#define FACE_ITEM_SIZE (35)

@implementation QQFaceView
+ (instancetype) faceViewWithImage:(UIImage*) image andContent:(NSString*) content
{
    QQFaceView* faceView = [[QQFaceView alloc] initWithImage:(UIImage*) image andContent:(NSString*) content];
    return faceView;
}


- (instancetype) initWithImage:(UIImage*) image andContent:(NSString*) content
{
    self = [super initWithFrame:CGRectMake(0, 0, FACE_ITEM_SIZE, FACE_ITEM_SIZE)];
    if (self)
    {
        _image = image;
        _faceContent = content;
        self.imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:self.imageView];
    }
    
    return self;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(didSelectQQFaceView:)])
    {
        [self.delegate didSelectQQFaceView:self.faceContent];
    }
}


@end


@implementation TPQQFaceBoardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithDelegate:(id<QQFaceViewDelegate>) delegate
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect = CGRectMake(0, 0, rect.size.width, 160);
    
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.columnCount = (rect.size.width - 20*2)/FACE_ITEM_SIZE;
        self.padding = (rect.size.width - self.columnCount*FACE_ITEM_SIZE)/2;
        self.allFaces = [NSMutableArray array];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
        self.scrollView.backgroundColor = [UIColor grayColor];
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];


        for (NSInteger page = 0 ; page < 4; page++)
        {
            CGFloat xOrigin = page*[[UIScreen mainScreen] bounds].size.width;
            
            for (NSInteger row = 0 ; row < 3 ; row ++ )
            {
                CGFloat YOrigin = 20 + (FACE_ITEM_SIZE+10)*row;
                for (NSInteger coloumn = 0 ; coloumn < self.columnCount ; coloumn++)
                {
                    NSInteger i = page* self.columnCount*3 + row*self.columnCount +  coloumn;
                    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"Expression_%ld",i+1]];
                    NSString* content = [[EmojiManager shareInstance] emotionStringFromLocalIndex:i+1];
                    QQFaceView* faceView = [QQFaceView faceViewWithImage:image andContent:content];
                    faceView.delegate = self.delegate;
//                    UIImageView* faceView = [[UIImageView alloc] initWithImage:image];
                    faceView.frame  = CGRectMake(xOrigin + self.padding + coloumn*FACE_ITEM_SIZE, YOrigin,FACE_ITEM_SIZE,FACE_ITEM_SIZE);
                    
//                    NSLog(@"Xorigin:%f:set frame:%@",xOrigin, NSStringFromCGRect(faceView.frame));
                    [self.scrollView addSubview:faceView];
                }
            }
        }
        
        self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width*4, 160);

    }
    
    return self;
}






@end
