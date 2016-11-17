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
    private var labelNumber = 0
    
    // keyにピッカーが表示されるセルの行数を指定
    private let pickerViews = [1: DatePickerView(), 3: PeoplePickerView()]
    
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
        let textField = UITextField()
        textField.frame = CGRect(x: margin, y: 0, width: (cell.bounds.size.width / 3) * 2, height: cell.bounds.size.height)
        textField.placeholder = "ホテル名を入力してください"
        textField.adjustsFontSizeToFitWidth = true
        
        // buttonの設定
        let button = UIButton()
        button.frame = CGRect(x: (cell.bounds.size.width / 3) * 2 + margin, y: 0, width: cell.bounds.size.width / 3 - margin, height: cell.bounds.size.height)
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
    private func setConditionsSelectSection(cell: UITableViewCell, indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            cell.addSubview(setTitleLabel(indexPath))
        } else if indexPath.row == 1 {
            cell.addSubview(setPicker(pickerViews[1]!))
        } else if indexPath.row == 2 {
            cell.addSubview(setTitleLabel(indexPath))
            cell.addSubview(setButoonView())
            
        } else if indexPath.row == 3 {
            cell.addSubview(setPeopleCell())
        }
        
        //        // 偶数の時はピッカーを表示
        //        if indexPath.row % 2 == 0 {
        //            cell.addSubview(setTitleLabel(indexPath))
        //        } else if indexPath.row == 1 || indexPath.row == 3 {
        //            guard let pickerView = pickerViews[indexPath.row] else { return }
        //            cell.addSubview(setPicker(pickerView))
        //        } else if indexPath.row == 5 {
        //            // テキストボックスを設定
        //
        //        } else if indexPath.row == 7 {
        //            // 地域選択画面へ遷移
        //        }
        
    }
    
    private func setPickerPop() {
        
    }
    
    private func setPicker(pickerView: UIPickerView) -> UIPickerView {
        pickerView.frame = CGRect(x:UIScreen.mainScreen().bounds.size.width / 4, y:0, width:  (UIScreen.mainScreen().bounds.size.width / 4) * 3, height: rowHeight)
        return pickerView
    }
    
    private func setButoonView() -> UIView {
        let view = UIView()
        view.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 3, y: 0, width: (UIScreen.mainScreen().bounds.size.width / 3) * 2, height: rowHeight)
        
        let plusButton = createButton("+")
        plusButton.frame = CGRect(x: view.bounds.size.width / 4 * 3, y: 0, width: view.bounds.size.width / 4, height: rowHeight)
        plusButton.setTitleColor(.blueColor(), forState: .Normal)
        plusButton.addTarget(self, action: #selector(plusButtonClick(_:)), forControlEvents: .TouchUpInside)
        let minusButton = createButton("-")
        minusButton.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width / 4, height: rowHeight)
        minusButton.setTitleColor(.blueColor(), forState: .Normal)
        minusButton.addTarget(self, action: #selector(minusButtonClick(_:)), forControlEvents: .TouchUpInside)
        
        Number.text = String(labelNumber)
        Number.frame = CGRect(x: view.bounds.size.width / 4 * 2, y: 0, width: view.bounds.size.width / 4, height: rowHeight)

        
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        view.addSubview(Number)
        
        return view
        
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
    
    private func setPeopleCell() -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: rowHeight)
        let adlutLabel = UILabel()
        adlutLabel.text = "大人"
        adlutLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width / 8, height: rowHeight)
        
        let minusButton = createButton("-")
        minusButton.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 8, y: 0, width: UIScreen.mainScreen().bounds.size.width / 8, height: rowHeight)
        
        let label = UILabel()
        label.text = "10"
        label.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 8 * 2, y: 0, width: UIScreen.mainScreen().bounds.size.width / 8, height: rowHeight)
        
        let plusButton = createButton("+")
        plusButton.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 8 * 3, y: 0, width: UIScreen.mainScreen().bounds.size.width / 8, height: rowHeight)
        
        let childLabel = UILabel()
        childLabel.text = "子供"
        childLabel.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 8 * 4, y: 0, width: UIScreen.mainScreen().bounds.size.width / 8, height: rowHeight)
        
        let minusButton2 = createButton("-")
        minusButton2.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 8 * 5, y: 0, width: UIScreen.mainScreen().bounds.size.width / 8, height: rowHeight)
        
        let label2 = UILabel()
        label2.text = "200"
        label2.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 8 * 6, y: 0, width: UIScreen.mainScreen().bounds.size.width / 8, height: rowHeight)
        
        let plusButton2 = createButton("+")
        plusButton2.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width / 8 * 7, y: 0, width: UIScreen.mainScreen().bounds.size.width / 8, height: rowHeight)
        
        view.addSubview(adlutLabel)
        view.addSubview(childLabel)
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        view.addSubview(plusButton2)
        view.addSubview(minusButton2)
        view.addSubview(label)
        view.addSubview(label2)
        
        return view
    }
    
    /// 各カラムのタイトル用ラベルを返す
    private func setTitleLabel(indexPath: NSIndexPath) -> UILabel {
        
        let label = UILabel()
        
        // 2回に一回ラベルを挿入する
        label.text = conditionsCellNames[indexPath.row / 2]
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width / 3, height: rowHeight)
        label.adjustsFontSizeToFitWidth = true
        return label
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
//        if indexPath.row % 2 == 1 {
//            return rowHeight * 2
//        } else {
//            return rowHeight
//        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension SearchMenuTableView: UIPopoverPresentationControllerDelegate {
    
    /// iPhoneでpopoverを表示するための設定
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
