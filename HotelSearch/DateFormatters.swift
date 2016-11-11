//
//  DateFormatter.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/08.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

final class DateFormatters {
    
    /// 「yyyy年MM月」を返す
    let dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "yyyy年MM月"
        return dateFormatter
    }()
    
}
