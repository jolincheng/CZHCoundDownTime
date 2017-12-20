//
//  CZHCountDownModel.h
//  倒计时重用
//
//  Created by 程召华 on 2017/12/20.
//  Copyright © 2017年 程召华. All rights reserved.
//



#import <Foundation/Foundation.h>

static NSString *const CZHUpdateTimeNotification = @"CZHUpdateTimeNotification";
static NSString *const CZHCountDownFinishNotification = @"CZHCountDownFinishNotification";

@interface CZHCountDownModel : NSObject

///当前时间
@property (nonatomic, assign) NSInteger currentTime;
///开始倒计时时间
@property (nonatomic, assign) NSInteger startTime;
///
@property (nonatomic, assign) BOOL isFinished;
//倒计时操作
- (void)countDown;
@end
