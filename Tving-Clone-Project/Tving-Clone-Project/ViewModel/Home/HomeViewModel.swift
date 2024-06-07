//
//  HomeViewModel.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import UIKit

import RxCocoa
import RxRelay
import RxSwift

final class HomeViewModel: ViewModelType {
    
    // MARK: - Properties
    
    let headers: [String] = [
        StringLiteral.emptyHeaderStr,
        StringLiteral.contentsHeaderStr,
        StringLiteral.popularLiveHeaderStr,
        StringLiteral.paramountPlusHeaderStr,
        StringLiteral.emptyHeaderStr,
        StringLiteral.userContentsHeaderStr
    ]
    
    let tabs: [Tab] = [
        Tab(name: StringLiteral.homeStr, width: 15),
        Tab(name: StringLiteral.liveStr, width: 55),
        Tab(name: StringLiteral.tvProgramStr, width: 85),
        Tab(name: StringLiteral.movieStr, width: 35),
        Tab(name: StringLiteral.paramountPlusStr, width: 90)
    ]
    
    // MARK: - Input
    
    struct Input {
        let viewWillAppearEvent: Observable<Bool>
    }
    
    // MARK: - Output
    
    struct Output {
        var bigPosters = PublishRelay<[Poster]>()
        var posters = PublishRelay<[Poster]>()
        var livePrograms = PublishRelay<[LiveProgram]>()
        var baseballSlogans = PublishRelay<[BaseballSlogan]>()
    }
}

extension HomeViewModel {
    
    // MARK: - transform
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        input.viewWillAppearEvent.subscribe(onNext: { _ in
            output.bigPosters.accept(Poster.dummyDataForBig())
            output.posters.accept(Poster.dummyDataForSmall())
            output.livePrograms.accept(LiveProgram.dummyData())
            output.baseballSlogans.accept(BaseballSlogan.dummyData())
        }).disposed(by: disposeBag)
        return output
    }
}
