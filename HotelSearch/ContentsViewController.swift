//
//  ContentsViewController.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController {

    // MARK: - 変数プロパティ
    
    var contentNum: Int?
    var hotelData: HotelData?
    var planTableFlag = false
    
    // MARK: - ライフサイクル関数

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
    }
    
    override func viewDidLayoutSubviews() {
        setupText()
        setupImage()
    }
    
    // MARK: - プライベート関数
    
    /// PageViewに表示するコンテンツを用意する
    private func setupContent() {
        guard let guardContentNum = contentNum else { return }
        view.userInteractionEnabled = true
        view.tag = guardContentNum
        view.backgroundColor = .whiteColor()
    }
    
    /// テキストを設定
    private func setupText() {
        guard let guardHotelData = hotelData else { return }
        
        let textView = UIView()
        textView.backgroundColor = .whiteColor()

        textView.frame = CGRect(x: view.bounds.size.width / 2, y: 0, width: view.bounds.size.width / 2, height: view.bounds.size.height)
        
        // ホテル名
        let hotelName = UILabel(frame: CGRectMake(0, 0, textView.bounds.width, textView.bounds.height / 7 * 2))
        hotelName.layer.position = CGPoint(x: textView.bounds.width / 2, y: textView.bounds.height / 7)
        hotelName.font = UIFont.systemFontOfSize(12)
        hotelName.numberOfLines = 2
        hotelName.adjustsFontSizeToFitWidth = true
        hotelName.text = guardHotelData.hotelName
        
        // 所在地(都道府県)
        let hotelPefecture = UILabel(frame: CGRect(x: 0, y: 0, width: textView.bounds.width, height: textView.bounds.height / 7))
        hotelPefecture.layer.position = CGPoint(x: textView.bounds.width / 2, y: (textView.bounds.height / 7 * 2))
        hotelPefecture.font = UIFont.systemFontOfSize(12)
        hotelPefecture.adjustsFontSizeToFitWidth = true
        hotelPefecture.text = guardHotelData.prefecture
        
        // 大まかなエリア
        let hotelLargeArea = UILabel(frame: CGRect(x: 0, y: 0, width: textView.bounds.width, height: textView.bounds.height / 7))
        hotelLargeArea.layer.position = CGPoint(x: textView.bounds.width / 2, y: (textView.bounds.height / 7 * 3))
        hotelLargeArea.font = UIFont.systemFontOfSize(12)
        hotelLargeArea.adjustsFontSizeToFitWidth = true
        hotelLargeArea.text = "\(guardHotelData.largeArea)エリア"
        
        /// ホテルのキャッチコピー
        let hotelCatchCopy = UILabel(frame: CGRect(x: 0, y: 0, width: textView.bounds.width, height: (textView.bounds.height / 7) * 3))
        hotelCatchCopy.layer.position = CGPoint(x: textView.bounds.width / 2, y: (textView.bounds.height / 7) * 5)
        hotelCatchCopy.font = UIFont.systemFontOfSize(12)
        hotelCatchCopy.numberOfLines = 3
        hotelCatchCopy.adjustsFontSizeToFitWidth = true
        hotelCatchCopy.text = guardHotelData.hotelCatchCopy
        
        textView.addSubview(hotelName)
        textView.addSubview(hotelPefecture)
        textView.addSubview(hotelLargeArea)
        textView.addSubview(hotelCatchCopy)
        
        view.addSubview(textView)
        
    }
    
    /// 画面がタッチされた際に呼ばれる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        // 親画面(HotelSelectViewController)に値を送る
        if let pageView: MenuPageViewController = parentViewController as? MenuPageViewController {
            if let selectView: HotelSelectViewController = pageView.parentViewController as? HotelSelectViewController {
                
                guard let guardContentNum = contentNum else { return }
                
                // フラグ及びScrollViewの高さを更新する
                if planTableFlag {
                    selectView.hidePlanTalbe(guardContentNum)
                    planTableFlag = false
                    selectView.updateNonePlanTableHeight()
                    
                } else {
                    selectView.outputPlanTable(guardContentNum)
                    planTableFlag = true
                    selectView.updatePlanTableHeight(guardContentNum)
                }
            }
        }
    }

    /// 画像を設定
    private func setupImage() {
        
        guard let guardHotelData = hotelData else { return }
        
        let image = SetupImage().setImage(guardHotelData.pictureUrl)
        
        UIGraphicsBeginImageContext(CGSize(width: view.bounds.size.width / 2, height: view.bounds.size.height))
        
        // UIImageView 初期化
        let imageView = UIImageView(image:image)
        
        // 画像の位置を設定
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width / 2, height: view.bounds.size.height)
        
        // UIImageViewのインスタンスをビューに追加
        view.addSubview(imageView)
    }
}
