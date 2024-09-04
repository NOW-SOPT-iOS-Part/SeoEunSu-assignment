//
//  WelcomeViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

import SnapKit
import Then

final class WelcomeViewController: BaseViewController<WelcomeViewModel> {
    
    // MARK: - Components
    
    private lazy var welcomeView = WelcomeView(nickname: viewModel.nickname)
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = welcomeView
    }
    
    // MARK: - bindViewModel

    override func bindViewModel() {
        let input = WelcomeViewModel.Input(
            toMainButtonDidTap: welcomeView.toMainButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.presentTabBarController.subscribe(onNext: {
            self.presentTabBarController()
        }).disposed(by: disposeBag)
    }
}

extension WelcomeViewController {
    
    // MARK: - Helpers
    
    /// 메인으로 버튼 클릭 시 호출되는 함수
    private func presentTabBarController() {
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.modalTransitionStyle = .crossDissolve
        self.present(tabBarVC, animated: true)
    }
}
