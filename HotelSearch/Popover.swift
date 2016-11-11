//
//  PopoverController.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/10.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class Popover {
    
//    func setPopover(sourceView: UIView!) {
//        HotelSelectViewController().modalPresentationStyle = UIModalPresentationStyle.Popover
//        // popの大きさ
////        viewController.preferredContentSize = CGSizeMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height / 5)
////        
////        let popoverController = viewController.popoverPresentationController
//        // 出す向き(
//        popoverController?.permittedArrowDirections = UIPopoverArrowDirection.Left
//        // どこから出た感じにするか
//        popoverController?.sourceView = sourceView
//        popoverController?.sourceRect = sourceView.bounds
//        
//        //self.presentViewController(viewController, animated: true, completion: nil)
//    }
    
    private func setPicker(pickerView: UIPickerView) -> UIPickerView {
        pickerView.frame = CGRect(x:UIScreen.mainScreen().bounds.size.width / 4, y:0, width:  (UIScreen.mainScreen().bounds.size.width / 4) * 3, height: 0)
        return pickerView
    }
    
    
    
}


