//
//  MainClockView.m
//  AlamApp
//
//  Created by 손세명 on 2015. 7. 27..
//  Copyright (c) 2015년 son. All rights reserved.
//

#import "MainClockView.h"

#define SECOND_WIDTH 100
#define MINUTE_WIDTH 75
#define HOUR_WIDTH 50

@implementation MainClockView

@synthesize pHour;
@synthesize pMinute;
@synthesize pSecond;

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    //nib파일을 로드할 경우 파일 안에 선언된 모든 객체를 생성하는데, 이 때 initWithCoder 메서드를 호출합니다.
    self = [super initWithCoder:aDecoder]; //initWithCoder 메서드
    
    //시계 이미지를 불러온 후 CGImageRetain함수를 사용해 CGImageRef형으로 변환합니다.
    UIImage *img = [UIImage imageNamed:@"clock.png"]; //시계 이미지를 불러옵니다.
    imgClock = CGImageRetain(img.CGImage);
    return self;
}

//뷰가 다시 그려질 경우 호출됩니다.
- (void) drawRect:(CGRect)rect {
    //현재 뷰의 그래픽 컨텍스트를 구합니다.
    //UIGraphicsGetCurrentContext 함수를 사용해 현재 뷰의 그래픽 컨텍스트를 구할 수 있습니다.
    //그래픽 컨텍스트는 색상, 선의 굵기, 선의 형태, 글꼴 정보 등 그림을 그리는 데 필요한 모든
    //상태 정보를 저장하고 있습니다.
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawClockBitmap:context]; //시계 이미지를 화면으로 출력합니다.
    [self drawLine:context]; //시, 분, 초를 화면으로 출력합니다.
}

-(void)drawLine:(CGContextRef)context {
    int centerX = self.bounds.size.width / 2; //X축 중심
    int centerY = self.bounds.size.height / 2; //Y축 중심
    
    [self DrawSecond:context CenterX:centerX CenterY:centerY]; //초침을 그립니다.
    [self DrawMinute:context CenterX:centerX CenterY:centerY]; //분침을 그립니다.
    [self DrawHour:context CenterX:centerX CenterY:centerY]; //시침을 그립니다.
}

//그래픽 컨텍스트와 시계의 중심 좌표를 인자로 받아 초침을 화면에 표시합니다.
//초침은 선으로 표현합니다.
-(void)DrawSecond:(CGContextRef)context CenterX:(int)pCenterX CenterY:(int)pCenterY {
    //현재의 초에 해당되는 좌표를 구합니다.
    int newX, newY;
    
    //초침의 끝점을 구하는 부분입니다.
    //CGContextSetRGBSetRGBStrokeColor와 CGContextSetLineWidth
    newX = (int)(sin(pSecond * 6 * 3.14/180) * SECOND_WIDTH + pCenterX);
    newY = (int)(pCenterY - (cos(pSecond * 6 * 3.14/180) * SECOND_WIDTH));
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0); //색상 지정 (검정)
    CGContextSetLineWidth(context, 2.0); //선의 굵기 지정
    
    //선을 화면에 그립니다. CGContextMoveToPoint 메서드는 선의 시작점을 지정하고
    //CGContextAddLineToPoint 메서드는 중간 및 끝점을 지정하는데,
    //시작점으로 이동한 후 다음 점까지 이동하면서 그리는 방식입니다.
    CGContextMoveToPoint(context, pCenterX, pCenterY); //선의 시작점 지정
    CGContextAddLineToPoint(context, newX, newY); //선의 끝점 지정
    CGContextStrokePath(context); //선그리기
}

//분침을 표현하는 메서드로, 선의 굵기를 3으로 지정합니다.
-(void)DrawMinute:(CGContextRef)context CenterX:(int)pCenterX CenterY:(int)pCenterY {
    int newX, newY;
    //분침의 끝점 좌표를 구합니다.
    newX = (int)(sin(pMinute * 6 * 3.14/180) * MINUTE_WIDTH + pCenterX);
    newY = (int)(pCenterY - (cos(pMinute * 6 * 3.14/180) * MINUTE_WIDTH));
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0); //색상 지정
    
    CGContextSetLineWidth(context, 3.0); //선의 굵기 지정
    CGContextMoveToPoint(context, pCenterX, pCenterY); //선의 시작점 지정
    CGContextAddLineToPoint(context, newX, newY); //선의 끝점 지정
    CGContextStrokePath(context); //선 그리기
}

//시침을 표현하는 메서드입니다.
-(void)DrawHour:(CGContextRef)context CenterX:(int)pCenterX CenterY:(int)pCenterY {
    int newX, newY;
    
    //시침의 끝점 좌표를 구합니다.
    newX = (int)(sin(pHour * 30 * 3.14/180) * HOUR_WIDTH + pCenterX);
    newY = (int)(pCenterY - (cos(pHour * 30 * 3.14/180) * HOUR_WIDTH));
    
    //선의 색상 지정
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0);
    
    //선의 두께 지정
    CGContextSetLineWidth(context, 4.0); //선의 굵기 지정
    CGContextMoveToPoint(context, pCenterX, pCenterY); //선의 시작점 지정
    CGContextAddLineToPoint(context, newX, newY); //선의 끝점 지정
    CGContextStrokePath(context); //선 그리기
}

//시계 이미지를 화면에 그리는 메서드입니다. 이미지를 쿼츠로 불러올 경우에는 쿼츠 좌표계를 따르게 되는데,
//쿼츠 좌표계는 일반적으로 사용하는 UIKit 좌표와는 상하가 반대로 놓여 있습니다.
-(void)drawClockBitmap:(CGContextRef)context {
    CGContextSaveGState(context); //CTM의 이전 상태를 저장
    
    //좌표에 대한 변환 작업
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height); //좌표의 원점으로 이동
    CGContextScaleCTM(context, 1.0, -1.0); //좌표계의 비율을 바꿈
    CGContextClipToRect(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    //이미지를 화면에 출력
    CGContextDrawImage(context, CGRectMake(0, 0,
        CGImageGetWidth(imgClock), CGImageGetHeight(imgClock)), imgClock);
    
    CGContextRestoreGState(context); //CTM의 이전 상태를 복구
}




@end

















