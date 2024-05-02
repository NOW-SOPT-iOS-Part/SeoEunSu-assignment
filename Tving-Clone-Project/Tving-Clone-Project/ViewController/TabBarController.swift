//
//  TabBarController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/27/24.
//

import UIKit

/// 탭바 타이틀 타입
enum TabBarTitleType: String {
    case home = "홈"
    case soon = "공개예정"
    case search = "검색"
    case record = "기록"
}

/// 탭바 클릭 안 됐을 때 이미지 타입
enum TabBarUnselectedImgNameType: String {
    case home = "home"
    case soon = "video"
    case search = "magnifyingglass"
    case record = "clock"
}

/// 탭바 클릭됐을 때 이미지 타입
enum TabBarselectedImgNameType: String {
    case home = "home.fill"
    case soon = "video.fill"
    case search = "magnifyingglass"
    case record = "clock.fill"
}

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
            title: .home,
            tabImgName: .home,
            tabUnselectedImgName: .home,
            vc: mainVC
        )
        let secondVC = UIViewController()
        configTabBar(
            title: .soon,
            tabImgName: .soon,
            tabUnselectedImgName: .soon,
            vc: secondVC
        )
        let thirdVC = UIViewController()
        configTabBar(
            title: .search,
            tabImgName: .search,
            tabUnselectedImgName: .search,
            vc: thirdVC
        )
        let fourthVC = UIViewController()
        configTabBar(
            title: .record,
            tabImgName: .record,
            tabUnselectedImgName: .record,
            vc: fourthVC
        )
        
        self.viewControllers = [mainVC, secondVC, thirdVC, fourthVC]
    }
    
    /// 탭바 설정
    private func configTabBar(
        title: TabBarTitleType,
        tabImgName: TabBarselectedImgNameType,
        tabUnselectedImgName: TabBarUnselectedImgNameType,
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
