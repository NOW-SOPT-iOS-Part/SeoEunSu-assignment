//
//  TabBarController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/27/24.
//

import UIKit

/// 하단 탭바
final class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .black
        
        setDefaultTabBar()
    }
    
    // MARK: - Helpers
    
    /// 티빙의 기본 하단 탭바를 설정
    /// 홈, 공개예정, 검색, 기록 총 4개의 탭바로 구성한다
    private func setDefaultTabBar() {
        let mainVC = MainViewController()
        addTabBar(title: "홈", tabImg: UIImage(systemName: "house"), tabUnselectedImg: UIImage(systemName: "house.fill"), vc: mainVC)
        let secondVC = UIViewController()
        addTabBar(title: "공개예정", tabImg: UIImage(systemName: "video"), tabUnselectedImg: UIImage(systemName: "video.fill"), vc: secondVC)
        let thirdVC = UIViewController()
        addTabBar(title: "검색", tabImg: UIImage(systemName: "magnifyingglass"), tabUnselectedImg: UIImage(systemName: "magnifyingglass"), vc: thirdVC)
        let fourthVC = UIViewController()
        addTabBar(title: "기록", tabImg: UIImage(systemName: "clock"), tabUnselectedImg: UIImage(systemName: "clock.fill"), vc: fourthVC)
        
        self.viewControllers = [mainVC, secondVC, thirdVC, fourthVC]
    }
    
    /// 탭바 추가
    /// 하단 탭바에 버튼을 추가해준다
    private func addTabBar(title: String, tabImg: UIImage?, tabUnselectedImg: UIImage?, vc: UIViewController) {
        vc.title = title
        vc.tabBarItem = UITabBarItem(title: title, image: tabImg, selectedImage: tabUnselectedImg)
    }
}
