//
//  DatePickerView.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/08.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class DatePickerView: UIPickerView {
    
    // MARK: - 定数プロパティ
    
    private let years = (2016...2020).map { $0 }
    private let months = (1...12).map { $0 }
    private let days =  (1...31).map { $0 }
    /// 宿泊日数(じゃらん側の最大値が9日)
    private let stayDays = (1...9).map { $0 }
    
    // MARK: - ライフサイクル関数
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabel(pickerView: UIPickerView, label: UILabel) {
        let month = months[pickerView.selectedRowInComponent(0)]
        let day = days[pickerView.selectedRowInComponent(1)]
        
        label.text = "\(month)月 \(day)日"
    }
}

// MARK: - UIPickerViewDataSource

extension DatePickerView: UIPickerViewDataSource {
    
    /// ピッカーのカラム数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    /// ピッカーの各カラムの行数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        case 2:
            return days.count
        default:
            return 0
        }
    }
}

// MARK: - UIPickerViewDelegate

extension DatePickerView: UIPickerViewDelegate {
    
    /// ピッカーの各セルの表示内容
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(years[row])年"
        case 1:
            return "\(months[row])月"
        case 2:
            return "\(days[row])日"
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        switch component {
        case 0:
            return 2 * (pickerWidth / 5)
        case 1:
            return 1.5 * pickerWidth / 5
        case 2:
            return 1.5 * pickerWidth / 5
        default:
            return 0
        }
    }

    /// ピッカーが変更された際の処理
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // ラベル変更処理
        //setLabel(pickerView, label: startTimeLabel)
    }
    

}
