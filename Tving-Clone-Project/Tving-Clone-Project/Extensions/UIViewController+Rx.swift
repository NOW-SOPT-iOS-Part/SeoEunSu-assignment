//
//  UIViewController+Rx.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { $0.first as? Bool ?? false }
    }
    
    var viewDidAppear: Observable<Bool> {
        return methodInvoked(#selector(Base.viewDidAppear(_:)))
            .map { $0.first as? Bool ?? false }
    }
    
    var viewWillDisappear: Observable<Bool> {
        return methodInvoked(#selector(Base.viewWillDisappear(_:)))
            .map { $0.first as? Bool ?? false }
    }
    
    var viewDidDisappear: Observable<Bool> {
        return methodInvoked(#selector(Base.viewDidDisappear(_:)))
            .map { $0.first as? Bool ?? false }
    }
}
