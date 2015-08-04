//
//  DateHelper.swift
//  Tips
//
//  Created by Aaron Brown on 7/15/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import Foundation

class DateHelper {
    
    // initialize the date formatter only once, using a static computed property
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
        }()
    
    static func getTodaysFactNumber(var numberOfFacts: Int) -> Int {
        let LAUNCH_DATE = DateHelper.dateFormatter.dateFromString("2015-08-01")
        let calendar = NSCalendar.currentCalendar()
        let days = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay, fromDate: LAUNCH_DATE!, toDate: NSDate(), options: nil).day
        var factNumber = days + 1
        if factNumber > numberOfFacts {
            println("Number is greater than number of facts: \(factNumber)")
            factNumber = (factNumber % numberOfFacts) + 1
        }
        println("factNumber: \(factNumber)")
        println("numberOfFacts: \(numberOfFacts)")
        println(factNumber%numberOfFacts)
        return factNumber
    }
    
    static func recentFactNumbers(var numberOfFacts: Int) -> [Int] {
        let TODAYS_FACT_NUMBER = DateHelper.getTodaysFactNumber(numberOfFacts)
        
        var recentFactNumbers: [Int] = []
        
        var indexFactNumber = TODAYS_FACT_NUMBER
        for var i: Int = 0; i < 7; i++ {
            if indexFactNumber > 1 {
                indexFactNumber--
            }
            else {
                indexFactNumber = numberOfFacts
            }
            recentFactNumbers.append(indexFactNumber)
            println("Array: \(recentFactNumbers[i])")
        }
        
        return recentFactNumbers
    }
    
}