//
//  AddTextViewController.swift
//  CaptionMySocialPic
//
//  Created by VIJAY VENKATESH on 7/7/15.
//  Copyright (c) 2015 VIJAY VENKATESH. All rights reserved.
//

import UIKit
import Accounts

class AddTextViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var profileImage: UIImage? = nil
    var twitterAccount : ACAccount? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let publishPicViewController = segue.destinationViewController as! PublishPicViewController
        publishPicViewController.profileImage = self.profileImage
        publishPicViewController.imageText = self.textField.text
        publishPicViewController.twitterAccount = self.twitterAccount
        
    }

}
