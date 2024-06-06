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
        
        createDefaultTabBar()
    }
    
    // MARK: - Helpers
    
    /// 티빙의 기본 하단 탭바를 생성
    /// 홈, 공개예정, 검색, 기록 총 4개의 탭바로 구성
    private func createDefaultTabBar() {
        let mainVC = MainViewController()
        configTabBar(
            title: .homeTitle,
            tabImgName: .homeImgName,
            tabUnselectedImgName: .homeUnselectedImgName,
            vc: mainVC
        )
        let boxOfficeVC = BoxOfficeViewController()
        configTabBar(
            title: .soonTitle,
            tabImgName: .soonImgName,
            tabUnselectedImgName: .soonUnselectedImgName,
            vc: boxOfficeVC
        )
        let thirdVC = UIViewController()
        configTabBar(
            title: .searchTitle,
            tabImgName: .searchImgName,
            tabUnselectedImgName: .searchImgName,
            vc: thirdVC
        )
        let fourthVC = UIViewController()
        configTabBar(
            title: .recordTitle,
            tabImgName: .recordImgName,
            tabUnselectedImgName: .recordUnselectedImgName,
            vc: fourthVC
        )
        
        self.viewControllers = [mainVC, boxOfficeVC, thirdVC, fourthVC]
    }
    
    /// 탭바 설정
    private func configTabBar(
        title: StringLiteral,
        tabImgName: StringLiteral,
        tabUnselectedImgName: StringLiteral,
        vc: UIViewController
    ) {
        vc.title = title.rawValue
        vc.tabBarItem = UITabBarItem(
            title: title.rawValue,
            image: UIImage(systemName: tabImgName.rawValue),
            selectedImage: UIImage(systemName: tabImgName.rawValue)
        )
    }
}
