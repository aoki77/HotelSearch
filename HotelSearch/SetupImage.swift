//
//  setImage.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/28.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

final class SetupImage {
    
    /// 画像のURL(String)を送るとImageの状態にして返してくれる
    func setImage(url: String) -> UIImage {
        
        let imageUrl = NSURL(string: url)
        
        guard let guardImageUrl = imageUrl else { return UIImage() }
        
        let imageData = NSData(contentsOfURL: guardImageUrl)
        
        guard let guardImageData = imageData else { return UIImage() }
        
        // UIImage インスタンスの生成
        let image = UIImage(data: guardImageData)!
        
        return image
    }
}
