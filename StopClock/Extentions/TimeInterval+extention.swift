//
//  TimeInterval+extention.swift
//  StopClock
//
//  Created by Damodar Namala on 24/08/22.
//

import Foundation

extension TimeInterval {
     var timeString : String   {
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))
        let minutes = Int(self.truncatingRemainder(dividingBy: 60 * 60) / 60)
        let hours = Int(self / 3600)
        return String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }
}
