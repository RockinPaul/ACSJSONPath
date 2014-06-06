//
//  RootViewController.swift
//  ACSJSONPath
//
//  Created by Albert Chu on 14-6-5.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
//-- Action Methods --------------------------------------------------------------------------------
    
//------------------------------------------------------------------------------------------------//

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "RootVC";
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        gettingJSONData()
        
    }
    
    
    
//-- test Methods ----------------------------------------------------------------------------------
    
    func gettingJSONData() {
        
        var jsonUtil = ACSJSONUtil.sharedInstance
        
        jsonUtil.parsingJSONDataByFile(
            
            "test.json",
            
            success: {(responseObj: AnyObject) in
                
                //println(responseObj)
                
                var responseJSON: NSDictionary = responseObj as NSDictionary
                
                //var testStr : String! = (responseJSON["template"] as NSDictionary)["type"] as String
                //println(testStr)
                
                var jsonPath = ACSJSONPath.sharedInstance
                var jsonData : AnyObject? = jsonPath.getDataFromJSONObject(responseJSON, by: "template.test[1][0].one[0][0].te")
                println(jsonData)
                
            },
            
            failure: {(failureString: String) in
                println(failureString)
            }
        )
        
    }
    
//--------------------------------------------------------------------------------------------------

}
