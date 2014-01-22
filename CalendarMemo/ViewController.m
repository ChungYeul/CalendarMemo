//
//  ViewController.m
//  CalendarMemo
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
#import "CalendarCell.h"

#define CALENDAR_CELL @"CALENDAR_CELL"
#define SECONDS_PER_DAY 24 * 60 * 60

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *yymmddLabel;

@end

@implementation ViewController {
    NSCalendar *_calendar;
    NSDateComponents *_weekdayComponent;
    NSInteger _currentWeekDay; // 해당 달의 시작 요일 (1=일요일, 2=월요일,...)
    int _MonthLastDay; // 해당 달의 마지막 날.
    unsigned int _unitFlags; // 각각 연, 월, 일, 시, 분, 초 구성요소를 사용한다고 지정하는 플래그 연산이다.
    int _aDay;
}

- (IBAction)doPrevMonth:(id)sender {
    if (1 == [_weekdayComponent month]) {
        [_weekdayComponent setMonth:12];
        [_weekdayComponent setYear:([_weekdayComponent year] - 1)];
    }
    else {
        [_weekdayComponent setMonth:([_weekdayComponent month] - 1)];
    }
    _MonthLastDay = [self GetLastDayOfMonth:_weekdayComponent];
    [self refreshCalendarLabel];
}
- (IBAction)doNextMonth:(id)sender {
    if (12 == [_weekdayComponent month]) {
        [_weekdayComponent setMonth:1];
        [_weekdayComponent setYear:([_weekdayComponent year] + 1)];
        [_weekdayComponent setDay:1];
    }
    else {
        [_weekdayComponent setMonth:([_weekdayComponent month] + 1)];
        [_weekdayComponent setDay:1];
    }
    
    NSDate *dateFuture = [_calendar dateFromComponents:_weekdayComponent];
    _weekdayComponent = [_calendar components:_unitFlags fromDate:dateFuture];
    _aDay = 1;
    _MonthLastDay = [self GetLastDayOfMonth:_weekdayComponent];
    
    [self.collectionView reloadData];
    
    [self refreshCalendarLabel];
}

//
-(int)GetLastDayOfMonth:(NSDateComponents *)compsMonth
{
    int last_day = 27;
    NSCalendar *cal=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *compsMonth = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
//    [compsMonth setDay:last_day];
    long month = [compsMonth month];
    while(TRUE){
        [compsMonth setDay:last_day+1];
        NSDate *dateFuture = [cal dateFromComponents:compsMonth];
        NSDateComponents *futureComps = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:dateFuture];
        if(month != [futureComps month]){
            return last_day;
        }
        last_day+=1;
    }
    return last_day;
}

- (void)refreshCalendarLabel {
    self.yymmddLabel.text = [NSString stringWithFormat:@"%ld년 %ld월",
                             (long)[_weekdayComponent year],
                             (long)[_weekdayComponent month]];
    NSLog(@"%d", _MonthLastDay);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *today = [NSDate date];
    _calendar = [NSCalendar currentCalendar];
    _unitFlags = NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    _weekdayComponent = [_calendar components:_unitFlags fromDate:today];
    _MonthLastDay = [self GetLastDayOfMonth:_weekdayComponent];
    _aDay = 1;
    
    //
    _currentWeekDay = [_weekdayComponent weekday];
    
    [self refreshCalendarLabel];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 재사용 큐에 셀을 가져온다
	UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CALENDAR_CELL forIndexPath:indexPath];
	
	// 선택 상태에 따른 셀UI 업데이트
	// "#3. 셀에 대해 더 깊이 파고들어가보자" 글에 있는 약간의 수정 부분에 대한 해결방법. 아래의 두줄이 있을때와 없을때를 비교해보세요.
	cell.layer.borderColor = (cell.selected) ? [UIColor yellowColor].CGColor : nil;
	cell.layer.borderWidth = (cell.selected) ? 5.0f : 0.0f;
    
    // 표시할 이미지 설정
    if (_currentWeekDay <= indexPath.row+1 &&
        _MonthLastDay >= indexPath.row+1) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = [NSString stringWithFormat:@"%d", _aDay];
        [cell addSubview:lbl];
        _aDay++;
    }
	return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.layer.borderColor = nil;
    cell.layer.borderWidth = 0.0f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.row);
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.layer.borderColor = [UIColor yellowColor].CGColor;
    cell.layer.borderWidth = 5.0f;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.layer.borderColor = nil;
    cell.layer.borderWidth = 0.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
