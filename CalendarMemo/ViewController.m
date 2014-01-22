//
//  ViewController.m
//  CalendarMemo
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController
-(int)GetLastDayOfMonth:(NSDate *)date
{
    int last_day = 27;
    NSCalendar *cal=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *compsMonth = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    [compsMonth setDay:last_day];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSLog(@"%@", gregorian);
    NSTimeInterval secondsPerDay = 24 * 60 * 60 * 20;
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponent01 = [calendar components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    
    NSDate *tomorrow = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
    
    int i = [self GetLastDayOfMonth:today];
    int j = [self GetLastDayOfMonth:tomorrow];
    
    NSLog(@"%d, %d", i, j);

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
