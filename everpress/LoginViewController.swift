//
//  LoginViewController.swift
//  everpress
//
//  Created by Tianfei Han on 14-11-20.
//  Copyright (c) 2014年 Tianfei Han. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as NSObject == self.doneButton{
            NSUserDefaults.standardUserDefaults().setObject(userName.text, forKey: "username")
            NSUserDefaults.standardUserDefaults().setObject(passWord.text, forKey: "password")
        }
    }
    

}
