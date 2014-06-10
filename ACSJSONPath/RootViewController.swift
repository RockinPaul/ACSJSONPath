//
//  RootViewController.swift
//  ACSJSONPath
//
//  Created by Albert Chu on 14-6-5.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIAlertViewDelegate {
    
    //
    var myButton: UIButton?
    var alert: UIAlertView?
    
    
//-- Action Methods --------------------------------------------------------------------------------
    
    func buttonClick(sender: UIButton!) {
        gettingOLJSONData()
    }
    
    // alert item
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        println("buttonIndex: \(buttonIndex) clicked")
    }
    
//------------------------------------------------------------------------------------------------//

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "RootVC";
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        gettingLocalJSONData()
        
        setUpView()
    }
    
    
    func setUpView() {
        
        //-- button --------------------------------------------------------------------------------
        self.myButton = UIButton(frame:CGRect(origin: CGPointMake(60.0, 200.0), size: CGSizeMake(200,50)))
        self.myButton!.setTitle("button", forState: UIControlState.Normal)
        
        var buttonBGColor : UIColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1)
        var borderColor : UIColor = UIColor(red: 0, green: 0.3, blue: 0.6, alpha: 1)
        
        self.myButton!.backgroundColor = buttonBGColor
        self.myButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        var highLightColor : UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.6, alpha: 1)
        self.myButton!.setTitleColor(highLightColor, forState: UIControlState.Highlighted)
        
        // border
        self.myButton!.layer.cornerRadius = 8
        self.myButton!.layer.borderWidth = 1
        self.myButton!.layer.borderColor = borderColor.CGColor
        
        
        self.myButton!.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.myButton)
        //----------------------------------------------------------------------------------------//
        
        //-- alert ---------------------------------------------------------------------------------
        // this crashes
        //self.alert = UIAlertView(title: "alert", message: "this is an alert", delegate: self, cancelButtonTitle: "cancel")
        
        self.alert = UIAlertView()
        
        
        self.alert!.delegate = self
        self.alert!.addButtonWithTitle("cancel")
        
        //self.alert!.title = "alert"
        //self.alert!.message = "this is an alert"
        //----------------------------------------------------------------------------------------//

    }
    
    
//-- local JSON file data --------------------------------------------------------------------------
    
    func gettingLocalJSONData() {
        
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
                println("data from local JSON path is: \(jsonData)")
                
            },
            
            failure: {(failureString: String) in
                println(failureString)
            }
        )
        
    }
    
//------------------------------------------------------------------------------------------------//
    
    
//-- JSON data OL ----------------------------------------------------------------------------------
    func gettingOLJSONData() {
                
        var theURL: NSURL = NSURL(string: "http://www.battlenet.com.cn/api/wow/battlePet/species/258")
        
        var request: NSMutableURLRequest = NSMutableURLRequest(
            URL: theURL,
            cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy,
            timeoutInterval: 10)
        
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(
            
            request,
            
            queue:NSOperationQueue.mainQueue(),
            
            completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if !error {
                    // 请求成功，处理返回结果
                    var responseString: NSString = NSString(data: data, encoding:NSUTF8StringEncoding)
                    
                    var data: NSData = responseString.dataUsingEncoding(NSUTF8StringEncoding)
                    
                    var json: AnyObject! =
                    NSJSONSerialization.JSONObjectWithData(
                        data,
                        options:NSJSONReadingOptions.AllowFragments,
                        error:nil)
                    
                    var dict = json as NSDictionary
                    var jsonPath = ACSJSONPath.sharedInstance
                    
                    var name: AnyObject? = jsonPath.getDataFromJSONObject(dict, by: "name")
                    var abilitie01: AnyObject? = jsonPath.getDataFromJSONObject(dict, by: "abilities[0].name")
                    
                    //println(dict)
                    
                    self.alert!.title = "对战宠物名称: \(name as String)"
                    self.alert!.message = "技能1: \(abilitie01 as String)"
                    self.alert!.show()
                }
                
            }
            
        )

    }
    
//------------------------------------------------------------------------------------------------//

}
