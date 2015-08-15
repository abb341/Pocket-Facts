//
//  ParseHelper.swift
//  Tips
//
//  Created by Aaron Brown on 7/16/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    
    static func queryForRecentFacts(completionBlock: PFArrayResultBlock) {
        //Query Parse
        let query = PFQuery(className: "Fact")
        query.orderByDescending("factNumber")
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}
