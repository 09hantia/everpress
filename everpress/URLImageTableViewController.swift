//
//  URLImageTableViewController.swift
//  everpress
//
//  Created by Tianfei Han on 15/1/8.
//  Copyright (c) 2015年 Tianfei Han. All rights reserved.
//

import UIKit

class URLImageTableViewController: UITableViewController {

    var wishImageInfoArray = NSArray()
    var uiImageArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        getWishInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func getWishInfo(){
        
        var baseURL:NSURL! = NSURL(string: "http://www.everpress.ca:8180/MyWishWeb/springservice/retrieveWishInfo")
        var request:NSURLRequest = NSURLRequest(URL: baseURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            self.wishImageInfoArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
            println(self.wishImageInfoArray)
            
            //let infoObject = WishImageInfo(info: wishImageInfoDic)
            //println(infoObject.wishId)
            
            for wishImageInfoDic in self.wishImageInfoArray {
                var wishImageObj = WishImageInfo(info: wishImageInfoDic as NSDictionary)
                var url : String = "http://www.everpress.ca:8180/MyWishWeb/image/wish_pic/" + String(wishImageObj.wishPicId) + "." + wishImageObj.picType
                var imageURL = NSURL(string: url)
                println(url)
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    var test =  UIImage(data: NSData(contentsOfURL: NSURL(string:url)!)!)
                    self.uiImageArray.addObject(test!)
                    println(test)
                })
            
            
            }
            
            
            
        })
        
        
        
        
    }
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
*/
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return wishImageInfoArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        println("cell:\(cell)")
        cell.imageView?.image = self.uiImageArray[indexPath.row] as? UIImage
        println("cell:\(cell)")
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
