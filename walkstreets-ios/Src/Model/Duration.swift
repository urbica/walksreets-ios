//
//  Duration.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 07/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON

class Duration {
    
    dynamic var hours: Float = 0
    dynamic var minutes: Float = 0
    
    var durationString: String  {
        
        guard self.hours > 0 else {
            return String(format: "%.0f mins", self.minutes)
        }
        
        let minutes = Int(round(self.minutes / 6))
        let hours = Int(self.hours)
        
        var durationString = ""
        
        durationString.append("\(hours)")
        
        if minutes != 0 {
            durationString.append(".\(minutes)")
        }
        
        if hours > 1 {
            durationString.append(" hours")
        }
        else {
            durationString.append(" hour")
        }
        
        return durationString
    }
}
