//
//  TPQEmojiLabel.h
//  testTPQEmojiLabel
//
//  Created by Piao Piao on 14/12/8.
//  Copyright (c) 2014年 Piao Piao. All rights reserved.
//

#import <UIKit/UIKit.h>
const NSInteger  kEmotionCount = 105;
const NSInteger  KEmojiCount = 60;
@interface EmojiManager : NSObject
@property(nonatomic,strong) NSArray* kEmotionStringArray;
+ (instancetype)shareInstance;
/*localIndex转换成string*/
- (NSString*)emotionStringFromLocalIndex:(NSInteger)localIndex;
/*string转换成localIndex*/
- (NSInteger)emotionLocalIndexFromEmotionString:(NSString*)emotionString;
@end

@interface TPQEmojiLabel : UILabel
@property(nonatomic,strong) NSString* emojiText;
@end
