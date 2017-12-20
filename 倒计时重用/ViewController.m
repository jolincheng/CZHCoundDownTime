//
//  ViewController.m
//  倒计时重用
//
//  Created by 程召华 on 2017/12/20.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "ViewController.h"
#import "CZHCountDownCell.h"
@interface ViewController ()<UITableViewDataSource, CZHCountDownCellDelegate>

@property (nonatomic, strong) NSTimer *timer;
///<#注释#>
@property (nonatomic, strong) NSMutableArray *timeArrays;
///
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController


- (NSMutableArray *)timeArrays {
    if (!_timeArrays) {
        _timeArrays = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            CZHCountDownModel *timeModel = [[CZHCountDownModel alloc] init];
            [_timeArrays addObject:timeModel];
        }
    }
    return _timeArrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    
    [self setUpTimer];
    
    
}

- (void)setUpView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.rowHeight = 50;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZHCountDownCell *cell = [CZHCountDownCell cellWithTableView:tableView];
    cell.delegate = self;
//    cell.timeModel = self.timeArrays[indexPath.row];
    [cell setCellWithTimeModel:self.timeArrays[indexPath.row] indexPath:indexPath];
    return cell;
}


#pragma mark -- 代理
- (void)cell:(CZHCountDownCell *)cell countDownDidFinishedWithTimeModel:(CZHCountDownModel *)timeModel indexPath:(NSIndexPath *)indexPath {
    
    CZHCountDownModel *arrayTimeModel = self.timeArrays[indexPath.row];
    
    arrayTimeModel.isFinished = timeModel.isFinished;
    
}

//计时器
- (void)setUpTimer {
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    for (CZHCountDownModel *timeModel in self.timeArrays) {
       
        if (timeModel.startTime - timeModel.currentTime <= 0) {
            continue;
        }

        [timeModel countDown];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CZHUpdateTimeNotification object:nil];
        
    }
    
}


@end
