//
//  MemoCenter.m
//  CalendarMemo
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "MemoCenter.h"
#import <sqlite3.h>
@implementation MemoCenter {
    sqlite3 *_db;
}
static MemoCenter *_instance = nil;
+(id)sharedMemoCenter {
    if (_instance == nil) {
        _instance = [[MemoCenter alloc] init];
        [_instance openDB];
    }
    return _instance;
}
// DB 작업 모두 여기서 한다
// 데이터베이스 오픈, 없으면 새로 만든다
- (void)openDB {
    // 데이터베이스 파일 경로 구하기
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbFilePath = [docPath stringByAppendingPathComponent:@"db.sqlite"];
    
    // 데이터 베이스 파일 체크
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL existFile = [fm fileExistsAtPath:dbFilePath];
    
    // copy해야하는 이유는.. 복사를 하지않으면 읽기전용으로 불려오기때문에..
    if (existFile == NO) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"db.sqlite"];
        NSError *error;
        BOOL success = [fm copyItemAtPath:defaultDBPath toPath:dbFilePath error:&error];
        
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }
    }
    //
    
    // 데이터 베이스 오픈
    int ret = sqlite3_open([dbFilePath UTF8String], &_db);
    NSAssert1(SQLITE_OK == ret, @"Error on opening Database : %s", sqlite3_errmsg(_db));
    NSLog(@"Success on Opening Database");
    
    // 새롭게 데이터베이스를 만들었으면 테이블을 생성한다
    if (NO == existFile) {
        // 테이블 생성
        const char *createSQL = "CREATE TABLE IF NOT EXISTS MEMO (DAY TEXT, MEMOTXT TEXT)";
        char *errorMsg;
        ret = sqlite3_exec(_db, createSQL, NULL, NULL, &errorMsg);
        if (ret != SQLITE_OK) {
            [fm removeItemAtPath:dbFilePath error:nil];
            NSAssert1(SQLITE_OK == ret, @"Error on creating : %s", errorMsg);
            NSLog(@"creating table with ret : %d", ret);
        }
    }
}

// 새로운 데이터를 데이터베이스에 저장한다
- (void)insertData:(NSString *)txt WithDay:(NSString *) day {
    NSLog(@"adding data : %@", txt);
    
    // sqlite3_exec 로 실행하기
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO MEMO (DAY, MEMOTXT) VALUES ('%@', '%@')", day, txt];
    
    char *errMsg;
    int ret = sqlite3_exec(_db, [sql UTF8String], NULL, nil, &errMsg);
    
    if (SQLITE_OK != ret) {
        NSLog(@"Error on Insert New data : %s", errMsg);
    }
}

// 데이터베이스에서 정보를 가져온다
- (NSString *) resolveData:(NSString *) day {
    // 데이터 베이스에서 사용할 쿼리 준비
//    NSString *queryStr = @"SELECT memotxt FROM MEMO";
    NSString *queryStr = [NSString stringWithFormat:@"SELECT memotxt FROM MEMO WHERE day = '%@'", day];
    NSString *result;
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare_v2(_db, [queryStr UTF8String], -1, &stmt, NULL);
    NSAssert2(SQLITE_OK == ret, @"Error(%d) on resolving data : %s", ret, sqlite3_errmsg(_db));
    
    // 모든 행의 정보를 얻어온다
    while (SQLITE_ROW == sqlite3_step(stmt)) {
        char *txt = (char *)sqlite3_column_text(stmt, 0);
        
        result = [NSString stringWithCString:txt encoding:NSUTF8StringEncoding];
    }
    sqlite3_finalize(stmt);
    return result;
}

// 제목 수정
- (void)updateData:(NSString *)txt WithDay:(NSString *) day {
    // sqlite3_exec 로 실행하기
    // 인스턴스 변수 사용 안하고 짜기
    NSString *sql = [NSString stringWithFormat:@"UPDATE MEMO SET memotxt = '%@' WHERE day = '%@'", txt, day];
    // 인스턴스 변수 사용
    //    NSString *sql = [NSString stringWithFormat:@"UPDATE MOVIE SET title = '%@' WHERE rowid = %d", name, _currentRowID];
    NSLog(@"sql : %@", sql);
    
    char *errMsg;
    int ret = sqlite3_exec(_db, [sql UTF8String], NULL, nil, &errMsg);
    
    if (SQLITE_OK != ret) {
        NSLog(@"Error on Insert New data : %s", errMsg);
    }
}
@end
