//
//  ClanedarLayout.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/14.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class CalendarLayout: UICollectionViewLayout {
    
    // MARK: - 定数プロパティ
    
    private let columnNum = 3
    
    private let week = 7
    
    /// 行の数
    private let rowNum = 7
    
    // MARK: - 変数プロパティ
    
    /// レイアウト配列
    private var layoutData = [UICollectionViewLayoutAttributes]()
    
    // MARK: - ライフサイクル関数
    
    /// レイアウトを準備するメソッド
    override func prepareLayout() {
        layoutDataSetup()
    }
    
    /// レイアウトを返す
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutData
    }
    
    // MARK: -プライベート関数
    
    private func layoutDataSetup() {
        
        guard let guardCollectionView = collectionView else { return }
        
        // レイアウトデータの中身を削除
        layoutData.removeAll()
        
        // 1列の幅
        let columnWidth = guardCollectionView.bounds.size.width / CGFloat(week)
        
        //セルの高さ
        let columnHeight = guardCollectionView.bounds.size.height / CGFloat(rowNum)
        
        // コレクションの座標
        var point = CGPoint(x: guardCollectionView.bounds.origin.x, y: guardCollectionView.bounds.origin.y)
        
        // 曜日のセクションの座標を決定
        for count in 0 ..< guardCollectionView.numberOfItemsInSection(0) {
            let indexPath = NSIndexPath(forItem:count, inSection:0)
            
            // レイアウトの配列に位置とサイズを登録する。
            let frame = CGRect(x: point.x, y: point.y, width: columnWidth, height: columnHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.frame = frame
            layoutData.append(attributes)
            
            // x座標を更新
            point.x += columnWidth
        }
        
        var point2 = CGPoint(x: guardCollectionView.bounds.origin.x,y: guardCollectionView.bounds.origin.y + columnHeight)
        
        // 日付のセクションの座標を決定
        for count in 0 ..< guardCollectionView.numberOfItemsInSection(1) {
            let indexPath = NSIndexPath(forItem:count, inSection:1)
            
            // レイアウトの配列に位置とサイズを登録する。
            let frame = CGRect(x: point2.x, y: point2.y, width: columnWidth, height: columnHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.frame = frame
            layoutData.append(attributes)
            
            // x座標を更新
            point2.x += columnWidth
            
            if (count + 1) % week == 0 {
                point2.x = 0
                point2.y += columnHeight
            }
        }
    }
}
