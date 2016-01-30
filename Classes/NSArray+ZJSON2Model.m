//
//  NSArray+ZJSON2Model.m
//  ZJSON2Model
//
//  Created by ZERO. on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import "NSArray+ZJSON2Model.h"
#import "NSObject+ZJSON2Model.h"

@implementation NSArray (ZJSON2Model)

+ (id)arrayWithJSONArray:(id)JSONArray class:(Class)aClass
{
    NSMutableArray *objectArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (id JSONObject in JSONArray) {
        id object = [aClass objectWithJSONObject:JSONObject];
        [objectArray addObject:object];
    }
    return [objectArray copy];
}

@end
