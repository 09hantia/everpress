//
//  EverpressViewController.swift
//  everpress
//
//  Created by Tianfei Han on 14-12-9.
//  Copyright (c) 2014年 Tianfei Han. All rights reserved.
//

import UIKit

class EverpressViewController: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var clientId: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var lastModifiedBy: UILabel!
    @IBOutlet weak var lastModifiedDate: UILabel!
    
    @IBOutlet weak var input: UILabel!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var updateTextBox: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //getCurrentInfo()
        //getCurrentInfo()
        application();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func refresh() {
        getCurrentInfo()
        
    }
    
    
    func getCurrentInfo() -> Void {
        
        var baseURL:NSURL! = NSURL(string: "http://www.circlecanada.com:8180/MyWishWeb/service/user/1")
        var request:NSURLRequest = NSURLRequest(URL: baseURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var json:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            //println(json)
            
            let infoObject = Information(info: json)
            //println(infoObject.clientId)
            self.clientId.text = "\(infoObject.clientId)"
            self.firstName.text = infoObject.firstName
            self.lastName.text = infoObject.lastName
            self.phoneNumber.text = infoObject.phoneNumber
            self.email.text = infoObject.email
            self.lastModifiedBy.text = infoObject.lastModifiedBy
            self.lastModifiedDate.text = "\(infoObject.lastModifiedDate)"
            
            
            
            
        })
        
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func update(sender: AnyObject){
        
        var s = self.updateTextBox.text
        
    }
    
    
    
    func application() -> Bool {
        
        // Correct url and username/password
        var createUserDic: Dictionary<String, AnyObject> =
        ["whatDesc":"fuck my life",
            "whereDesc":"My Home",
            "whoDesc":"Jason", "wishLocLongitude":"200.02",
            "userId":"2",
            "wishLocLatitude":"100.01", "lastModifiedBy":"myself", "whenDesc":"12/30/2014", "wishTypeCode":"1"]
        var loginDic:Dictionary<String, AnyObject> = ["email":"jian.wang@everpress.ca", "password":"Osap2012"]
        self.post(createUserDic, url: "http://everpress.ca:8182/MyWishWeb/springservice/createWish") { (succeeded: Bool, msg: String) -> () in
            var alert = UIAlertView(title: "Success!", message: msg, delegate: nil, cancelButtonTitle: "Okay.")
            if(succeeded) {
                alert.title = "Success!"
                alert.message = msg
            }
            else {
                //alert.title = "Failed : ("
                //alert.message = msg
            }
            
            // Move to the UI thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // Show the alert
                alert.show()
            })
        }
        
        return true
    }
    
    func post(params : Dictionary<String, AnyObject>, url : String, postCompleted : (succeeded: Bool, msg: String) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        
        // frist approach
        request.HTTPMethod = "POST"
        //println("params:\(params)")
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        var jsonObject = NSJSONSerialization.JSONObjectWithData(request.HTTPBody!, options: .MutableLeaves, error: &err) as NSDictionary


        
        
        // new part from stackoverflow
        //let jsonObject: [AnyObject] = [["email":"jian.wang@everpress.ca", "password":"Osap2012"]]
        //let jsonString =  JSONStringify(jsonObject)
        //println(jsonString)
        //let jsonString = "{ \"email\":[\"jian.wang@everpress.ca\"],\"password\":[\"Osap2012\"] }"
        // NSASCIIStringEncoding NSUTF8StringEncoding 
        //request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)

        //request.HTTPMethod = "POST"
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        //println()
        //println(request.HTTPBody)
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            //println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            //println("json object is:\(json)")
            var msg = "No message"
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                //println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                //println("Error could not parse JSON: '\(jsonStr)'")
                postCompleted(succeeded: false, msg: "Error")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let success = parseJSON["success"] as? Bool {
                        //println("Succes: \(success)")
                        postCompleted(succeeded: success, msg: "Logged in.")
                    }
                    return
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    //println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, msg: "Error")
                }
            }
        })
        
        task.resume()
    }
    
    
    func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string
                }
            }
        }
        return ""
    }
    
    
    
    
}
