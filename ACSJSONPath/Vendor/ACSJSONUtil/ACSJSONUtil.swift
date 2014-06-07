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
        
        if let data = jsonData {
            
            var error: NSError?
            
            let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(
                data,
                options: NSJSONReadingOptions.AllowFragments,
                error: &error)
            
            if let json : AnyObject = jsonObject {
                success(responseObj: json)
            } else {
                let parsingError: NSError = error!
                //println ("error_info: \(parsingError)")
                failure(failureString: "parsing error")
            }
            
            /*
            if let parsingError = error {
                println ("error_info: \(parsingError)")
                failure(failureString: "parsing error")
            } else {
                let json: AnyObject = jsonObject!
                success(responseObj: json)
            }
            **/
            
        } else {
            failure(failureString: "file not exsit")
        }
        
    }
    
}


