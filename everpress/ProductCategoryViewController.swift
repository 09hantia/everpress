//
//  ProductCategoryViewController.swift
//  everpress
//
//  Created by Sam Li on 2014-11-28.
//  Copyright (c) 2014 Tianfei Han. All rights reserved.
//

import UIKit

protocol ProductCategoryViewControllerDelegate {
    func productCategoryDidPick(controller: ProductCategoryViewController, text:String)
}

class ProductCategoryViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegate:ProductCategoryViewControllerDelegate? = nil
    var productText = ""
    @IBOutlet weak var productCategoryPicker: UIPickerView!
    @IBOutlet weak var productCategory: UILabel!
    let pickerData = ["鲜花","玫瑰花","翔","你猜","妹子"]
    override func viewDidLoad() {
        super.viewDidLoad()
        productCategoryPicker.dataSource = self
        productCategoryPicker.delegate = self
        productCategory.text = productText
    }
    @IBAction func saveCategory(sender: UIBarButtonItem) {
        println("test1")
        if (delegate != nil) {
            println("test")
            delegate!.productCategoryDidPick(self, text: productCategory!.text!)
        }
    }
    @IBAction func saveProductCategory(sender: UIButton) {
        if (delegate != nil) {
            delegate!.productCategoryDidPick(self, text: productCategory!.text!)
        }
    }
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        productCategory.text = pickerData[row]
    }
}
