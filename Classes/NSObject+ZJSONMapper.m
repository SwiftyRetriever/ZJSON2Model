//
//  NSObject+ZJSONMapper.m
//  ZJSON2Model
//
//  Created by ZhangZZZZ on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import "NSObject+ZJSONMapper.h"
#import <objc/runtime.h>

@implementation NSObject (ZJSONMapper)

+ (id)JSONMapper
{
    return nil;
}

#pragma mark - Getter && Setter

- (id)JSONMapper
{
    return objc_getAssociatedObject(self, @selector(JSONMapper));
}

- (void)setJSONMapper:(id)JSONMapper
{
    objc_setAssociatedObject(self, @selector(JSONMapper), JSONMapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
