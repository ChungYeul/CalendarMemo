//
//  MomoViewController.m
//  CalendarMemo
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "MomoViewController.h"
#import "MemoCenter.h"

@interface MomoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MomoViewController
- (IBAction)doBack:(id)sender {
    NSString *str = [[MemoCenter sharedMemoCenter] resolveData:self.selectDay];
    if (str == nil) {
        // 기존에 없다
        [[MemoCenter sharedMemoCenter] insertData:self.textView.text WithDay:self.selectDay];
    }
    else {
        // 기존에 있다
        [[MemoCenter sharedMemoCenter] updateData:self.textView.text WithDay:self.selectDay];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    self.label.text = self.selectDay;
    NSString *str = [[MemoCenter sharedMemoCenter] resolveData:self.selectDay];
    if (str == nil) {
        NSLog(@"저장된 내용 없다");
    }
    else {
        self.textView.text = str;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
