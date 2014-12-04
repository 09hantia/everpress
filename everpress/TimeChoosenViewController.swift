//
//  TimeChoosenViewController.swift
//  everpress
//
//  Created by Tianfei Han on 14-11-26.
//  Copyright (c) 2014年 Tianfei Han. All rights reserved.
//

import UIKit

class TimeChoosenViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    let test = "aaa"
    @IBAction func doneButton(sender: AnyObject) {
        
        
        let now = NSDate()
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        let components = gregorian?.components(NSCalendarUnit.MinuteCalendarUnit, fromDate: now, toDate: datePicker.date, options: NSCalendarOptions(0))

        let time = components?.minute
        
        println(time)
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    */
    

}
