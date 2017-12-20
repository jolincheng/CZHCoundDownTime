//
//  CZHCountDownCell.h
//  倒计时重用
//
//  Created by 程召华 on 2017/12/20.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZHCountDownModel.h"

@class CZHCountDownCell;
@protocol CZHCountDownCellDelegate <NSObject>

@optional

- (void)cell:(CZHCountDownCell *)cell countDownDidFinishedWithTimeModel:(CZHCountDownModel *)timeModel indexPath:(NSIndexPath *)indexPath;

@end

@interface CZHCountDownCell : UITableViewCell

///代理
@property (nonatomic, weak) id<CZHCountDownCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setCellWithTimeModel:(CZHCountDownModel *)timeModel indexPath:(NSIndexPath *)indexPath;

@end
