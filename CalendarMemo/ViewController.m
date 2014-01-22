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
    NSDateComponents *_weekdayComponent;
    int _MonthLastDay; // 해당 달의 마지막 날.
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
    }
    else {
        [_weekdayComponent setMonth:([_weekdayComponent month] + 1)];
    }
    _MonthLastDay = [self GetLastDayOfMonth:_weekdayComponent];
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
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit; // 각각 연, 월, 일, 시, 분, 초 구성요소를 사용한다고 지정하는 플래그 연산이다.
    _weekdayComponent = [calendar components:unitFlags fromDate:today];
    _MonthLastDay = [self GetLastDayOfMonth:_weekdayComponent];
    [self refreshCalendarLabel];
    
//    NSDate *tomorrow = [[NSDate alloc] initWithTimeIntervalSinceNow:_secondsPerDay];
//    int i = [self GetLastDayOfMonth:_today];
//    int j = [self GetLastDayOfMonth:tomorrow];
//    NSLog(@"%d, %d", i, j);

    //
//    NSLog(@"calendar : %@", [weekdayComponent calendar]);
//    NSLog(@"timezone : %@", [weekdayComponent timeZone]);
//    NSLog(@"era : %ld", (long)[weekdayComponent era]);
//    NSLog(@"year : %ld", (long)[weekdayComponent year]);
//    NSLog(@"month : %ld", (long)[weekdayComponent month]);
//    NSLog(@"day : %ld", (long)[weekdayComponent day]);
//    NSLog(@"hour : %ld", (long)[weekdayComponent hour]);
//    NSLog(@"minute : %ld", (long)[weekdayComponent minute]);
//    NSLog(@"second : %ld", (long)[weekdayComponent second]);
//    NSLog(@"week : %ld", (long)[weekdayComponent week]);
//    NSLog(@"weekday : %ld", (long)[weekdayComponent weekday]);
//    NSLog(@"weekdayOrdinal : %ld", (long)[weekdayComponent weekdayOrdinal]);
//    NSLog(@"quarter : %ld", (long)[weekdayComponent quarter]);
//    NSLog(@"weekOfMonth : %ld", (long)[weekdayComponent weekOfMonth]);
//    NSLog(@"weekOfYear : %ld", (long)[weekdayComponent weekOfYear]);
//    NSLog(@"yearForWeekOfYear : %ld", (long)[weekdayComponent yearForWeekOfYear]);
    
//    NSLog(@"%ld, %ld", day, (long)weekday);
    
    
//    NSDate *today = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit
//                                                      fromDate:today];
//    // 오늘 날짜의 요일을 뽑아 이를 사용해 일요일의 날짜를 구하기
//    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
//    offsetComponents.day = 0 - (weekdayComponents - 1);
//    NSDate *beginningOfThisWeek = [calendar
//                                   dateByAddingComponents:offsetComponents
//                                   toDate:today
//                                   options:0];
    
    
    
    
    
    
    
    
    
    
    
//    NSCalendar *calendar1 = [NSCalendar currentCalendar];
//    NSLog(@"currentCalendar : %@", calendar1);
//    
//    // calendarIdentifier
//    NSString *identifier = [calendar1 calendarIdentifier];
//    NSLog(@"identifier method : %@.", identifier);
//    identifier = nil;
//    
//    // components:fromDate:
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
//    NSDate *date1 = [NSDate date];
//    NSDateComponents *dateComponent1 = [calendar1 components:unitFlags fromDate:date1];
//    NSLog(@"NSDateComponents : %lu-%lu-%lu", [dateComponent1 year], [dateComponent1 month], [dateComponent1 day]);
//    date1 = nil;
//    dateComponent1 = nil;
//    
//    // datefromComponents:
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setYear:1965];
//    [comps setMonth:1];
//    [comps setDay:6];
//    [comps setHour:14];
//    [comps setMinute:10];
//    [comps setSecond:0];
//    
//    NSDate *date2 = [calendar1 dateFromComponents:comps];
//    NSLog(@"dateFromComponents : %@.", date2);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CALENDAR_CELL forIndexPath:indexPath];
    cell.cellLabel.text = @"1";
    return cell;
    /*
    // 재사용 큐에 셀을 가져온다
	UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CALENDAR_CELL forIndexPath:indexPath];
	
	// 선택 상태에 따른 셀UI 업데이트
	// "#3. 셀에 대해 더 깊이 파고들어가보자" 글에 있는 약간의 수정 부분에 대한 해결방법. 아래의 두줄이 있을때와 없을때를 비교해보세요.
	cell.layer.borderColor = (cell.selected) ? [UIColor yellowColor].CGColor : nil;
	cell.layer.borderWidth = (cell.selected) ? 5.0f : 0.0f;
    
//    cell.labelDisplay.text
    //	// 표시할 이미지 설정
    //	UIImageView* imgView = (UIImageView*)[cell.contentView viewWithTag:100];
    //	if (imgView) imgView.image = self.dataList[indexPath.section][indexPath.row];
    //
     */
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
