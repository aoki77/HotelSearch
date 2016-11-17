//
//  CalendarCollectionViewController.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/14.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit
import CalculateCalendarLogic

class CalendarCollectionViewController: UICollectionViewController {
    
    /// 一週間
    private let week = 7
    
    /// 日付のカラムの行数
    private let columnNum = 6
    
    /// 曜日
    private let dayOfWeek = ["日", "月", "火", "水", "木", "金", "土"]
    
    // MARK: - 変数プロパティ
    
    /// 現在の月
    var currentMonth = NSDate()
    
    /// 表示されている月の日付の配列
    private var currentMonthDate = [NSDate]()
    
    // MARK: - ライフサイクル関数
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateNavigationItem()
        setupCalendar()
        setupSwipe()
    }
    
    // MARK: - プライベート関数
    
    /// NavigationBarのタイトルを更新する
    private func updateNavigationItem() {
        navigationItem.title = DateFormatters().dateFormatterYearMonth.stringFromDate(currentMonth)
    }
    
    private func setupCalendar() {
        collectionView!.scrollEnabled = false
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        view.addSubview(collectionView!)
    }
    
    /// 月の初日を取得
    private func firstDate() -> NSDate {
        
        // 選択されている日付の月の初日を取得
        let components = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: currentMonth)
        components.day = 1
        
        // 取得した初日の日付をNSDateに変換
        let firstDateMonth = NSCalendar.currentCalendar().dateFromComponents(components)!
        
        return firstDateMonth
    }
    
    /// 表記する日にちの取得
    private func dateForCellAtIndexPath(num: Int) {
        
        // 月の初日が一週間を日曜を開始するとした際の経過した日数を取得する
        let firstDay = NSCalendar.currentCalendar().ordinalityOfUnit(.Day, inUnit: .WeekOfMonth, forDate: firstDate())
        
        for i in 0 ..< num {
            // 月の初日と表示される日付の差を計算する
            let dateComponents = NSDateComponents()
            dateComponents.day = i - (firstDay - 1)
            // 月の初日より前の日付を取得
            let date = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: firstDate(), options: NSCalendarOptions(rawValue: 0))!
            
            currentMonthDate.append(date)
        }
    }
    
    /// カレンダーの日付の表記変更
    private func conversionDateFormat(indexPath: NSIndexPath) -> String {
        dateForCellAtIndexPath(columnNum * week)
        return DateFormatters().dateFormatterDay.stringFromDate(currentMonthDate[indexPath.row])
    }
    
    /// セルの背景色を変更する
    private func cellColorChange(cell: CalendarCell, indexPath: NSIndexPath) -> CalendarCell {
        if DateFormatters().dateFormatterYearMonth.stringFromDate(currentMonthDate[indexPath.row]).compare(DateFormatters().dateFormatterYearMonth.stringFromDate(currentMonth)) != NSComparisonResult.OrderedSame {
            cell.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        } else if indexPath.row % 7 == 0 {
            cell.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 1.0, alpha: 1.0)
        } else if (indexPath.row + 1) % 7 == 0 {
            cell.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            cell.backgroundColor = .whiteColor()
        }
        return cell
    }
    
    /// カレンダーのテキストの色を変更する
    private func textColorChange(cell: CalendarCell, indexPath: NSIndexPath) -> CalendarCell {
        if indexPath.row % 7 == 0 {
            cell.calendarLabel.textColor = .redColor()
        } else if (indexPath.row + 1) % 7 == 0 {
            cell.calendarLabel.textColor = .blueColor()
        } else {
            cell.calendarLabel.textColor = .blackColor()
        }
        
        // 該当日が祝日かどうかを判定してboolを返す
        let holidayFlag = CalculateCalendarLogic().judgeJapaneseHoliday(Int(DateFormatters().dateFormatterYear.stringFromDate(currentMonthDate[indexPath.row]))!, month: Int(DateFormatters().dateFormatterMonth.stringFromDate(currentMonthDate[indexPath.row]))!, day: Int(DateFormatters().dateFormatterDay.stringFromDate(currentMonthDate[indexPath.row]))!)
        
        if holidayFlag {
            cell.calendarLabel.textColor = .redColor()
        }
        
        return cell
    }
    
    /// スワイプされた時の設定
    private func setupSwipe() {
        /// 右から左へスワイプをされた時
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeNextMonth))
        swipeLeft.delegate = self
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        collectionView!.addGestureRecognizer(swipeLeft)
        
        /// 左から右へスワイプされた時
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeLastMonth))
        swipeRight.delegate = self
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        collectionView!.addGestureRecognizer(swipeRight)
    }
    
    // MARK: - UICollectionViewDataSource
    
    /// セクション数を決める
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // 曜日と一ヶ月の日付を表示する2つのセクションを用意する
        return 2
    }
    
    /// セクションごとのセルの総数を決定する
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変更
        if section == 0 {
            // 最初のセクションでは曜日を表示させるため一週間分のcellを総数とする
            
            return week
        } else {
            // 月によって表示を変える処理を書く
            return columnNum * week
        }
    }
    
    /// セルのデータを返す
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // コレクションビューから識別子「calendarCell」のセルを取得
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! CalendarCell
        
        // セクションによってテキストと色を変更する
        if indexPath.section == 0 {
            cell.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 1.0)
            cell.calendarLabel.text = dayOfWeek[indexPath.row]
            cell.calendarLabel.textColor = .blackColor()
        } else if indexPath.section == 1 {
            cell.calendarLabel.text = conversionDateFormat(indexPath)
            cell = textColorChange(cell, indexPath: indexPath)
            cell = cellColorChange(cell, indexPath: indexPath)
        }
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).CGColor
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    // セルクリック時の処理
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            // 一番最初の画面のインスタンスを呼び出す
            let hotelSearchViewController = navigationController?.viewControllers[0] as! HotelSearchViewController
            hotelSearchViewController.lodgingDate = DateFormatters().dateFormatterYearMonthDay.stringFromDate(currentMonthDate[indexPath.row])
            // 検索用テーブルを更新(日付のセルだけ更新するようにした方が良い気がする)
            hotelSearchViewController.updateTable()
            
            // 一つ前の画面に遷移
            navigationController?.popViewControllerAnimated(true)
        }
    }
}

extension CalendarCollectionViewController: UIGestureRecognizerDelegate {
    
    /// 翌月を呼び出す
    func swipeNextMonth() {
        currentMonthDate.removeAll()
        currentMonth = ReturnMonth().nextMonth(currentMonth)
        updateNavigationItem()
        collectionView!.reloadData()
    }
    
    /// 昨月を呼び出す
    func swipeLastMonth() {
        currentMonthDate.removeAll()
        currentMonth = ReturnMonth().lastMonth(currentMonth)
        updateNavigationItem()
        collectionView!.reloadData()
    }
}
