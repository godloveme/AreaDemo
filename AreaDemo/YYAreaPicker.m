//
//  DKAreaPicker.m
//  AreaDemo
//
//  Created by Dark King on 15/7/8.
//  Copyright (c) 2015年 youyuan. All rights reserved.
//
#import "YYAreaPicker.h"
#warning 假如使用其他方法提供信息，需要屏蔽该段数据
#import "JSONKit.h"

@implementation YYAreaPicker
{
    NSArray* _area;                         //省市所有信息
    NSMutableArray* _cityList;              //当前省份下属城市
    
    NSMutableArray* _privinceNames;         //省份名称列表
    NSMutableArray* _cityNames;             //选中省份中城市名称列表
    
    YYAreaSelected _selected;
}



-(instancetype)initWithPrivince:(int)privinceId andCity:(int)cityId done:(YYAreaSelected)selected
{
    if (self = [super init])
    {
#warning 实际项目中_area  =  APP_UTILTY.areaArray;
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"];
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        _area = [[JSONDecoder decoder] parseJSONData:data];
        
        _selected = selected;
        _privinceId = privinceId;
        _privinceIndex = _privinceId - 1; //因为省份是从0开始的  假如这里有“不限”需要另外处理
        _cityId = cityId;
        
        _privinceNames = [[NSMutableArray alloc] initWithCapacity:34];
        _cityNames = [[NSMutableArray alloc] initWithCapacity:20];
        
        NSAssert(_area, @"数组不能为空！");
        for (NSDictionary* item in _area) {
            [_privinceNames addObject:[item objectForKey:PRIVINCE_NAME]];
        }
        
        NSDictionary* privinceInfo = [[NSDictionary alloc] initWithDictionary:_area[_privinceIndex]];
        _cityList = [privinceInfo objectForKey:CITYLIST];
        for (NSDictionary* item in _cityList) {
            [_cityNames addObject:[item objectForKey:CITY_NAME]];
        }
        _cityIndex = [self city:_cityList withCityId:_cityId];
        
        self.initialSelections = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:_privinceIndex],[NSNumber numberWithInt:_cityIndex], nil];
        
    }
    return self;
}

-(void)setPrivinceIndex:(int)privinceIndex
{
    _privinceIndex = privinceIndex;
    _privinceId = _privinceIndex + 1;
    NSDictionary* privinceInfo = _area[_privinceIndex];
    _cityList = [privinceInfo objectForKey:CITYLIST];
    [_cityNames removeAllObjects];
    for (NSDictionary* item in _cityList) {
        [_cityNames addObject:[item objectForKey:CITY_NAME]];
    }
}

-(void)setCityIndex:(int)cityIndex
{
    _cityIndex = cityIndex;
    _cityId = [[_cityList[_cityIndex] objectForKey:CITY_ID] intValue];
}


-(int)city:(NSArray*)cityList withCityId:(int)cityId
{
    int index = 0;
    for (; index < cityList.count; index++) {
        if ([[cityList[index] objectForKey:CITY_ID] intValue] == cityId) {
            break;
        }
    }
    return index;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    switch (component) {
        case 0: return _area.count;
        case 1:return _cityList.count;
        default:break;
    }
    return 0;
}

//选择确认后的处理
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    _selected(_privinceId,_cityId);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return HALF_SCREEN_WIDTH;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //每列展示什么
    switch (component) {
        case 0: return _privinceNames[row];
        case 1: return _cityNames[row];
        default:break;
    }
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    if (0 == component) {
        CGFloat width = HALF_SCREEN_WIDTH;
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 30)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [_privinceNames objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:kPickerTitleSize];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    else if(1 == component)
    {
        CGFloat width = 160;
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 30)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [_cityNames objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:kPickerTitleSize];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }

    return myView;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (0 == component) {
        //选择省
        self.privinceIndex = (int)row;
        self.cityIndex = 0;
        //更新第二个轮子
        [pickerView reloadComponent:1];
        //更新第2个轮子的时候，现在默认就是第一个吧
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
    }else if (1 == component)
    {
        //选择市
        self.cityIndex = (int)row;
    }
}


@end
