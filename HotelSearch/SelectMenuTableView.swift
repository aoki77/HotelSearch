//
//  SelectMenuTableView.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/31.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class SelectMenuTableView: UITableView {
    
    // MARK: - 定数プロパティ

    private let headers = ["ホテル名で検索", "条件で検索"]
    
    // ライフサイクル関数
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 各カラムのタイトル用ラベルを返す
    private func setTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width / 3, height: rowHeight)
        
        return label
    }
    
    ///　名前検索のセクションのコンテンツをセット
    private func setNameSelectSection(cell: UITableViewCell) {
        // textFieldの設定
        let textField = UITextField()
        textField.frame = CGRect(x: 10, y: 0, width: (cell.bounds.size.width / 3) * 2, height: cell.bounds.size.height)
        textField.placeholder = "ホテル名を入力してください"
        textField.adjustsFontSizeToFitWidth = true
        
        // buttonの設定
        let button = UIButton()
        button.frame = CGRect(x: (cell.bounds.size.width / 3) * 2 + 10, y: 0, width: cell.bounds.size.width / 3 - 10, height: cell.bounds.size.height)
        button.backgroundColor = .blueColor()
        button.setTitle("名前検索", forState: .Normal)
        button.setTitleColor(.whiteColor(), forState: .Normal)
        button.addTarget(self, action: #selector(nameButtonClick(_:)), forControlEvents: .TouchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20.0
        
        cell.addSubview(textField)
        cell.addSubview(button)
    
    }
    
    /// 名前検索のボタンが押された時に呼ばれる
    func nameButtonClick(sender: UIButton) {
    }
    
    /// 条件検索のセクションのコンテンツをセット
    private func setConditionsSelectSection(cell: UITableViewCell) {
        setTitleLabel("宿泊日,部屋数")
        setTitleLabel("人数")
        setTitleLabel("予算")
        setTitleLabel("エリア")
        
    }
}

// MARK: - UITableViewDataSource

extension SelectMenuTableView: UITableViewDataSource {
    
    /// Cellの総数を返すデータソースメソッド
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 7
        default:
            return 0
        }
    }
    
    /// テーブルビューのセクション数を返すメソッド
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    /// Cellに値を設定するデータソースメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("selectMenuCell", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            setNameSelectSection(cell)
        } else {
            setConditionsSelectSection(cell)
        }
        
        return cell
    }
    
    ///セクション毎のタイトルをヘッダーに表示
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
}

// MARK: - UITableViewDelegate

extension SelectMenuTableView: UITableViewDelegate {
    
    /// Cellが選択された際に呼び出されるデリゲートメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}