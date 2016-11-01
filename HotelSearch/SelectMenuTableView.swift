//
//  SelectMenuTableView.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/31.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class SelectMenuTableView: UITableView {
    
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

extension SelectMenuTableView: UITableViewDataSource {
    
    /// Cellの総数を返すデータソースメソッド
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    /// Cellに値を設定するデータソースメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("selectMenuCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = "\(indexPath.row)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SelectMenuTableView: UITableViewDelegate {
    
    /// Cellが選択された際に呼び出されるデリゲートメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}