//
//  RecentFactsTableViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/13/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

class RecentFactsTableViewController: UIViewController {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var fact: [Fact] = []
    var detailOfFact: String = "There was an error retrieving more info"
    //var forDate: Int = 0
    var contentOfFact: String = ""
    var sourceName: String = ""
    var sourceUrl: String = ""
    var recentFactsFromParse = [Fact?](count:7, repeatedValue: nil)
    //var recentFactsFromRealm: [RecentFact] = []
    //var fetchFromParse: Bool = true
    var numberOfFacts: Int = 20
    var total: [Total] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Recent Facts")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        var query = PFQuery(className: "Total")
        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.total = result as? [Total] ?? []
        //total = query.findObjects() as? [Total] ?? []
        self.numberOfFacts = self.total[0].numberOfFacts
        
            var recentFactNumbers = DateHelper.recentFactNumbers(self.numberOfFacts)
        
            self.displayRecentFactsFromParse(recentFactNumbers)
        }
        tableView.reloadData()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayRecentFactsFromParse(recentFactNumbers: [Int]) {
        //Query Parse
        let query = PFQuery(className: "Fact")
        query.whereKey("factNumber", containedIn: recentFactNumbers)
        query.orderByDescending("factNumber")
        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.fact = result as? [Fact] ?? []
            
            //Loop through fact array
            for fact in self.fact {
                //Retrieve info of each PFObject
                
                self.contentOfFact = fact.contentOfFact
                self.detailOfFact = fact.detailOfFact
                
                
                //Loop through recentDatesAsInts
                //var i = find(self.fact, fact)!
                for var i = 0; i<recentFactNumbers.count; i++ {
                    if fact.factNumber == recentFactNumbers[i] {
                        //Add info to Parse array
                        self.recentFactsFromParse[i] = fact
                        
                        //Stop the for loop
                        i+=recentFactNumbers.count

                    }
                }
                
                
            }
            
            self.tableView.reloadData()
            //println(self.recentFacts.count)

        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showOldDetail" {
            var destViewController = segue.destinationViewController as! MoreInfoViewController
            destViewController.factDetailLabelText = detailOfFact
            destViewController.source = sourceName
            destViewController.sourceUrl = sourceUrl
            println(sourceName)
        }
    }
    

}

extension RecentFactsTableViewController: UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recentFactsFromParse.count ?? 0
        
        //return 7
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recentFactCell", forIndexPath: indexPath) as! RecentFactTableViewCell
    
        // Configure the cell...
        let row = indexPath.row
        
        /*
        if fetchFromParse {
            let recentFact = self.recentFactsFromParse[row] as Fact
            
            cell.contentOfFact.text = recentFact.contentOfFact
            cell.forDate.text = DateHelper.formatForDate(recentFact.forDate)
        }
        else {
            let recentFactFromRealm = self.recentFactsFromRealm[row] as RecentFact
            //println(recentFactFromRealm.contentOfFact)
            cell.contentOfFact.text = recentFactFromRealm.contentOfFact
            cell.forDate.text = DateHelper.formatForDate(recentFactFromRealm.forDate)
        }
        */
        
        let recentFact = self.recentFactsFromParse[row] as Fact?
        
        if let recentFact = recentFact {
            cell.contentOfFact.text = recentFact.contentOfFact
        }

        
        return cell
    }
    

}

extension RecentFactsTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Do Something
        
        /*
        if fetchFromParse {
            detailOfFact = recentFactsFromParse[indexPath.row].detailOfFact
            sourceName = recentFactsFromParse[indexPath.row].sourceName
            sourceUrl = recentFactsFromParse[indexPath.row].sourceUrl
        }
        else
        {
            detailOfFact = recentFactsFromRealm[indexPath.row].detailOfFact
            sourceName = recentFactsFromRealm[indexPath.row].sourceName
            sourceUrl = recentFactsFromRealm[indexPath.row].sourceUrl
        }
        */
        
        detailOfFact = recentFactsFromParse[indexPath.row]!.detailOfFact
        sourceName = recentFactsFromParse[indexPath.row]!.sourceName
        sourceUrl = recentFactsFromParse[indexPath.row]!.sourceUrl

        performSegueWithIdentifier("showOldDetail", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
