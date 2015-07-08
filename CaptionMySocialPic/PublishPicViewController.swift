//
//  PublishPicViewController.swift
//  CaptionMySocialPic
//
//  Created by VIJAY VENKATESH on 7/7/15.
//  Copyright (c) 2015 VIJAY VENKATESH. All rights reserved.
//

import UIKit
import Accounts
import Social


class PublishPicViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    var profileImage: UIImage? = nil
    var imageText = ""
    var twitterAccount : ACAccount? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hey man

        //Getting image and text from AddTextViewController 
        self.profilePicImageView.image = editCaptionOnPic(self.imageText, image: self.profileImage!)
    }

    func editCaptionOnPic (text: String, image: UIImage) -> UIImage{
        UIGraphicsBeginImageContext(image.size)
        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        
        UIColor(white: 0, alpha: 0.4).set()
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, image.size.height-(image.size.height * 0.2), image.size.width, image.size.height * 0.2))
        
        var rect = CGRectMake(0, image.size.height-(image.size.height * 0.2), image.size.width, image.size.height * 0.2)
        let newText : NSString = text
        var style = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        style.alignment = NSTextAlignment.Center
        var attrs = [NSFontAttributeName: UIFont.systemFontOfSize(image.size.height * 0.17), NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSParagraphStyleAttributeName: style]
        newText.drawInRect(CGRectIntegral(rect), withAttributes: attrs)
        
        
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newimage
        
    }

    @IBAction func updateTapped(sender: AnyObject) {
        let requestAPI = NSURL(string: "https://api.twitter.com/1.1/account/update_profile_image.json")
        
        //Turning an image into a base64 image per the twitter api requirement
        let picData = UIImagePNGRepresentation(self.profilePicImageView.image)
        let base64image = picData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let userRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.POST, URL: requestAPI, parameters: ["image" : base64image])
        
        userRequest.account = self.twitterAccount
        
        userRequest.performRequestWithHandler({ (response: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) -> Void in
            
            var error = NSErrorPointer()
            
            let responseDictionary = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableLeaves, error: error) as! [String: AnyObject]
            
            if urlResponse.statusCode == 200 {
                //Post worked
                var alertController = UIAlertController(title: "Pic update", message: "Caption: Picture updated", preferredStyle: UIAlertControllerStyle.Alert)
                var alertAction = UIAlertAction(title: "Excellent", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(alertAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                //Post did not work
                var alertController = UIAlertController(title: "Fail Whale", message: "Caption: Unable to update picture", preferredStyle: UIAlertControllerStyle.Alert)
                var alertAction = UIAlertAction(title: "Sorry 😔", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(alertAction)
                self.presentViewController(alertController, animated: true, completion: nil)

            }
        })

    }
}
