//
//  CalendarCell.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/15.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var calendarLabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        calendarLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        calendarLabel.textAlignment = .Left
        addSubview(calendarLabel)
        
    }
}
