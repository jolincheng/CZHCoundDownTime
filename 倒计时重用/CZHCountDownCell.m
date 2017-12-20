//
//  CZHCountDownCell.m
//  倒计时重用
//
//  Created by 程召华 on 2017/12/20.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHCountDownCell.h"

@interface CZHCountDownCell ()

/**小时*/
@property (nonatomic, weak) UILabel *hourLabel;
/**第一个分号*/
@property (nonatomic, weak) UILabel *colonOne;
/**分钟*/
@property (nonatomic, weak) UILabel *miniteLabel;
/**第二个分号*/
@property (nonatomic, weak) UILabel *colonTwo;
/**秒钟*/
@property (nonatomic, weak) UILabel *secondLabel;
///<#注释#>
@property (nonatomic, weak) UILabel *indexLabel;
///<#注释#>
@property (nonatomic, strong) CZHCountDownModel *timeModel;
///<#注释#>
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *const ID = @"CZHCountDownCell";
@implementation CZHCountDownCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    CZHCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[CZHCountDownCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTime) name:CZHUpdateTimeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownFinish) name:CZHCountDownFinishNotification object:nil];
        
        [self setCell];
        
    }
    return self;
}




- (void)setCellWithTimeModel:(CZHCountDownModel *)timeModel indexPath:(NSIndexPath *)indexPath {
    
    self.timeModel = timeModel;
    self.indexPath = indexPath;
    
    NSInteger countDownTime = timeModel.startTime - timeModel.currentTime;
    
    if (countDownTime <= 0) {
        self.hourLabel.text = @"00";
        self.miniteLabel.text = @"00";
        self.secondLabel.text = @"00";
    } else {
        self.hourLabel.text = [NSString stringWithFormat:@"%02ld", countDownTime/3600];
        self.miniteLabel.text = [NSString stringWithFormat:@"%02ld", countDownTime%3600/60];
        self.secondLabel.text = [NSString stringWithFormat:@"%02ld", countDownTime%60];
    }
    
    self.indexLabel.text = [NSString stringWithFormat:@"位置:%ld",self.indexPath.row];
}

//刷新时间
- (void)updateTime {
    
    [self setCellWithTimeModel:self.timeModel indexPath:self.indexPath];
    
}

//倒计时完成
- (void)countDownFinish {
    
    if (self.timeModel.startTime - self.timeModel.currentTime > 0 || self.timeModel.isFinished == YES) {
        return;
    }

    self.timeModel.isFinished = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:countDownDidFinishedWithTimeModel:indexPath:)]) {
        [self.delegate cell:self countDownDidFinishedWithTimeModel:self.timeModel indexPath:self.indexPath];
    }
    
    NSLog(@"---倒计时完成%ld", self.indexPath.row);
    
}

- (void)setCell {
    
    UILabel *hourLabel = [self quickSetUpLabel];
    self.hourLabel = hourLabel;
    
    UILabel *colonOne = [self quickSetUpLabel];
    colonOne.text = @":";
    self.colonOne = colonOne;
    
    UILabel *miniteLabel = [self quickSetUpLabel];
    self.miniteLabel = miniteLabel;
    
    UILabel *colonTwo = [self quickSetUpLabel];
    colonTwo.text = @":";
    self.colonTwo = colonTwo;
    
    UILabel *secondLabel = [self quickSetUpLabel];
    self.secondLabel = secondLabel;
    
    UILabel *indexLabel = [self quickSetUpLabel];
    self.indexLabel = indexLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width / 4;
    CGFloat h = self.frame.size.height;
    
    self.hourLabel.frame = CGRectMake(0, 0, w , h);
    
    self.colonOne.frame = CGRectMake(CGRectGetMaxX(self.hourLabel.frame) - 2, 0, 4, h);
    
    self.miniteLabel.frame = CGRectMake(w , 0, w , h);
    
    self.colonTwo.frame = CGRectMake(CGRectGetMaxX(self.miniteLabel.frame) - 2, 0, 4, h);
    
    self.secondLabel.frame = CGRectMake(w * 2 , 0, w , h);
    
    self.indexLabel.frame  = CGRectMake(CGRectGetMaxX(self.secondLabel.frame), 0, w, h);
}

- (UILabel *)quickSetUpLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    return label;
}

@end
