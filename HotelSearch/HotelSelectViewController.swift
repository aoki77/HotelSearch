//
//  ViewController.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class HotelSelectViewController: UIViewController {
    
    // MARK: - 変数
    
    private var selectMenuTable: UITableView?
    private var statusBar: UIStatusBarStyle?

    
    // MARK: - ライフサイクル関数

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageView()
        setupTableView()
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
        let menuView: UIPageViewController = MenuPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        
        menuView.view.frame = CGRect(x: 0, y: barHeight(), width: view.bounds.size.width, height: (view.bounds.size.height - barHeight()) / 3)
        
        addChildViewController(menuView)
        view.addSubview(menuView.view)
        menuView.didMoveToParentViewController(self)
    }
    
    /// テーブルをセット
    private func setupTableView() {
        
        /* 
         高さは動的に変化するように後で変更する
         */
        // TableViewの生成する(status barの高さ分ずらして表示).
        selectMenuTable = UITableView(frame: CGRect(x: 0, y: ((view.bounds.size.height - barHeight()) / 3) + barHeight(), width: view.bounds.size.width, height: (((view.bounds.size.height - barHeight()) / 3) * 2)))
        
        guard let guardSelectMenuTable = selectMenuTable else { return }
        
        // Cell名の登録
        guardSelectMenuTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // スクロール禁止
        guardSelectMenuTable.scrollEnabled = false
        
        guardSelectMenuTable.dataSource = self
        guardSelectMenuTable.delegate = self
        
        // Viewに追加
        self.view.addSubview(guardSelectMenuTable)
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
