//
//  CZHCountDownModel.m
//  倒计时重用
//
//  Created by 程召华 on 2017/12/20.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHCountDownModel.h"

@implementation CZHCountDownModel

- (instancetype)init {
    if (self = [super init]) {
        
        self.currentTime = [self getTime];
        
        self.startTime = self.currentTime + arc4random() % 100;
        
    }
    return self;
}

- (void)countDown {

    self.startTime--;

    if (self.startTime - self.currentTime <= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CZHCountDownFinishNotification object:nil];
        
        return;
    }
}

- (NSInteger)getTime {
    
    NSDate *senddate = [NSDate date];
    
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    
    return [date2 integerValue];
}

@end
