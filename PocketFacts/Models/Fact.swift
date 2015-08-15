//
//  Fact.swift
//  Tips
//
//  Created by Aaron Brown on 7/11/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import Foundation
import Parse

class Fact : PFObject, PFSubclassing {
    @NSManaged var contentOfFact: String
    @NSManaged var detailOfFact: String
    @NSManaged var sourceName: String
    @NSManaged var sourceUrl: String
    @NSManaged var factNumber: Int
    
    //var factLabel: UILabel!
    
    
    //MARK: PFSubclassing Protocol
    
    // 3
    static func parseClassName() -> String {
        return "Fact"
    }
    
    // 4
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}