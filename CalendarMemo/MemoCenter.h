//
//  MemoCenter.h
//  CalendarMemo
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoCenter : NSObject

+(id)sharedMemoCenter;

- (void)insertData:(NSString *)txt WithDay:(NSString *) day;
- (NSString *) resolveData:(NSString *) day;
- (void)updateData:(NSString *)txt WithDay:(NSString *) day;
@end
