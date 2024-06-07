//
//  BottomSheetViewModel.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import UIKit

import RxRelay
import RxSwift
import SnapKit
import Then

final class BottomSheetViewModel: ViewModelType {
    
    // MARK: - Properties
    
    var nickname: String?
    
    // MARK: - Input
    
    struct Input {
        let textFieldBeginEditingEvent: Observable<Void>
        let textFieldIsEditingEvent: Observable<UITextField>
        let textFieldDidEndEditingEvent: Observable<Void>
        let returnKeyDidTapEvent: Observable<Void>
        let saveButtonDidTapEvent: Observable<Void>
        let backgroundViewDidTapEvent: Observable<UITapGestureRecognizer>
    }
    
    // MARK: - Output
    
    struct Output {
        let isBorderVisible = PublishRelay<Bool>()
        let isButtonActive = PublishRelay<Bool>()
        let dismissKeyboard = PublishRelay<Void>()
        let validNickname = PublishRelay<Void>()
        let nicknameRegexErr = PublishRelay<Void>()
        let backToTheLoginVC = PublishRelay<Void>()
    }
}

extension BottomSheetViewModel {
    
    // MARK: - transform
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.textFieldBeginEditingEvent.subscribe(onNext: {
            output.isBorderVisible.accept(true)
        }).disposed(by: disposeBag)
        
        input.textFieldIsEditingEvent.subscribe(onNext: { textField in
            self.nickname = textField.text
            guard let nickname = self.nickname else { return }
            output.isButtonActive.accept(!nickname.isEmpty)
        }).disposed(by: disposeBag)
        
        input.textFieldDidEndEditingEvent.subscribe(onNext: {
            output.isBorderVisible.accept(false)
        }).disposed(by: disposeBag)
        
        input.returnKeyDidTapEvent.subscribe(onNext: {
            output.dismissKeyboard.accept(Void())
        }).disposed(by: disposeBag)
        
        input.saveButtonDidTapEvent.subscribe(onNext: {
            guard let nickname = self.nickname else { return }
            if self.isNicknameMatchRegex(input: nickname) {
                output.validNickname.accept(Void())
            } else {
                output.nicknameRegexErr.accept(Void())
            }
        }).disposed(by: disposeBag)
        
        input.backgroundViewDidTapEvent.subscribe(onNext: { _ in
            output.backToTheLoginVC.accept(Void())
        }).disposed(by: disposeBag)
        
        return output
    }
}

extension BottomSheetViewModel {
    
    // MARK: - Helpers
    
    private func isNicknameMatchRegex(input: String) -> Bool {
        let regexPattern = "[ㄱ-ㅎ가-힣]{2,10}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regexPattern)
        return pred.evaluate(with: input)
    }
}
