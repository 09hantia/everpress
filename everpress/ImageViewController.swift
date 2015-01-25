//
//  ImageViewController.swift
//  everpress
//
//  Created by Tianfei Han on 14/12/29.
//  Copyright (c) 2014年 Tianfei Han. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,  UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addImage: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.editing = false
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Action Sheet", message: "Simple actionSheet", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
        let libButton = UIAlertAction(title: "Select from photo library", style: UIAlertActionStyle.Default){(libSelect) -> Void in
            println("library selected")
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)

        }
        actionSheet.addAction(libButton)
        let cameraButton = UIAlertAction(title: "Take Picture", style: UIAlertActionStyle.Default) { (camSelected) -> Void in
            println("camera selected")
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)

            }
            else{
                println("Camera not available")
            }
            
        }
        actionSheet.addAction(cameraButton)
        let cancellButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (cancelSelected) -> Void in
            println("cancel selected")

        }
        actionSheet.addAction(cancellButton)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.imageView.image = image
    }

}
