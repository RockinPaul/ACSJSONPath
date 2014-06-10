//
//  ACSJSONPath.swift
//  ACSJSONPath
//
//  Created by Albert Chu on 14-6-5.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

import Foundation

class ACSJSONPath {
    
    /**
    *  Singleton
    *  via: http://stackoverflow.com/questions/24024549/dispatch-once-singleton-model-in-swift
    */
    class var sharedInstance:ACSJSONPath {
        get {
            struct Static {
                static var instance: ACSJSONPath? = nil
                static var token: dispatch_once_t = 0
            }
            dispatch_once(&Static.token) {
                Static.instance = ACSJSONPath()
            }
            return Static.instance!
        }
    }
    
    /**
    *  从路径获取 JSON 中的数据
    */
    func getDataFromJSONObject(dict: NSDictionary?, by path: String?) -> (data: AnyObject?) {
        
        if dict && path {
            
            // 不断被新对象替换的中间容器
            var container: AnyObject = dict!
            
            // 所有的 key，但连接着后面的数组下标（如果有的话）
            let keys: Array = path!.componentsSeparatedByString(".")
            //println(keys)
            
            for key: String in keys {
                // 是否有数组
                if key.hasSuffix("]") {
                    // 分离下标
                    let keyAndIndex: Array = key.componentsSeparatedByString("[")
                    
                    // 顶层数组对象的 key
                    let keyForTopArray: String = keyAndIndex[0]
                    
                    // 顶层数组对象 (由于 NSDictionary 中的 数组 不同于 Swift 的 Array ，所以取为 NSArray)
                    var arrayObj: NSArray = container[keyForTopArray] as NSArray
                    
                    // 处理多级数组
                    /** 数组层数 (从1开始) */
                    for (var i: Int = 1; i < keyAndIndex.count; i++) {
                        let indexStrDirty: String = keyAndIndex[i]
                        let indexStr: String =
                        indexStrDirty.substringWithRange(
                            Range<String.Index>(start: indexStrDirty.startIndex, end: (indexStrDirty.endIndex.pred()))
                            
                            // substring 待详细考证
                            // http://stackoverflow.com/questions/24044851/how-do-you-use-string-substringwithrange-or-how-do-ranges-work-in-swift
                        )
                        //println(indexStr)
                        
                        let indexForNewContainer: Int = indexStr.toInt()!
                        
                        var element: AnyObject
                        
                        // 判断数组下标是否越界
                        if (indexForNewContainer >= 0 && indexForNewContainer < arrayObj.count) {
                            element = arrayObj[indexForNewContainer];
                        } else {
                            return nil
                        }
                        
                        // 判断是否最后一层，是则赋给中间容器
                        if ( i == (keyAndIndex.count - 1) ) {
                            container = element;
                        } else {
                            // 如果不是最后一层，则判断该元素如果是数组对象才可以进入下一次循环继续循环取下标元素
                            if (element is NSArray) {
                                // 替换为新数组
                                arrayObj = element as NSArray;
                            } else {
                                return nil
                            }
                        }
                        
                    }
                
                } else {
                    // 只有 key, 不需要从数组下标取元素的分支
                    container = (container as NSDictionary)[key];
                }
            }
            
            return container;
            
        } else {
           return nil
        }
        
    }
   
}
