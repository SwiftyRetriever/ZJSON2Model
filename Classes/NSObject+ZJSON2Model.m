//
//  NSObject+ZJSON2Model.m
//  ZJSON2Model
//
//  Created by ZERO. on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import "NSObject+ZJSON2Model.h"
#import "NSObject+ZJSONMapper.h"

#import <objc/runtime.h>

// support type @see https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100
#define SUPPORT_TYPE    [NSArray arrayWithObjects:@"i", @"I", @"s", @"S", @"l", @"L", @"q", @"Q", @"f", @"d", @"B", @"b", @"c", @"C", @"@", nil]

@implementation NSObject (ZJSON2Model)

- (id)toJSONObject
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    NSString *className = NSStringFromClass([self class]);
    id classObject = objc_getClass([className UTF8String]);
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        id propertyValue = nil;
        id valueObject = [self valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
        } else {
            propertyValue = [NSString stringWithFormat:@"%@", [self valueForKey:propertyName]];
        }
        
        [dictionary setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    
    return [dictionary copy];
}

- (id)toJSONString
{
    return [self toJSONObject];
}

+ (NSArray *)properties
{
    NSMutableArray *propertiesArray = [[NSMutableArray alloc] init];
    NSString *className = NSStringFromClass([self class]);
    id classObject = objc_getClass([className UTF8String]);
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        [propertiesArray addObject:propertyName];
    }
    
    free(properties);
    
    return [propertiesArray copy];
}

+ (id)objectWithJSONData:(id)JSONData
{
    NSError *err = nil;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData
                                                    options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                      error:&err];
    return [self objectWithJSONObject:JSONObject];
}

+ (id)objectWithJSONString:(id)JSONString
{
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self objectWithJSONData:JSONData];
}

+ (id)objectWithJSONObject:(id)JSONObject
{
    if (JSONObject == nil || [JSONObject isEqual:[NSNull null]]) {
        return nil;
    }
    
    Class aClass = [self class];
    id model = [[aClass alloc] init];
    
    id classObject = objc_getClass([NSStringFromClass(aClass) UTF8String]);

    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    Ivar *ivars = class_copyIvarList(classObject, nil);
    
    id mapper = [self JSONMapper];
    
    NSArray *mapKeys = [mapper allKeys];
    
    for (int i = 0; i < count; i ++) {
        
        NSString *memberName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        
        const char *type = ivar_getTypeEncoding(ivars[i]);
        NSString *dataType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];

        id propertyValue;
        if (mapper && [mapKeys containsObject:propertyName]) {
            id key = [mapper objectForKey:propertyName];
            propertyValue = [JSONObject objectForKey:key];
        } else {
            propertyValue = [JSONObject objectForKey:propertyName];
        }

        if (!propertyValue || [propertyValue isEqual:[NSNull null]]) {
            continue;
        }
        
        NSString *rType = [dataType substringToIndex:1];
        
        if (![SUPPORT_TYPE containsObject:rType]) {
            continue;
        }

        if ([rType isEqualToString:@"i"]) {
            propertyValue = [NSNumber numberWithInt:[propertyValue intValue]];
        } else if ([rType isEqualToString:@"I"]) {
            propertyValue = [NSNumber numberWithUnsignedInt:[propertyValue unsignedIntValue]];
        } else if ([rType isEqualToString:@"s"]) {
            propertyValue = [NSNumber numberWithShort:[propertyValue shortValue]];
        } else if ([rType isEqualToString:@"S"]) {
            propertyValue = [NSNumber numberWithUnsignedShort:[propertyValue unsignedIntValue]];
        } else if ([rType isEqualToString:@"l"]) {
            propertyValue = [NSNumber numberWithLong:[propertyValue longValue]];
        } else if ([rType isEqualToString:@"L"]) {
            propertyValue = [NSNumber numberWithUnsignedLong:[propertyValue unsignedLongValue]];
        } else if ([rType isEqualToString:@"q"]) {
            propertyValue = [NSNumber numberWithLongLong:[propertyValue longLongValue]];
        } else if ([rType isEqualToString:@"Q"]) {
            propertyValue = [NSNumber numberWithUnsignedLongLong:[propertyValue unsignedLongLongValue]];
        } else if ([rType isEqualToString:@"f"]) {
            propertyValue = [NSNumber numberWithFloat:[propertyValue floatValue]];
        } else if ([rType isEqualToString:@"d"]) {
            propertyValue = [NSNumber numberWithDouble:[propertyValue doubleValue]];
        } else if ([rType isEqualToString:@"B"]) {
            propertyValue = [NSNumber numberWithBool:[propertyValue boolValue]];
        } else if ([rType isEqualToString:@"c"]) {
            propertyValue = [NSNumber numberWithChar:[propertyValue charValue]];
        } else if ([rType isEqualToString:@"C"]) {
            propertyValue = [NSNumber numberWithUnsignedChar:[propertyValue unsignedCharValue]];
        }

        [model setValue:propertyValue forKey:memberName];
    }
    
    free(properties);
    
    return model;
}

@end