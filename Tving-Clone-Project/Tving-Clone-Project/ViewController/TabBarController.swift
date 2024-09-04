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
        let homeVC = HomeViewController(viewModel: HomeViewModel())
        configTabBar(
            title: StringLiteral.homeStr,
            tabImgName: StringLiteral.homeImgName,
            tabUnselectedImgName: StringLiteral.homeUnselectedImgName,
            vc: homeVC
        )
        let boxOfficeVC = BoxOfficeViewController(viewModel: BoxOfficeViewModel())
        configTabBar(
            title: StringLiteral.soonStr,
            tabImgName: StringLiteral.soonImgName,
            tabUnselectedImgName: StringLiteral.soonUnselectedImgName,
            vc: boxOfficeVC
        )
        let thirdVC = UIViewController()
        configTabBar(
            title: StringLiteral.searchStr,
            tabImgName: StringLiteral.searchImgName,
            tabUnselectedImgName: StringLiteral.searchImgName,
            vc: thirdVC
        )
        let fourthVC = UIViewController()
        configTabBar(
            title: StringLiteral.recordStr,
            tabImgName: StringLiteral.recordImgName,
            tabUnselectedImgName: StringLiteral.recordUnselectedImgName,
            vc: fourthVC
        )
        
        self.viewControllers = [homeVC, boxOfficeVC, thirdVC, fourthVC]
    }
    
    /// 탭바 설정
    private func configTabBar(
        title: String,
        tabImgName: String,
        tabUnselectedImgName: String,
        vc: UIViewController
    ) {
        vc.title = title
        vc.tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: tabImgName),
            selectedImage: UIImage(systemName: tabImgName)
        )
    }
}
