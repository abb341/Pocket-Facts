//
//  LearnMoreViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/14/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit

class LearnMoreViewController: UIViewController {
    //Outlets
    @IBOutlet weak var factDetails: UILabel!
    @IBOutlet weak var sourceName: UIButton!
    
    //Variables
    var factDetailsText = String()
    var sourceUrl = String()
    var source = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        factDetails.text = factDetailsText
        sourceName.setTitle(source, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showWebView" {
            var destVC = segue.destinationViewController as! WebViewController
            destVC.requestURL = sourceUrl
        }
    }
    

}
