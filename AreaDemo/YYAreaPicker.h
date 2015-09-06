//
//  DKAreaPicker.h
//  AreaDemo
//
//  Created by Dark King on 15/7/8.
//  Copyright (c) 2015年 youyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"

#define PRIVINCE_ID     @"id"
#define PRIVINCE_NAME   @"name"
#define CITY_ID         @"id"
#define CITY_NAME       @"name"

#define CITYLIST        @"cityList"

#define HALF_SCREEN_WIDTH 160
#define kPickerTitleSize   16

typedef void (^YYAreaSelected)(int privinceId, int cityId);

@interface YYAreaPicker : NSObject<ActionSheetCustomPickerDelegate>

@property(nonatomic,assign)int privinceId;      //省份id
@property(nonatomic,assign)int cityId;          //城市id

@property(nonatomic,assign)int privinceIndex;   //省份索引
@property(nonatomic,assign)int cityIndex;       //城市索引

@property(nonatomic,strong)NSArray*  initialSelections;  //省份和城市的初始索引值

/*
 *  @brief  初始化数组
 *  @param  privinceId  初始省份id
 *  @param  cityId      初始城市id
 *  @param  selected    选择后的回调
 *  @return 自定义地点选择pickerView
 */
-(instancetype)initWithPrivince:(int)privinceId
                        andCity:(int)cityId
                           done:(YYAreaSelected)selected;

@end
