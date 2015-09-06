//
//  ViewController.m
//  AreaDemo
//
//  Created by Dark King on 15/7/8.
//  Copyright (c) 2015年 youyuan. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"

#import "YYAreaPicker.h"
#import "YYRangePicker.h"

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
    {
        YYAreaPicker *delg = [[YYAreaPicker alloc] initWithPrivince:1 andCity:6 done:^(int privinceId, int cityId) {
            NSLog(@"%d   ```````   %d",privinceId,cityId);
        }];
        [ActionSheetCustomPicker showPickerWithTitle:@"籍贯" delegate:delg showCancelButton:YES origin:tableView initialSelections:delg.initialSelections];
    }
    else if (indexPath.row == 1)
    {
        YYRangePicker *age = [[YYRangePicker alloc] initWithRangeFrom:18 to:68 unit:@"岁" done:^(int smallNumber, int bigNumber) {
            NSLog(@"选择了[%d,%d]",smallNumber,bigNumber);
        }];
        //初始化传入的是索引，这里索引的起始都是从最小值算起
        NSArray * initialSelections = [NSArray arrayWithObjects:@"1",@"2", nil];
        
        [ActionSheetCustomPicker showPickerWithTitle:@"年龄" delegate:age showCancelButton:YES origin:tableView initialSelections:initialSelections];
    }
    else if(indexPath.row == 2)
    {
        YYRangePicker *height = [[YYRangePicker alloc] initWithRangeFrom:150 to:200 unit:@"CM" done:^(int smallNumber, int bigNumber) {
            NSLog(@"选择了[%d,%d]",smallNumber,bigNumber);
        }];
        //初始化传入的是索引
        NSArray * initialSelections = [NSArray arrayWithObjects:@"0",@"0", nil];
        
        [ActionSheetCustomPicker showPickerWithTitle:@"身高" delegate:height showCancelButton:YES origin:tableView initialSelections:initialSelections];
    }
    
    
    
}

@end
