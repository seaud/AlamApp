//
//  MainViewController.h
//  AlamApp
//
//  Created by 손세명 on 2015. 7. 24..
//  Copyright (c) 2015년 son. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainClockView.h"

@interface MainViewController : UIViewController
{
    NSTimer *timer; //타이머 객체
    
    //디지털 시간을 표시할 UILabel을 참조하기 위해 IBOutlet으로 선언합니다.
    //Main.storyboard 파일의 MainViewController에 추가한 UILabel 객체와
    //clockDisplay 참조 변수를 연결합니다.
    IBOutlet UILabel *clockDisplay; //디지털시계를 표현할 Label 참조 변수
    
    //pClockView 변수는 아날로그시계를 표현하는 MainClockView 클래스로,
    //IBOutlet 선언을 통해 객체를 참조합니다.
    //아웃렛 참조 변수는 인터페이스 빌더를 통해 해당 객체와 연결해 주어야 합니다.
    IBOutlet MainClockView *pClockView; //아날로그시계를 표현할 UIView 참조 변수
}

//타이머에 의해 호출되는 콜백 함수입니다.
-(void)onTimer;

//알람 설정 화면에서 알람 설정 및 알람시 시간, 알람 분을 보관하는 변수입니다.
@property Boolean pAlamOnOff; //알람 여부
@property int pAlamHour; //알람 시간
@property int pAlamMinute; //알람 분



@end
