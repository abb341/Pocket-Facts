//
//  FactOfTheDayViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/11/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

class FactOfTheDayViewController: UIViewController {
    //Outlets
    @IBOutlet var todayView: UIView!
    @IBOutlet weak var factOfTheDay: UILabel!
    @IBOutlet weak var todayLabel: UINavigationItem!
    
    //Actions
    @IBAction func presentNavigation(sender: AnyObject?){
        performSegueWithIdentifier("presentMenu", sender: self)
    }
    @IBAction func learnMoreButtonPressed(sender: AnyObject){
        performSegueWithIdentifier("learnMore", sender: self)
    }
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let textToShare = "\"" + factOfTheDay.text! + "\""
        
        if let myWebsite = NSURL(string: "https://www.facebook.com/pages/Pocket-Facts/859528520769026")
        {
            let objectsToShare = [textToShare, "\r\n", myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Share Button Pressed")
    }
    
    //Properties
    var fact: [Fact] = []
    var detailOfFact: String = " "
    var factSourceName: String = "No Source"
    var factSourceUrl: String = "https://www.google.com"
    var total: [Total] = []
    var numberOfFacts: Int = 20
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    var factNumber: Int = 1

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        showActivityIndicator(todayView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        hideActivityIndicator()
        todayLabel.title = DateHelper.getDateAsString()
        
        println("Started Query")
        var query = PFQuery(className: "Total")
        total = query.findObjects() as? [Total] ?? []
        println("Ended Query")
        numberOfFacts = total[0].numberOfFacts
        
        factNumber = DateHelper.getTodaysFactNumber(numberOfFacts)

        
            //display fact through Parse
            println("Accessing Parse")
            displayFactOfTheDay(factNumber)
        
            
            //If nothing is on parse
            if (factOfTheDay.text == "")
            {
                factOfTheDay.text = ErrorHandler.defaultLabelText
            }
        }
    
    // MARK: Fact Of The Day Parse
    func displayFactOfTheDay(factNumber: Int) -> Void {
        
        //Query Parse
        let query = PFQuery(className: "Fact")
        query.whereKey("factNumber", equalTo: factNumber)
        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.fact = result as? [Fact] ?? []
            
            //Loop through fact array
            for fact in self.fact {
                //Retrieve info of each PFObject
                self.factOfTheDay.text = fact.contentOfFact
                self.detailOfFact = fact.detailOfFact
                self.factSourceName = fact.sourceName
                self.factSourceUrl = fact.sourceUrl
                self.factNumber = fact.factNumber
            }
            
            
        }
        
    }
    
    //MARK: Activity Indicator
    
    func showActivityIndicator(uiView: UIView) {
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        uiView.addSubview(actInd)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator() {
        actInd.stopAnimating()
        actInd.removeFromSuperview()
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "learnMore" {
            var destViewController = segue.destinationViewController as! LearnMoreViewController
            destViewController.factDetailsText = detailOfFact
            destViewController.source = factSourceName
            destViewController.sourceUrl = factSourceUrl
        }
    }
    
}
