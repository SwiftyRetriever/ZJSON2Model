//
//  ZJSON2Model.swift
//  ZJSON2Model
//
//  Created by ZhangZZZZ on 16/1/31.
//  Copyright © 2016年 ZERO. All rights reserved.
//

import Foundation

extension NSObject {

    convenience init(JSONObject: AnyObject?){
    
        self.init()
        let mirror:Mirror! = Mirror(reflecting: self)
    
        if let collection = AnyBidirectionalCollection(mirror.children) {
            for index in collection.endIndex.advancedBy(-20, limit: collection.startIndex)..<collection.endIndex {
                let element = collection[index]
                let value = JSONObject!.objectForKey(element.label!)
                if value == nil {
                    continue
                }
                self.setValue(value, forKey: element.label!)
            }
        }
    }
}