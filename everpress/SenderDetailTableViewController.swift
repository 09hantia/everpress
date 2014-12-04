//
//  SenderDetailTableViewController.swift
//  everpress
//
//  Created by Sam Li on 2014-11-28.
//  Copyright (c) 2014 Tianfei Han. All rights reserved.
//

import UIKit

class SenderDetailTableViewController: UITableViewController, ProductCategoryViewControllerDelegate {

    @IBOutlet weak var productCategoryText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func productCategoryDidPick(controller: ProductCategoryViewController, text: String) {
        productCategoryText.text = text
        controller.navigationController?.popViewControllerAnimated(true)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "getProductCategory" {
            let vc = segue.destinationViewController as ProductCategoryViewController
            vc.productText = productCategoryText.text!
            vc.delegate = self
        }
    }
    

}
