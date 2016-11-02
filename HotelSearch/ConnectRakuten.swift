//
//  ConnectRakuten.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/01.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

final class ConnectRakuten: NSObject {
    
    // MARK: - 定数プロパティ
    
    /// APIKey
    private let APIKey = "1083005176773598352"
    
    /// 表示件数
    private let count = 5
    
    /// 表示の並び順
    private let order = "standard"
    
    /// 国
    private let country = "japan"
    
    /// 都道府県
    private let prefectures = "tokyo"
    
    /// 地区
    private let district = "tokyo"
    
    /// 詳細地区
    private let detailDistrict = "A"
    
    /// お勧めのホテルのデータを取ってくる
    func connectRecommendHotel() -> [HotelData] {
        
        let url = NSURL(string: "https://app.rakuten.co.jp/services/api/Travel/VacantHotelSearch/20131024?applicationId=\(APIKey)&format=json&largeClassCode=\(country)&middleClassCode=\(prefectures)&smallClassCode=\(district)&detailClassCode=\(detailDistrict)&hits=\(count)&sort=\(order)")

        guard let guardUrl = url else { return [HotelData()] }
        
        Alamofire.request(.GET, guardUrl).responseJSON { response in
            
            print(response.description)
            print("nanndehairanaino?")
            
        }
        print("oioimajika")
        
        return [HotelData()]
    }
}
