//
//  HotelSearchViewController.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class HotelSelectViewController: UIViewController {
    
    // MARK: - 定数プロパティ
    
    private let scrollView = UIScrollView()
    
    // MARK: - 変数プロパティ
    
    private var selectMenuTable = UITableView()
    private var statusBar: UIStatusBarStyle?
    private var pageView = MenuPageViewController()
    private var planTable: PlanTableView?
    var planTables = [PlanTableView]()
    var hotelData: [HotelData]?
    
    // MARK: - ライフサイクル関数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupScrollView()
        setupPageView()
        setupPlanTable()
        setupSelectTable()
    }
    
    // MARK: - プライベート関数
    
    /// APIからデータを取ってきて格納する
    private func setupData() {
        hotelData = ConnectJalan().connectAPI()
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
        for num in 0 ..< 10 {
            planTable = PlanTableView(frame: CGRectMake(0, barHeight() + pageView.view.bounds.height, view.bounds.size.width, (view.bounds.size.height - (barHeight() + pageView.view.bounds.height) / 3) * 2 ))
            guard let guardPlanTable = planTable else { return }
            guardPlanTable.hotelData = guardHotelData[num]
            guardPlanTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "planCell")
            guardPlanTable.hidden = true
            guardPlanTable.scrollEnabled = false
            planTables.append(guardPlanTable)
            scrollView.addSubview(guardPlanTable)
            
        }
    }
    
    /// 検索用テーブルをセット
    private func setupSelectTable() {
        
        // TableViewの生成する(status barの高さ分ずらして表示).
        selectMenuTable = UITableView(frame: CGRect(x: 0, y: ((view.bounds.size.height - barHeight()) / 3) + barHeight(), width: view.bounds.size.width, height: (((view.bounds.size.height - barHeight()) / 3) * 2)))
        
        // Cell名の登録
        selectMenuTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // スクロール禁止
        selectMenuTable.scrollEnabled = false
        
        selectMenuTable.dataSource = self
        selectMenuTable.delegate = self
        
        // Viewに追加
        scrollView.addSubview(selectMenuTable)
    }
    
    /// ScrollViewをセット
    private func setupScrollView() {
        // ScrollViewを生成
        scrollView.frame = CGRectMake(0, (-1 * barHeight()), view.frame.size.width, view.frame.size.height + barHeight())
        scrollView.contentSize = CGSizeMake(view.bounds.size.width, view.bounds.size.height)
        
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
    
    /// プラン表示用テーブルに合わせてscrollViewのコンテンツサイズを変更
    func updatePlanTableHeight(contentNum: Int) {
        scrollView.contentSize.height =  pageView.view.bounds.size.height + planTables[contentNum].bounds.size.height + barHeight() + selectMenuTable.bounds.size.height
        selectMenuTable.frame.origin.y = pageView.view.bounds.size.height + planTables[contentNum].bounds.size.height + barHeight()
    }
    
    func updateNonePlanTableHeight() {
        scrollView.contentSize.height = pageView.view.bounds.size.height + barHeight()
        selectMenuTable.frame.origin.y = pageView.view.bounds.size.height + barHeight()
    }
}

// MARK: - UITableViewDatasource

extension HotelSelectViewController: UITableViewDataSource {
    
    /// Cellの総数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    /// Cellに値をセット
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(indexPath.row)"
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension HotelSelectViewController: UITableViewDelegate {
    
}
