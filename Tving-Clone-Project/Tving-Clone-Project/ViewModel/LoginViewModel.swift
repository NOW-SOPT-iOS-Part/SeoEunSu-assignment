//
//  LoginViewModel.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import UIKit

import RxRelay
import RxSwift
import SnapKit
import Then

final class LoginViewModel: ViewModelType {
    
    // MARK: - Properties
    
    /// 정규식 유형
    enum RegexType {
        case email
        case password
    }
    
    private var idText: String?
    private var pwText: String?
    private var nicknameStr: String?
    
    // MARK: - Input
    
    struct Input {
        let textFieldBeginEditingEvent: Observable<UITextField>
        let textFieldIsEditingEvent: Observable<UITextField>
        let textFieldDidEndEditingEvent: Observable<UITextField>
        let returnKeyDidTapEvent: Observable<UITextField>
        let nicknameDidChangeEvent: Observable<String?>
        let loginButtonDidTapEvent: Observable<Void>
        let idXButtonDidTapEvent: Observable<UIButton>
        let pwXButtonDidTapEvent: Observable<UIButton>
        let makeNicknameButtonDidTapEvent: Observable<Void>
        let eyeButtonDidTapEvent: Observable<Void>
    }
    
    // MARK: - Output
    
    struct Output {
        let changeSideButtonVisibility = PublishRelay<(Bool, UITextField)>()
        let changeBorderVisibility = PublishRelay<(Bool, UITextField)>()
        let changeLoginButtonStatus = PublishRelay<Bool>()
        let validLoginNickname = PublishRelay<String>()
        let noNicknameErr = PublishRelay<Void>()
        let regexErr = PublishRelay<Void>()
        let clearIdTextField = PublishRelay<Void>()
        let clearPwTextField = PublishRelay<Void>()
        let presentBottomSheet = PublishRelay<Void>()
        let changeSecurity = PublishRelay<Void>()
        let dismissKeyboard = PublishRelay<UITextField>()
    }
}

extension LoginViewModel {
    
    // MARK: - transform
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.textFieldBeginEditingEvent.subscribe(onNext: { textField in
            if !(textField.text ?? "").isEmpty {
                output.changeSideButtonVisibility.accept((false, textField))
            }
            output.changeBorderVisibility.accept((false, textField))
        }).disposed(by: disposeBag)
        
        input.textFieldIsEditingEvent.subscribe(onNext: { [self] textField in
            print("textFieldIsEditingEvent")
            if textField.placeholder == StringLiteral.idTextFieldPlaceHolder {
                guard let idText = textField.text else { return }
                self.idText = idText
            } else {
                guard let pwText = textField.text else { return }
                self.pwText = pwText
            }
            
            output.changeSideButtonVisibility.accept((false, textField))
            output.changeBorderVisibility.accept((false, textField))
            
            guard let idText = self.idText else { return }
            guard let pwText = self.pwText else { return }
            output.changeLoginButtonStatus.accept(
                !(idText.isEmpty) && !(pwText.isEmpty)
            )
        }).disposed(by: disposeBag)
        
        input.textFieldDidEndEditingEvent.subscribe { textField in
            output.changeSideButtonVisibility.accept((true, textField))
            output.changeBorderVisibility.accept((true, textField))
        }.disposed(by: disposeBag)
        
        input.returnKeyDidTapEvent.subscribe { textField in
            output.dismissKeyboard.accept(textField)
        }.disposed(by: disposeBag)
        
        input.nicknameDidChangeEvent.subscribe(onNext: { [self] nickname in
            self.nicknameStr = nickname
        }).disposed(by: disposeBag)
        
        input.loginButtonDidTapEvent.subscribe(onNext: { [self] _ in
            guard let idText = self.idText else { return }
            guard let pwText = self.pwText else { return }
            
            if self.isMatchRegex(type: .email, input: idText)
                && self.isMatchRegex(type: .password, input: pwText) {
                if let nickname = self.nicknameStr {
                    output.validLoginNickname.accept(nickname)
                } else {
                    output.noNicknameErr.accept(Void())
                }
            } else {
                output.regexErr.accept(Void())
            }
        }).disposed(by: disposeBag)
        
        input.idXButtonDidTapEvent.subscribe(onNext: { button in
            print("idXButtonDidTapEvent")
            output.clearIdTextField.accept(Void())
            output.changeLoginButtonStatus.accept(false)
        }).disposed(by: disposeBag)
        
        input.pwXButtonDidTapEvent.subscribe(onNext: { button in
            print("pwXButtonDidTapEvent")
            output.clearPwTextField.accept(Void())
            output.changeLoginButtonStatus.accept(false)
        }).disposed(by: disposeBag)
        
        input.makeNicknameButtonDidTapEvent.subscribe { _ in
            output.presentBottomSheet.accept(Void())
        }.disposed(by: disposeBag)
        
        input.eyeButtonDidTapEvent.subscribe { _ in
            output.changeSecurity.accept(Void())
        }.disposed(by: disposeBag)
        
        return output
    }
    
    // MARK: - Helpers
    
    private func isMatchRegex(type: RegexType, input: String) -> Bool {
        var regexPattern = ""
        switch type {
        case .email:
            regexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case .password:
            regexPattern = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        }
        let pred = NSPredicate(format:"SELF MATCHES %@", regexPattern)
        return pred.evaluate(with: input)
    }
}
