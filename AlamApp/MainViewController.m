//
//  MainViewController.m
//  AlamApp
//
//  Created by 손세명 on 2015. 7. 24..
//  Copyright (c) 2015년 son. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

//NSTimer 클래스를 이용해 타이머를 설정합니다.
//주기적으로 작업을 반복할 때뿐만 아니라 지정한 시간에도 타이머 이벤트를 발생시킬 수 있습니다.
- (void)viewDidLoad {
    [self onTimer]; //타이머를 설정합니다.
    
    //1초마다 onTimer메서드를 호출하도록 설정합니다.
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0)
            target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    //현재 시간을 뷰에 표현할 폰트를 설정합니다.
    //디지털 시간이 표시될 Label의 폰트와 글자 크기를 설정합니다.
    [clockDisplay setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:64.0]];
    
    [super viewDidLoad];
}


//타이머의 이벤트가 발생했을 때 호출되는 콜백 함수입니다.
-(void)onTimer {
    int phour, pminute, psecond;
    
    NSCalendar *pCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |
                            NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    
    //NSDate클래스는 시스템 간에 통용될 수 있는 어느 한 시점을 표현하는 클래스로,
    //영국 기즌으로 특정 시간으로부터 얼마만큼의 시간이 지났는지를 의미하며 시스템이
    //이해할 수 있는 데이터를 포함하고 있습니다.
    //NSDate 클래스의 시간은 객체 생성 시점의 날짜와 시간으로 초기화되지만 특정 시점의 시간으로
    //초기화될 때는 initWithString메서드를 이용해 초기화할 수 있습니다.
    NSDate *date = [NSDate date]; //현재 시간을 구합니다.
    
    //NSDate 객체에서는 사람이 이해할 수 있게 NSCalendar, NSDateComponents 등의 날짜 관련
    //클래스를 이용해 변환해야 합니다.
    //NSCalendar 클래스는 세계에 있는 다양한 형태의 날짜와 시간 포맷을 제공합니다.
    //yyyy-mm-dd hh:mm:ss 형식으로 날짜를 변환합니다.
    NSDateComponents *comps = [pCalendar components:unitFlags fromDate:date];
    phour = (int)[comps hour];      //현재 시간 : 시
    pminute = (int)[comps minute];  //현재 시간 : 분
    psecond = (int)[comps second];  //현재 시간 : 초
    
    //현재 시간을 화면에 출력합니다.
    clockDisplay.text = [NSString stringWithFormat:@"%02d:%02d:%02d", phour, pminute, psecond];
    
    pClockView.pHour = phour;
    pClockView.pMinute = pminute;
    pClockView.pSecond = psecond;
    
    //타이머 이벤트가 발생할 때마다 현재 시간을 표시해야 합니다.
    //UIView 객체는 생성될 때 viewDidLoad메서드를 호출한 후에 DrawRect 이벤트를 이용해 화면을 그립니다.
    //그 이후에 화면을 갱신하고자 할 때는 setNeedsDisplay 메서드를 이용하고
    //이 메서드에서 DrawRect 이벤트를 호출합니다.
    [pClockView setNeedsDisplay]; //아날로그시계 뷰를 다시 그립니다.
    if(self.pAlamOnOff == YES)
    {
        if(self.pAlamHour == phour && self.pAlamMinute == pminute && psecond == 0)
        {
            [self messageDisplay];
        }
    }
    
}

-(void)messageDisplay
{
    UIAlertView *AlrmView = [[UIAlertView alloc] initWithTitle:@"알람시계"
                                                       message:@"약속시간입니다."
                                                      delegate:nil
                                             cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                             otherButtonTitles:nil];
    [AlrmView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
