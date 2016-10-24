//
//  ContentsViewController.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController {

    var contentNum: Int?
    var hotelData: [HotelData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupContent()
    }
    
    override func viewDidLayoutSubviews() {
        setupText()
        setupImage()
    }
    
    /// 画面がタッチされた際に呼ばれる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        for touch in touches {
        print("iftapped:\(touch.view?.tag)")
        }
    }
    
    /// APIからデータを取ってきて格納する
    private func setupData() {
       hotelData = ConnectJaran().connectAPI()
    }
    
    /// PageViewに表示するコンテンツを用意する
    private func setupContent() {
        guard let guardContentNum = contentNum else { return }
        view.userInteractionEnabled = true
        view.tag = guardContentNum
        view.backgroundColor = .whiteColor()
    
    }
    
    /// テキストを設定
    private func setupText() {
        guard let guardContentNum = contentNum else { return }
        guard let guardHotelData = hotelData else { return }
        print(guardHotelData[guardContentNum].hotelName)
        print("\(guardHotelData[guardContentNum].prefecture) \(guardHotelData[guardContentNum].largeArea)エリア")
        print(guardHotelData[guardContentNum].hotelCatchCopy)
        
        let textView = UIView()
        textView.backgroundColor = .whiteColor()

        
        textView.frame = CGRect(x: view.bounds.size.width / 2, y: 0, width: view.bounds.size.width / 2, height: view.bounds.size.height)
        
        let hotelName = UILabel(frame: CGRectMake(0, 0, textView.bounds.width, textView.bounds.height / 7 * 2))
        hotelName.layer.position = CGPoint(x: textView.bounds.width / 2, y: textView.bounds.height / 7)
        hotelName.font = UIFont.systemFontOfSize(12)
        hotelName.numberOfLines = 2
        hotelName.adjustsFontSizeToFitWidth = true
        
        let hotelPefecture = UILabel(frame: CGRect(x: 0, y: 0, width: textView.bounds.width, height: textView.bounds.height / 7))
        hotelPefecture.layer.position = CGPoint(x: textView.bounds.width / 2, y: (textView.bounds.height / 7 * 2))
        hotelPefecture.font = UIFont.systemFontOfSize(12)
        hotelPefecture.adjustsFontSizeToFitWidth = true
        
        let hotelLargeArea = UILabel(frame: CGRect(x: 0, y: 0, width: textView.bounds.width, height: textView.bounds.height / 7))
        hotelLargeArea.layer.position = CGPoint(x: textView.bounds.width / 2, y: (textView.bounds.height / 7 * 3))
        hotelLargeArea.font = UIFont.systemFontOfSize(12)
        hotelLargeArea.adjustsFontSizeToFitWidth = true
        
        let hotelCaption = UILabel(frame: CGRect(x: 0, y: 0, width: textView.bounds.width, height: (textView.bounds.height / 7) * 3))
        hotelCaption.layer.position = CGPoint(x: textView.bounds.width / 2, y: (textView.bounds.height / 7) * 5)
        hotelCaption.font = UIFont.systemFontOfSize(12)
        hotelCaption.numberOfLines = 3
        hotelCaption.adjustsFontSizeToFitWidth = true
        
        
        
        
        
        hotelName.text = guardHotelData[guardContentNum].hotelName
        hotelPefecture.text = guardHotelData[guardContentNum].prefecture
        hotelLargeArea.text = guardHotelData[guardContentNum].largeArea
        hotelCaption.text = guardHotelData[guardContentNum].hotelCatchCopy
        
        textView.addSubview(hotelName)
        textView.addSubview(hotelPefecture)
        textView.addSubview(hotelLargeArea)
        textView.addSubview(hotelCaption)
        
        view.addSubview(textView)
        
        
    }
    
    /// 画像を設定
    private func setupImage() {
        
        guard let guardHotelData = hotelData else { return }
        guard let guardContentNum = contentNum else { return }
        
        let imageUrl = NSURL(string: guardHotelData[guardContentNum].pictureUrl)
        
        guard let guardImageUrl = imageUrl else { return }
        
        let imageData = NSData(contentsOfURL: guardImageUrl)
        
        guard let guardImageData = imageData else { return }
        
        // UIImage インスタンスの生成
        let image = UIImage(data: guardImageData)!
        
        UIGraphicsBeginImageContext(CGSize(width: view.bounds.size.width / 2, height: view.bounds.size.height))
        
        
        // UIImageView 初期化
        let imageView = UIImageView(image:image)
        
        // 画像の位置を設定
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width / 2, height: view.bounds.size.height)
        
        // UIImageViewのインスタンスをビューに追加
        view.addSubview(imageView)
        
    }

}
