//
//  JSONObject.m
//  ZJSON2Model
//
//  Created by ZhangZZZZ on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import "JSONObject.h"
#import "NSObject+ZJSONMapper.h"

@implementation JSONObject

/**
 *  从JSONObject Key 映射到 Object propertyName
 *
 *  @return @{ObjectKey : JSONKey}
 */

+ (id)JSONMapper
{
    return @{@"ID": @"id"};
}

@end
