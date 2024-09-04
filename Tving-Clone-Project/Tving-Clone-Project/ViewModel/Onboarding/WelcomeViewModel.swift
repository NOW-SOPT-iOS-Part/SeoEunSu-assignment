//
//  WelcomeViewModel.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import UIKit

import RxRelay
import RxSwift
import SnapKit
import Then

final class WelcomeViewModel: ViewModelType {
    
    // MARK: - Properties
    
    let nickname: String
    
    init(nickname: String) {
        self.nickname = nickname
    }
    
    // MARK: - Input
    
    struct Input {
        let toMainButtonDidTap: Observable<Void>
    }
    
    // MARK: - Output
    
    struct Output {
        let presentTabBarController = PublishRelay<Void>()
    }
}

extension WelcomeViewModel {
    
    // MARK: - transform
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        input.toMainButtonDidTap.subscribe(onNext: {
            output.presentTabBarController.accept(Void())
        }).disposed(by: disposeBag)
        return output
    }
}
