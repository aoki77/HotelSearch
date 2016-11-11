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
    
    // 第一引数に何行目か、第二引数に表示したい値を入れることでLabelを生成し返してくれる
    private func setLabel(rowNumber: CGFloat, hotelData: String) -> UILabel {
        let label = UILabel()
        label.text = hotelData
        label.frame = CGRect(x: 0, y: (rowHeight / 3) * (rowNumber - 1), width: UIScreen.mainScreen().bounds.size.width, height: rowHeight / 3)
        label.font = UIFont(name: "Arial", size: rowHeight / 4)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }
}

// MARK: - UITableViewDataSource

extension PlanTableView: UITableViewDataSource {
    
    /// Cellの総数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let guardHotelData = hotelData else { return 0 }
        return guardHotelData.planName.count - 1
    }
    
    /// Cellに値を設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("planCell", forIndexPath: indexPath)
        
        guard let guardHotelData = hotelData else { return cell }
        
        // テーブルビューの高さをセル数に合わせて変更
        tableView.frame.size.height = rowHeight * CGFloat(guardHotelData.planName.count - 1)
        
        // プラン名の設定
        cell.addSubview(setLabel(1, hotelData: guardHotelData.planName[indexPath.row + 1]))
        // 部屋タイプの設定
        cell.addSubview(setLabel(2, hotelData: "\t部屋: \(guardHotelData.roomName[indexPath.row + 1])"))
        // プラン価格の設定
        cell.addSubview(setLabel(3, hotelData: "\t価格: \(guardHotelData.planSampleRateFrom[indexPath.row + 1])円"))
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PlanTableView: UITableViewDelegate {
    
    /// Cellが選択された際に呼び出される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // safariで詳細ページに飛ばす
        guard let guardHotelData = hotelData else { return }
        let url = NSURL(string: guardHotelData.planDetailUrl[indexPath.row + 1])
        if UIApplication.sharedApplication().canOpenURL(url!){
            UIApplication.sharedApplication().openURL(url!)
        }
    }
}
