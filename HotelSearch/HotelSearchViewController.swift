//
//  HotelSearchViewController.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit
import Alamofire

class HotelSearchViewController: UIViewController {
    
    // MARK: - 定数プロパティ
    
    private let scrollView = UIScrollView()
    
    // MARK: - 変数プロパティ
    
    private var searchMenuTable = SearchMenuTableView()
    private var statusBar: UIStatusBarStyle?
    private var pageView = MenuPageViewController()
    private var planTable: PlanTableView?
    var planTables = [PlanTableView]()
    var hotelData: [HotelData]!
    var lodgingDate: String?
    
    // MARK: - ライフサイクル関数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupScrollView()
        setupPageView()
        setupPlanTable()
        setupSearchMenuTable()
        updateNonePlanTableHeight()
    }
    
    // MARK: - プライベート関数
    
    /// APIからデータを取ってきて格納する
    private func setupData() {
        hotelData = ConnectJalan().connectRecommendHotel()
//        hotelData.appendContentsOf(ConnectRakuten().connectRecommendHotel())
    }
    
    /// NaviBarとStatusBarの高さを足した値を返す
    private func barHeight() -> CGFloat {
        
        // ステータスバーの高さを取得
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        // ナビゲーションバーの高さを取得
        let naviBarHeight = navigationController?.navigationBar.frame.size.height
        
        guard let guardNaviBarHeight = naviBarHeight else { return 0 }
        
        return statusBarHeight + guardNaviBarHeight
        
    }
    
    /// PageViewをセット
    private func setupPageView() {
        guard let guardHotelData = hotelData else { return }
        pageView = MenuPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageView.hotelData = guardHotelData
        pageView.view.frame = CGRect(x: 0, y: barHeight(), width: view.bounds.size.width, height: (view.bounds.size.height - barHeight()) / 3)
        addChildViewController(pageView)
        scrollView.addSubview(pageView.view)
        pageView.didMoveToParentViewController(self)
    }
    
    /// プラン表示用テーブルをセット
    private func setupPlanTable() {
        guard let guardHotelData = hotelData else { return }
        for num in 0 ..< guardHotelData.count {
            planTable = PlanTableView(frame: CGRectMake(0, barHeight() + pageView.view.bounds.height, view.bounds.size.width, (view.bounds.size.height - (barHeight() + pageView.view.bounds.height) / 3) * 2 ))
            guard let guardPlanTable = planTable else { return }
            guardPlanTable.hotelData = guardHotelData[num]
            guardPlanTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "planCell")
            guardPlanTable.rowHeight = view.bounds.size.height / 10
            guardPlanTable.hidden = true
            guardPlanTable.scrollEnabled = false
            planTables.append(guardPlanTable)
            scrollView.addSubview(guardPlanTable)
        }
    }
    
    /// 検索用テーブルをセット
    private func setupSearchMenuTable() {
        
        // TableViewの生成する(status barの高さ分ずらして表示).
        searchMenuTable = SearchMenuTableView()
        
        // Cell名の登録
        searchMenuTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "searchMenuCell")
        
        // スクロール禁止
        searchMenuTable.scrollEnabled = false
        
        // セルの高さを指定
        searchMenuTable.rowHeight = view.bounds.size.height / 10
        
        // セクションのヘッダーの高さ
        searchMenuTable.sectionHeaderHeight =  30
        
        searchMenuTable.delegate = self
        
        // テーブルの幅、高さ(セルの数が9、ヘッダーの数が2)
        searchMenuTable.frame = CGRectMake(0, barHeight() + pageView.view.bounds.height, view.bounds.size.width, (searchMenuTable.rowHeight * 5) + (searchMenuTable.rowHeight * 2 * 4) + (searchMenuTable.sectionHeaderHeight * 2))
        
        // Viewに追加
        scrollView.addSubview(searchMenuTable)
    }
    
    /// ScrollViewをセット
    private func setupScrollView() {
        // ScrollViewを生成
        scrollView.frame = CGRectMake(0, (-1 * barHeight()), view.frame.size.width, view.frame.size.height + barHeight())
        view.addSubview(scrollView)
    }
    
    // MARK: - スタティック関数
    
    /// プラン表示用テーブルを隠す
    func hidePlanTalbe(contentNum: Int) {
        planTables[contentNum].hidden = true
    }
    
    /// プラン表示用テーブルを出力
    func outputPlanTable(contentNum: Int) {
        planTables[contentNum].hidden = false
    }
    
    /// プラン表示用テーブルに合わせてScrollViewのコンテンツサイズを変更
    func updatePlanTableHeight(contentNum: Int) {
        scrollView.contentSize.height =  pageView.view.bounds.size.height + planTables[contentNum].bounds.size.height + barHeight() + searchMenuTable.bounds.size.height
        searchMenuTable.frame.origin.y = pageView.view.bounds.size.height + planTables[contentNum].bounds.size.height + barHeight()
    }
    
    /// プラン表示用テーブルを換算しないようにScrollViewのコンテンツサイズを変更
    func updateNonePlanTableHeight() {
        scrollView.contentSize.height = pageView.view.bounds.size.height + barHeight() + searchMenuTable.bounds.size.height
        searchMenuTable.frame.origin.y = pageView.view.bounds.size.height + barHeight()
    }
    
    /// 検索用テーブルを再更新
    func updateTable() {
        searchMenuTable.lodgingDate = lodgingDate
        searchMenuTable.reloadData()
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension HotelSearchViewController: UIPopoverPresentationControllerDelegate {
    
    /// iPhoneでpopoverを表示するための設定
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
    }
}

extension HotelSearchViewController: UITableViewDelegate {
    
    /// SearchMenuTableViewのCellが選択された際に呼び出される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let calendar = CalendarCollectionViewController()
            calendar.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: CalendarLayout())
            calendar.collectionView?.frame = CGRect(x: 0, y: barHeight(), width: view.bounds.size.width, height: view.bounds.size.height - barHeight())
            calendar.collectionView!.registerClass(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
            
            self.navigationController?.pushViewController(calendar, animated: true)
        }
    }
}
