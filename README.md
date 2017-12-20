# CZHCoundDownTime

![这里写图片描述](http://img.blog.csdn.net/20171220122049901?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvSHVycnlVcENoZW5n/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)


核心就是在控制器中创建计时器，然后在模型中倒计时时间
```
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
```


[简书地址](http://www.jianshu.com/u/2add458bf239)
[博客地址](http://blog.csdn.net/hurryupcheng)
