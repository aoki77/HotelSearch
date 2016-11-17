//
//  MenuPageViewController.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

class MenuPageViewController: UIPageViewController {
    
    //　MARK: - 変数プロパティ
    
    private var pageControl: UIPageControl!
    
    var hotelData: [HotelData]?
    
    /// PageViewに表示するViewを格納した配列
    private var contentViews = [UIViewController]()
    
    private var currentIndex: Int = 0
    
    // MARK: - ライフサイクル関数

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentsView()
    }
    
    override func viewDidLayoutSubviews() {
       setupPageControl()
    }
    
    // MARK: - プライベート関数
    
    /// PageViewに表示するViewを用意する
    private func setupContentsView() {
        
        dataSource = self
        delegate = self
        
        guard let guardHotelData = hotelData else { return }
        // 必要数Viewを用意する
        for num in 0 ..< guardHotelData.count {
            let contentView = ContentsViewController()
            contentView.contentNum = num
            contentView.hotelData = guardHotelData[num]
            contentViews.append(contentView)
        }
        setViewControllers([contentViews[0]], direction: .Forward, animated: true, completion: nil)
    }
    
    /// PageControlの設定
    private func setupPageControl() {
        pageControl = UIPageControl(frame: CGRectMake(0, (view.bounds.size.height / 5) * 4, view.bounds.size.width, view.bounds.size.height / 5))
        
        pageControl.pageIndicatorTintColor = .lightGrayColor()
        pageControl.currentPageIndicatorTintColor = .greenColor()
        pageControl.backgroundColor = .clearColor()
        
        // PageControlするページ数を設定する.
        pageControl.numberOfPages = contentViews.count
        
        // 現在ページを設定する.
        pageControl.currentPage = 0
        //pageControl.userInteractionEnabled = true
        
        view.addSubview(pageControl)
    }
}

// MARK: - UIPageViewControllerDataSource

extension MenuPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = contentViews.indexOf(viewController) where index != NSNotFound else { return nil }
        if index < contentViews.count - 1 {
            return contentViews[index + 1]
        } else {
            return contentViews.first
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let index = contentViews.indexOf(viewController) where index != NSNotFound else { return nil }
        if index > 0 {
            return contentViews[index - 1]
        } else {
            return contentViews.last
        }
    }
}

// MARK: - UIPageViewControllerDelegate

extension MenuPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let contentVC = pageViewController.viewControllers?.first else { return }
        guard let index = contentViews.indexOf(contentVC) where index != NSNotFound else { return }
        pageControl.currentPage = index
        
        if let selectView: HotelSearchViewController = parentViewController as? HotelSearchViewController {
            for planTable in selectView.planTables {
                if planTable.hidden == false {
                    // PageViewがスワイプされた時にプラン一覧が開かれていた場合そのプラン一覧を閉じる
                    planTable.hidden = true
                    // 次のプラン一覧を開く
                    selectView.planTables[index].hidden = false
                    // プラン一覧の高さに合わせてScrollViewを変更する関数を呼び出す
                    selectView.updatePlanTableHeight(index)
                }
            }
        }
    }
}
