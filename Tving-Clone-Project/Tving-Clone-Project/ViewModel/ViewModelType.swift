//
//  ViewModelType.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output
}
