//
//  HomeViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/27/24.
//

import UIKit

import RxCocoa
import RxRelay
import RxSwift
import SnapKit
import Then

struct Tab {
    let name: String
    let width: CGFloat
}

/// 티빙 메인 화면
final class HomeViewController: BaseViewController<HomeViewModel> {
    
    // MARK: - Components
    
    private lazy var homeView = HomeView(headers: viewModel.headers, tabs: viewModel.tabs)
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = homeView
    }
    
    // MARK: - bindViewModel
    
    override func bindViewModel() {
        let input = HomeViewModel.Input(viewWillAppearEvent: self.rx.viewWillAppear.asObservable())
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.bigPosters.subscribe { bigPosters in
            self.homeView.bigPosters = bigPosters
        }.disposed(by: disposeBag)
        
        output.posters.subscribe { posters in
            self.homeView.posters = posters
        }.disposed(by: disposeBag)
        
        output.livePrograms.subscribe { livePrograms in
            self.homeView.livePrograms = livePrograms
        }.disposed(by: disposeBag)
        
        output.baseballSlogans.subscribe { baseballSlogans in
            self.homeView.baseballSlogans = baseballSlogans
        }.disposed(by: disposeBag)
    }
}
