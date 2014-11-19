//
//  ZJSON2Model.m
//
//  Copyright (c) 2014年 ZERO. All rights reserved.
//

#import "ZJSON2Model.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, ZJSONModelDataType) {
    ZJSONModelDataTypeObject    = 0,
    ZJSONModelDataTypeBOOL      = 1,
    ZJSONModelDataTypeInteger   = 2,
    ZJSONModelDataTypeFloat     = 3,
    ZJSONModelDataTypeDouble    = 4,
    ZJSONModelDataTypeLong      = 5,
    ZJSONModelDataTypeClass     = 6,
    ZJSONModelDataTypeArray     = 7
};

@implementation ZJSON2Model


+ (NSDictionary *)dictionaryWithModel:(id)model
{
    if (model == nil) {
        return nil;
    }
    
    NSAssert(model, @"model cannot be nil");
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    NSString *className = NSStringFromClass([model class]);
    id classObject = objc_getClass([className UTF8String]);
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        id propertyValue = nil;
        id valueObject = [model valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
        } else {
            propertyValue = [NSString stringWithFormat:@"%@", [model valueForKey:propertyName]];
        }
        
        [dictionary setObject:propertyValue forKey:propertyName];
    }
    return [dictionary copy];
}

+ (NSArray *)propertiesInModel:(id)model
{
    
    NSAssert(model, @"model cannot be nil");
    
    NSMutableArray *propertiesArray = [[NSMutableArray alloc] init];
    NSString *className = NSStringFromClass([model class]);
    id classObject = objc_getClass([className UTF8String]);
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        [propertiesArray addObject:propertyName];
    }
    
    return [propertiesArray copy];
}

+ (id) modelWithJSONObject:(NSDictionary *)dictionary withClassName:(NSString *) className
{
    
    NSAssert(dictionary, @"JSONObject cannot be nil");
    NSAssert(className,  @"className cannot be nil");
    NSAssert(className.length > 0, @"className cannot be empty");
    
    id model = [[NSClassFromString(className) alloc] init];
    
    id classObject = objc_getClass([className UTF8String]);
    
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    Ivar *ivars = class_copyIvarList(classObject, nil);
    
    for (int i = 0; i < count; i ++) {
        
        NSString *memberName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        const char *type = ivar_getTypeEncoding(ivars[i]);
        NSString *dataType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        ZJSONModelDataType rtype = ZJSONModelDataTypeObject;
        if ([dataType hasPrefix:@"b"] || [dataType hasPrefix:@"B"] || [dataType hasPrefix:@"c"]) {
            rtype = ZJSONModelDataTypeBOOL;// BOOL
        } else if ([dataType hasPrefix:@"i"]) {
            rtype = ZJSONModelDataTypeInteger;// int
        } else if ([dataType hasPrefix:@"f"]) {
            rtype = ZJSONModelDataTypeFloat;// float
        } else if ([dataType hasPrefix:@"d"]) {
            rtype = ZJSONModelDataTypeDouble; // double
        } else if ([dataType hasPrefix:@"q"])  {
            rtype = ZJSONModelDataTypeLong;// long
        } else if ([dataType hasSuffix:@"Model\""]) {
            rtype = ZJSONModelDataTypeClass;
        } else if ([dataType isEqualToString:@"NSArray"]){
            rtype = ZJSONModelDataTypeArray;
        }
        
        for (int j = 0; j < count; j++) {
            objc_property_t property = properties[j];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSRange range = [memberName rangeOfString:propertyName];
            if (range.location == NSNotFound) {
                continue;
            } else {
                if (dictionary && [dictionary isKindOfClass:[NSNull class]]) {
                    continue;
                }
                id propertyValue = [dictionary objectForKey:propertyName];
                    switch (rtype) {
                        case ZJSONModelDataTypeBOOL: {
                            BOOL temp = [[NSString stringWithFormat:@"%@", propertyValue] boolValue];
                            propertyValue = [NSNumber numberWithBool:temp];
                        }
                            break;
                        case ZJSONModelDataTypeInteger: {
                            int temp = [[NSString stringWithFormat:@"%@", propertyValue] intValue];
                            propertyValue = [NSNumber numberWithInt:temp];
                        }
                            break;
                        case ZJSONModelDataTypeFloat: {
                            float temp = [[NSString stringWithFormat:@"%@", propertyValue] floatValue];
                            propertyValue = [NSNumber numberWithFloat:temp];
                        }
                            break;
                        case ZJSONModelDataTypeDouble: {
                            double temp = [[NSString stringWithFormat:@"%@", propertyValue] doubleValue];
                            propertyValue = [NSNumber numberWithDouble:temp];
                        }
                            break;
                        case ZJSONModelDataTypeLong: {
                            long long temp = [[NSString stringWithFormat:@"%@",propertyValue] longLongValue];
                            propertyValue = [NSNumber numberWithLongLong:temp];
                        }
                            break;

                        case ZJSONModelDataTypeClass: {
                            NSString *type = [dataType substringWithRange:NSMakeRange(2, dataType.length -3)];
                            propertyValue = [ZJSON2Model modelWithJSONObject:propertyValue withClassName:type];
                        } break;
                            
                        default:
                            break;
                    }
                
                [model setValue:propertyValue forKey:memberName];
            }
            break;
        }
    }
    
    return model;
}


@end
