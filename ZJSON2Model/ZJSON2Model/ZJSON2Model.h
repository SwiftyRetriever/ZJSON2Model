//
//  ZJSON2Model.h
//
//  Copyright (c) 2014年 ZERO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJSON2Model : NSObject

+ (NSDictionary *)dictionaryWithModel:(id)model;

+ (NSArray *)propertiesInModel:(id)model;

+ (id) modelWithJSONObject:(NSDictionary *)dictionary withClassName:(NSString *) className;

@end
