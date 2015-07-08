//
//  PublishPicViewController.swift
//  CaptionMySocialPic
//
//  Created by VIJAY VENKATESH on 7/7/15.
//  Copyright (c) 2015 VIJAY VENKATESH. All rights reserved.
//

import UIKit

class PublishPicViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    var profileImage: UIImage? = nil
    var imageText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hey man

        //Getting image and text from AddTextViewController 
        self.profilePicImageView.image = editCaptionOnPic("test", image: self.profileImage!)
    }

    func editCaptionOnPic (text: String, image: UIImage) -> UIImage{
        UIGraphicsBeginImageContext(image.size)
        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        
        UIColor.blackColor().set()
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, image.size.height-80, image.size.width, 80))
        
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newimage
        
    }

}
