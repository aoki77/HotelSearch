//
//  DateFormatter.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/08.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

final class DateFormatters {
    
    /// 年月のフォーマッター
    let dateFormatterYearMonth: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "yyyy/MM"
        return dateFormatter
    }()
    
    /// 年のフォーマッター
    let dateFormatterYear: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }()
    
    /// 月のフォーマッター
    let dateFormatterMonth: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "MM"
        return dateFormatter
    }()
    
    /// 日のフォーマッター
    let dateFormatterDay: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    /// 年月日のフォーマッター(日本語)
    let  dateFormatterYearMonthDay: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return dateFormatter
    }()
}
