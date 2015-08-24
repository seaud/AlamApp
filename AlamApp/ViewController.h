//
//  ViewController.h
//  AlamApp
//
//  Created by 손세명 on 2015. 7. 24..
//  Copyright (c) 2015년 son. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "SetupViewController.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) SetupViewController *setupViewController;

//시계 화면과 알람 설정 화면이 전활될 때 호출되는 이벤트 함수입니다.
-(IBAction)setupClick; //알람 설정 버튼 클릭시 호출되는 메서드

//알람 설정 화면에서 완료 버튼 클릭시 호출되는 메서드로, 알람 설정 화면을 닫습니다.
-(IBAction)closeClock; //알람 설정 화면에서 완료 버튼 클릭시 호출되는 메서드

//알람 여부 및 시간을 설정합니다.
-(void)AlarmSetting; //알람 설정 메서드

@end

