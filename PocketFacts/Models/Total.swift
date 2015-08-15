//
//  Total.swift
//  Tips
//
//  Created by Aaron Brown on 8/3/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import Foundation
import Parse

class Total: PFObject, PFSubclassing {
    @NSManaged var numberOfFacts: Int
    
    //MARK: PFSubclassing Protocol
    
    // 3
    static func parseClassName() -> String {
        return "Total"
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
