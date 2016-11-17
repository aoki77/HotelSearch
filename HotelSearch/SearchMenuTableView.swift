//
//  SearchMenuTableView.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/31.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class SearchMenuTableView: UITableView {
    
    // MARK: - 定数プロパティ
    
    private let headers = ["ホテル名で検索", "条件で検索"]
    private let conditionsCellNames = ["宿泊日", "滞在日数", "予算", "エリア"]
    
    private let Number = UILabel()
    
    private let lodgingDateLabel = UILabel()
    private let hotelNameTextField = UITextField()
    private let hotelNameSearchView = UIView()
    private let hotelNameSearchButton = UIButton()
    
    // keyにピッカーが表示されるセルの行数を指定
    private let pickerViews = [1: DatePickerView(), 3: PeoplePickerView()]
    
    // MARK: - 変数プロパティ
    
    private var labelNumber = 0
    var lodgingDate: String?
    
    // ライフサイクル関数
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///　名前検索のセクションのコンテンツをセット
    private func setNameSelectSection(cell: UITableViewCell) {
        let margin:CGFloat = 10
        // textFieldの設定
        hotelNameTextField.frame = CGRect(x: margin, y: 0, width: (cell.bounds.size.width / 3) * 2, height: cell.bounds.size.height)
        hotelNameTextField.placeholder = "ホテル名を入力してください"
        hotelNameTextField.adjustsFontSizeToFitWidth = true
        
        // buttonの設定
        
        hotelNameSearchButton.frame = CGRect(x: (cell.bounds.size.width / 3) * 2 + margin, y: 0, width: cell.bounds.size.width / 3 - margin, height: cell.bounds.size.height)
        hotelNameSearchButton.backgroundColor = .blueColor()
        hotelNameSearchButton.setTitle("名前検索", forState: .Normal)
        hotelNameSearchButton.setTitleColor(.whiteColor(), forState: .Normal)
        hotelNameSearchButton.addTarget(self, action: #selector(nameButtonClick(_:)), forControlEvents: .TouchUpInside)
        hotelNameSearchButton.layer.masksToBounds = true
        hotelNameSearchButton.layer.cornerRadius = 20.0
        
        cell.addSubview(hotelNameTextField)
        cell.addSubview(hotelNameSearchButton)
    }
    
    /// 名前検索のボタンが押された時に呼ばれる
    func nameButtonClick(sender: UIButton) {
        
    }
    
    /// 条件検索のセクションのコンテンツをセット
    private func setConditionsSelectSection(cell: UITableViewCell, indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            cell.addSubview(setTitleLabel(indexPath))
            cell.addSubview(setDateLabel())
        } else if indexPath.row == 1 {
            cell.addSubview(setTitleLabel(indexPath))
            cell.addSubview(setButonView())
        }
    }
    
    private func setPicker(pickerView: UIPickerView) -> UIPickerView {
        pickerView.frame = CGRect(x:UIScreen.mainScreen().bounds.size.width / 4, y:0, width:  (UIScreen.mainScreen().bounds.size.width / 4) * 3, height: rowHeight)
        return pickerView
    }
    
    private func setButonView() -> UIView {
        hotelNameSearchView.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 3, y: 0, width: (UIScreen.mainScreen().bounds.size.width / 3) * 2, height: rowHeight)
        
        let plusButton = createButton("+")
        plusButton.frame = CGRect(x: hotelNameSearchView.bounds.size.width / 4 * 3, y: 0, width: hotelNameSearchView.bounds.size.width / 4, height: rowHeight)
        plusButton.setTitleColor(.blueColor(), forState: .Normal)
        plusButton.addTarget(self, action: #selector(plusButtonClick(_:)), forControlEvents: .TouchUpInside)
        let minusButton = createButton("-")
        minusButton.frame = CGRect(x: 0, y: 0, width: hotelNameSearchView.bounds.size.width / 4, height: rowHeight)
        minusButton.setTitleColor(.blueColor(), forState: .Normal)
        minusButton.addTarget(self, action: #selector(minusButtonClick(_:)), forControlEvents: .TouchUpInside)
        
        Number.text = String(labelNumber)
        Number.frame = CGRect(x: hotelNameSearchView.bounds.size.width / 4 * 2, y: 0, width: hotelNameSearchView.bounds.size.width / 4, height: rowHeight)

        hotelNameSearchView.addSubview(plusButton)
        hotelNameSearchView.addSubview(minusButton)
        hotelNameSearchView.addSubview(Number)
        
        return hotelNameSearchView
        
    }
    
    /// 名前検索のボタンが押された時に呼ばれる
    func plusButtonClick(sender: UIButton) {
        labelNumber += 1
        Number.text = String(labelNumber)
    }
    
    /// 名前検索のボタンが押された時に呼ばれる
    func minusButtonClick(sender: UIButton) {
        labelNumber -= 1
        Number.text = String(labelNumber)
    }
    
    private func createButton(text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, forState: .Normal)
        button.setTitleColor(.blueColor(), forState: .Normal)
        return button
    }
    
    /// 各カラムのタイトル用ラベルを返す
    private func setTitleLabel(indexPath: NSIndexPath) -> UILabel {
        let label = UILabel()
        // 2回に一回ラベルを挿入する
        label.text = conditionsCellNames[indexPath.row]
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width / 3, height: rowHeight)
        label.textAlignment = .Center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    // MARK: - スタティック関数
    
    func setDateLabel() -> UILabel {
        guard let guardLodgingDate = lodgingDate else { return UILabel() }
        lodgingDateLabel.text = guardLodgingDate
        lodgingDateLabel.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 3, y: 0, width: UIScreen.mainScreen().bounds.size.width / 3 * 2, height: rowHeight)
        lodgingDateLabel.textAlignment = .Center
        lodgingDateLabel.textColor = .grayColor()
        return lodgingDateLabel
    }
}

// MARK: - UITableViewDataSource

extension SearchMenuTableView: UITableViewDataSource {
    
    /// Cellの総数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 8
        }
    }
    
    /// テーブルビューのセクション数を返す
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    /// Cellに値を設定するデータソースメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("searchMenuCell", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            setNameSelectSection(cell)
        } else {
            setConditionsSelectSection(cell, indexPath: indexPath)
        }
        return cell
    }
    
    /// セクション毎のタイトルをヘッダーに表示
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    /// テーブルセルの高さを返す
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension SearchMenuTableView: UIPopoverPresentationControllerDelegate {
    
    /// iPhoneでpopoverを表示するための設定
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
