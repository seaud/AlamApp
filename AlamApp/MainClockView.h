//
//  MainClockView.h
//  AlamApp
//
//  Created by 손세명 on 2015. 7. 27..
//  Copyright (c) 2015년 son. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainClockView : UIView {
    
    //CGImageRef는 쿼츠(Quartz)에서 사용하는 이미지 클래스입니다.
    CGImageRef imgClock; // 이미지
    int pHour; //현재 시간 : 시
    int pMinute; //현재 시간 : 분
    int pSecond; //현재 시간 : 초
}

//아날로그시계를 화면에 표시하기 위해 5개의 draw 함수를 선언합니다.
-(void)drawLine:(CGContextRef)context; //선을 화면에 그립니다.
-(void)drawClockBitmap:(CGContextRef)context; //시계 이미지를 화면에 그립니다.
-(void)DrawSecond:(CGContextRef)context CenterX:(int)pCenterX CenterY:(int)pCenterY; //초침
-(void)DrawMinute:(CGContextRef)context CenterX:(int)pCenterX CenterY:(int)pCenterY; //분침
-(void)DrawHour:(CGContextRef)context CenterX:(int)pCenterX CenterY:(int)pCenterY; //시침

@property int pHour;
@property int pMinute;
@property int pSecond;

@end
