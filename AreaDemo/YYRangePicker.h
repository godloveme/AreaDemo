//
//  YYAgePicker.h
//  AreaDemo
//
//  Created by Dark King on 15/7/13.
//  Copyright (c) 2015年 youyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"

#define HALF_SCREEN_WIDTH 160
#define kPickerTitleSize   16
typedef void (^YYRangeSelected)(int smallNumber, int bigNumber);


@interface YYRangePicker : NSObject<ActionSheetCustomPickerDelegate>

@property(nonatomic,assign)int minNumber;      //最大值
@property(nonatomic,assign)int maxNumber;      //最小值

@property(nonatomic,assign)int smallIndex;     //小值的索引
@property(nonatomic,assign)int bigIndex;       //大值的索引

@property(nonatomic,strong)NSString* unit;      //单位名称，如：岁，厘米(CM)

@property(nonatomic, assign)YYRangeSelected done;

-(instancetype)initWithRangeFrom:(int)min
                              to:(int)max
                            unit:(NSString*)unit
                            done:(YYRangeSelected)selected;

@end
