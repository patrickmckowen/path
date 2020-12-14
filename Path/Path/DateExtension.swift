//
//  DateExtension.swift
//  Path
//
//  Created by Patrick McKowen on 12/9/20.
//

import Foundation

extension Date {
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }

    var isYesterday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self)
    }
}
