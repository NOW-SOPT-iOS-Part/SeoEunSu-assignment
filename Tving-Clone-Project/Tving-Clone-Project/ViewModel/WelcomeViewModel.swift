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
    
    let nickname: String
    
    init(nickname: String) {
        self.nickname = nickname
    }
    
    struct Input {
        let toMainButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let presentTabBarController = PublishRelay<Void>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        input.toMainButtonDidTap.subscribe(onNext: {
            output.presentTabBarController.accept(Void())
        }).disposed(by: disposeBag)
        return output
    }
}
