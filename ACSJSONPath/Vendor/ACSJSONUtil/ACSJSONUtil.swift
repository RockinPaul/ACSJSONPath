//
//  ACSJSONUtil.swift
//  ACSJSONPath
//
//  Created by Albert Chu on 14-6-5.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

import Foundation

class ACSJSONUtil {
    
    // 路径常量
    let mainBundleDirectory: String = NSBundle.mainBundle().bundlePath
    let jsonDirectory: String = "/"  // 蓝色文件夹时候有具体路径
    
    
    /**
    *  Singleton
    *  via: http://stackoverflow.com/questions/24024549/dispatch-once-singleton-model-in-swift
    */
    class var sharedInstance: ACSJSONUtil {
        get {
            struct Static {
                static var instance: ACSJSONUtil? = nil
                static var token: dispatch_once_t = 0
            }
            dispatch_once(&Static.token) {
                Static.instance = ACSJSONUtil()
            }
            return Static.instance!
        }
    }
    
    /**
    *  读取本地 JSON 文件
    */
    func parsingJSONDataByFile(
        name: String,
        success: (responseObj: AnyObject) -> (),
        failure: (failureString: String) -> ()
        )
    {
        var fullPath: String = mainBundleDirectory + jsonDirectory + name
        var jsonData: NSData? = NSData(contentsOfFile: fullPath)
            
        //println(fullPath)
        
        var jsonObject: AnyObject?
        var error: NSError?
        
        if jsonData {
            
            jsonObject = NSJSONSerialization.JSONObjectWithData(
                jsonData,
                options: NSJSONReadingOptions.AllowFragments,
                error: &error)
            
            if (jsonObject && !error) {
                success(responseObj: jsonObject!)
            } else {
                failure(failureString: "parsing error")
            }
            
        } else {
            failure(failureString: "file not exsit")
        }
        
    }
    
}


