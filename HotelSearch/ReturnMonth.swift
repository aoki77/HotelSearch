//
//  ReturnMonth.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/17.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

final class ReturnMonth {
    
    /// 翌月を返す
    func nextMonth(currentMonth: NSDate) -> NSDate {
        let addValue: Int = 1
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.month = addValue
        return calendar.dateByAddingComponents(dateComponents, toDate: currentMonth, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /// 昨月を返す
    func lastMonth(currentMonth: NSDate) -> NSDate {
        let addValue = -1
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.month = addValue
        return calendar.dateByAddingComponents(dateComponents, toDate: currentMonth, options: NSCalendarOptions(rawValue: 0))!
    }
}
