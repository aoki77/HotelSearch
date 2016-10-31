//
//  PlanTableView.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/24.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class PlanTableView: UITableView {
    
    // MARK: - 変数プロパティ
    
    var hotelData: HotelData?
    var pageNum: Int?
    
    // ライフサイクル関数
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UITableViewDataSource

extension PlanTableView: UITableViewDataSource {
    
    /// Cellの総数を返すデータソースメソッド
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let guardHotelData = hotelData else { return 0 }
        return guardHotelData.planName.count - 1
    }
    
    /// Cellに値を設定するデータソースメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("planCell", forIndexPath: indexPath)
        
        // 左端まで線を引く
        cell.layoutMargins = UIEdgeInsetsZero
        
        guard let guardHotelData = hotelData else { return cell }

        // テーブルビューの高さをセル数に合わせて変更
        tableView.frame.size.height = cell.bounds.size.height * CGFloat(guardHotelData.planName.count - 1)
        
        // プラン名の設定
        let planName = UILabel()
        planName.text = guardHotelData.planName[indexPath.row + 1]
        planName.frame = CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height / 3)
        planName.font = UIFont(name: "Arial", size: cell.bounds.size.height / 4)
        planName.adjustsFontSizeToFitWidth = true
        
        // 部屋タイプの設定
        let roomName = UILabel()
        roomName.text = "\t部屋: \(guardHotelData.roomName[indexPath.row + 1])"
        roomName.frame = CGRect(x: 0, y: cell.bounds.size.height / 3, width: cell.bounds.size.width, height: cell.bounds.size.height / 3)
        roomName.font = UIFont(name: "Arial", size: cell.bounds.size.height / 4)
        roomName.adjustsFontSizeToFitWidth = true
        
        // プラン価格の設定
        let planPrice = UILabel()
        planPrice.text = "\t価格: \(guardHotelData.planSampleRateFrom[indexPath.row + 1])円"
        planPrice.frame = CGRect(x: 0, y: (cell.bounds.size.height / 3) * 2, width: cell.bounds.size.width, height: cell.bounds.size.height / 3)
        planPrice.font = UIFont(name: "Arial", size: cell.bounds.size.height / 4)
        
        cell.addSubview(planName)
        cell.addSubview(roomName)
        cell.addSubview(planPrice)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension PlanTableView: UITableViewDelegate {
    
    /// Cellが選択された際に呼び出されるデリゲートメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
    }
    
}