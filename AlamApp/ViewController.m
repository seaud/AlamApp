//
//  ViewController.m
//  AlamApp
//
//  Created by 손세명 on 2015. 7. 24..
//  Copyright (c) 2015년 son. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize infoButton;
@synthesize mainViewController;
@synthesize setupViewController; //알람 설정 화면 구현시 사용

//ViewController의 화면이 초기화된 후 호출되는 메서드
//알람시계 앱에서는 초기 화면을 알람시계 화면(MainViewController)으로 설정하기 위해
//insertSubView메서드를 이용합니다.
- (void)viewDidLoad {
    
    //이 메서드는 스토리보드에 있는 객체를 가져오는 데 사용합니다.
    //인자로서 객체의 식별자(idenifier)를 문자열로 설정해야 합니다.
    //알람시계 화면 뷰컨트롤러의 식별자는 클래스명도 동일하게'MainViewController'로 설정합니다.
    //Main.storyboard파일을 열어 'Main View Controller'를 선택한 후 Identity Inspector의
    //Storyboard ID를 'MainViewController'로 입력합니다.
    MainViewController *viewController = [self.storyboard
                                          instantiateViewControllerWithIdentifier:
                                          @"MainViewController"];
    mainViewController = viewController;
    
    //infoButton 뒤로 MainViewController.view를 넣습니다.
    [self.view insertSubview:viewController.view belowSubview:infoButton];
    
    [super viewDidLoad];
}

//알람 설정 버튼을 클릭하면 호출합니다.
-(IBAction)setupClick {
    if(setupViewController == nil)
    {
        setupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SetupViewController"];
    }
    [self presentViewController:setupViewController animated:YES completion:nil];
}

//알람 설정 화면에서 완료 버튼을 클릭하면 호출됩니다.
-(IBAction)closeClick {
    [self AlarmSetting];
    [setupViewController dismissViewControllerAnimated:YES completion:nil];
}

//알람 여부 및 시간을 설정합니다.
-(void)AlarmSetting
{
    mainViewController.pAlamOnOff = setupViewController.switchControl.on;
    
    if(mainViewController.pAlamOnOff == YES) //알람이 설정되어 있는 경우
    {
        NSCalendar *pCalendar = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth
                            | NSCalendarUnitDay | NSCalendarUnitHour
                            | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDate *date = [setupViewController.pDatePicker date];
        NSDateComponents *comps = [pCalendar components:unitFlags fromDate:date];
        mainViewController.pAlamHour = (int)[comps hour]; //알람 시간
        mainViewController.pAlamMinute = (int)[comps minute]; //알람 분
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
