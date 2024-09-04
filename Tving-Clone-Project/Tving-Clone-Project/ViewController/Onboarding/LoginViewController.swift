//
//  LoginViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class LoginViewController: BaseViewController<LoginViewModel> {

    // MARK: - Properties
    
    var nickname = PublishSubject<String?>()
    
    // MARK: - Components
    
    private let loginView = LoginView()
    
    /// Bottom Sheet가 present 될 때 추가되는 어두운 배경 뷰
    private let dimmedView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = loginView
    }
    
    // MARK: - bindViewModel

    override func bindViewModel() {
        let input = LoginViewModel.Input(
            textFieldBeginEditingEvent:
                Observable.merge(
                    loginView.idTextField.rx.controlEvent(.editingDidBegin).map { self.loginView.idTextField },
                    loginView.pwTextField.rx.controlEvent(.editingDidBegin).map { self.loginView.pwTextField }
                ),
            textFieldIsEditingEvent:
                Observable.merge(
                    loginView.idTextField.rx.controlEvent(.editingChanged).map { self.loginView.idTextField },
                    loginView.pwTextField.rx.controlEvent(.editingChanged).map { self.loginView.pwTextField }
                ),
            textFieldDidEndEditingEvent:
                Observable.merge(
                    loginView.idTextField.rx.controlEvent(.editingDidEnd).map { self.loginView.idTextField },
                    loginView.pwTextField.rx.controlEvent(.editingDidEnd).map { self.loginView.pwTextField }
                ),
            returnKeyDidTapEvent:
                Observable.merge(
                    loginView.idTextField.rx.controlEvent(.editingDidEndOnExit).map { [self] in loginView.idTextField },
                    loginView.pwTextField.rx.controlEvent(.editingDidEndOnExit).map { [self] in loginView.pwTextField }
                ),
            nicknameDidChangeEvent: nickname.asObservable(),
            loginButtonDidTapEvent: loginView.loginButton.rx.tap.asObservable(),
            idXButtonDidTapEvent: loginView.idXButton.rx.tap.map { [self] in loginView.idXButton },
            pwXButtonDidTapEvent: loginView.pwXButton.rx.tap.map { [self] in loginView.pwXButton },
            makeNicknameButtonDidTapEvent: loginView.makeNicknameButton.rx.tap.asObservable(),
            eyeButtonDidTapEvent: loginView.pwEyeButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.validLoginNickname.subscribe(onNext: { [self] nickname in
            pushToWelcomeVC(id: loginView.idTextField.text!, nickname: nickname)
        }).disposed(by: disposeBag)
        
        output.noNicknameErr.subscribe(onNext: { [self] _ in
            presentAlert(title: StringLiteral.noNicknameErrTitle, message: StringLiteral.noNicknameErrMsg) {
                self.loginView.clearTextFields()
            }
        }).disposed(by: disposeBag)
        
        output.regexErr.subscribe(onNext: { [self] _ in
            presentAlert(title: StringLiteral.regexErrTitle, message: StringLiteral.regexErrMsg) {
                self.loginView.clearTextFields()
            }
        }).disposed(by: disposeBag)
        
        output.clearIdTextField.subscribe { [self] _ in
            loginView.idTextField.text = ""
            loginView.idTextField.sendActions(for: .editingChanged)
        }.disposed(by: disposeBag)
        
        output.clearPwTextField.subscribe { [self] _ in
            loginView.pwTextField.text = ""
            loginView.pwTextField.sendActions(for: .editingChanged)
        }.disposed(by: disposeBag)
        
        output.isLoginButtonActive.subscribe { [self] isActive in
            loginView.loginButton.activateButtonStyle(isActivate: isActive)
        }.disposed(by: disposeBag)
        
        output.presentBottomSheet.subscribe { [self] _ in
            addDimmedView()
            presentBottomSheetVC()
        }.disposed(by: disposeBag)
        
        output.changeSecurity.subscribe { [self] _ in
            loginView.pwEyeButton.setImage(loginView.pwTextField.isSecureTextEntry ? .eye : .eyeSlash, for: .normal)
            loginView.pwTextField.isSecureTextEntry.toggle()
        }.disposed(by: disposeBag)
        
        output.isSideButtonVisible.subscribe(onNext: { [self] isVisible, textField in
            loginView.changeSideButtonVisibility(isVisible: isVisible, textField: textField)
        }).disposed(by: disposeBag)
        
        output.isBorderVisible.subscribe { isVisible, textField in
            textField.changeBorderVisibility(isVisible: isVisible, color: UIColor.gray9C.cgColor)
        }.disposed(by: disposeBag)
        
        output.dismissKeyboard.subscribe(onNext: { textField in
            textField.resignFirstResponder()
        })
        .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    
    // MARK: - Helpers
    
    /// 배경에 dimmedView를 추가하는 함수
    /// - 1. animate를 통해 서서히 추가되는 것 같은 효과 제공
    /// - 2. animation 끝나면 서브뷰로 추가 및 레이아웃 설정
    private func addDimmedView() {
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 1.0
        } completion: { [self] _ in
            view.addSubview(dimmedView)
            dimmedView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    private func pushToWelcomeVC(id: String, nickname: String) {
        let welcomeVC = WelcomeViewController(viewModel: WelcomeViewModel(nickname: nickname))
        welcomeVC.modalPresentationStyle = .fullScreen
        welcomeVC.modalTransitionStyle = .coverVertical
        self.present(welcomeVC, animated: true)
    }
    
    private func presentBottomSheetVC() {
        let bottomSheetVC = BottomSheetViewController(viewModel: BottomSheetViewModel())
        bottomSheetVC.delegate = self
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: true)
    }
}

// MARK: - BottomSheetDelegate

// BottomSheetDelegate를 채택하여 BottomSheetVC가 시키는 일을 대신 한다
extension LoginViewController: BottomSheetDelegate {
    
    /// dimmedView를 제거하는 함수
    /// - 1. animate를 통해 서서히 없어지는 것 같은 효과 제공
    /// - 2. animation 끝나면 super view에서 진짜 제거
    func removeDimmedView() {
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 0.0
        } completion: { _ in
            self.dimmedView.removeFromSuperview()
        }
    }
    
    /// BottomSheetVC에서 입력받은 유저의 닉네임 데이터를 LoginVC의 nickname 변수에 저장하는 함수
    func passUserData(nickname: String) {
        self.nickname.onNext(nickname)
    }
}
