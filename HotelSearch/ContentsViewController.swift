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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        
    }
    
    override func viewDidLayoutSubviews() {
        setupImage()
    }
    
    /// 画面がタッチされた際に呼ばれる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        for touch in touches {
        print("iftapped:\(touch.view?.tag)")
        }
    }
    
    /// PageViewに表示するコンテンツを用意する
    private func setupContent() {
        guard let guardContentNum = contentNum else { return }
        view.userInteractionEnabled = true
        view.tag = guardContentNum
    
    }
    
    /// 画像を貼り付ける
    private func setupImage() {
        print(view.bounds.size.height)
        
        let url = ConnectDb().connectDbJaran()
        guard let guardContentNum = contentNum else { return }
        
        let imageUrl = NSURL(string: url[guardContentNum])
        
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
