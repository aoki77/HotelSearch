//
//  PeoplePickerView.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/09.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class PeoplePickerView: UIPickerView {
    
    // MARK: - 定数プロパティ
    
    /// 宿泊の大人の人数(数値はじゃらん側に準拠)
    private let adults =  (1...10).map { $0 }
    /// 宿泊の子供の人数(数値はじゃらん側に準拠、小学校高学年で検索)
    private let children = (0...5).map { $0 }
    /// 固定ラベルのテキスト
    private let labels = ["大人","子供"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// pickerに固定ラベルをセット
    private func setLabel() {
        
    }
}

// MARK: - UIPickerViewDataSource

extension PeoplePickerView: UIPickerViewDataSource {
    
    /// ピッカーのカラム数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        // ピッカーのカラム数は4
        return 2
    }
    
    /// ピッカーの各カラムの行数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return adults.count
        case 1:
            return children.count
        default:
            return 0
        }
    }
}

// MARK: - UIPickerViewDelegate

extension PeoplePickerView: UIPickerViewDelegate {
    
    /// ピッカーの各セルの表示内容
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(adults[row])人"
        case 1:
            return "\(children[row])人"
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        switch component {
        case 0:
            return 2 * (pickerWidth / 6)
        case 1:
            return pickerWidth / 6
        case 2:
            return pickerWidth / 6
        case 3:
            return 2 * (pickerWidth / 6)
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