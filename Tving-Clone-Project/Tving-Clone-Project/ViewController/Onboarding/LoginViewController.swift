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
    
    private let idLoginLabel = UILabel().then {
        $0.text = StringLiteral.idLoginLabelStr
        $0.font = .pretendard(weight: 500, size: 23)
        $0.textColor = .grayD6
    }
    
    private let idTextField = UITextField().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 600, size: 15)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray2E
        $0.attributedPlaceholder = NSAttributedString(
            string: StringLiteral.idTextFieldPlaceHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray9C]
        )
        $0.addSidePadding(width: 22)
    }
    
    private let idXButton = UIButton().then {
        $0.setImage(.xCircle, for: .normal)
        $0.isHidden = true
    }
    
    private let pwTextField = UITextField().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 600, size: 15)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray2E
        $0.attributedPlaceholder = NSAttributedString(
            string: StringLiteral.pwTextFieldPlaceHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray9C]
        )
        $0.addSidePadding(width: 22)
        $0.isSecureTextEntry = true
    }
    
    private let pwXButton = UIButton().then {
        $0.setImage(.xCircle, for: .normal)
        $0.isHidden = true
    }
    
    private let pwEyeButton = UIButton().then {
        $0.setImage(.eyeSlash, for: .normal)
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let loginButton = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 3
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray2E.cgColor
        $0.setAttributedTitle(
            NSAttributedString(
                string: StringLiteral.loginButtonStr,
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray9C
                ]
            ),
            for: .normal
        )
        $0.isEnabled = false
    }
    
    private let findIdButton = UIButton().then {
        $0.configuration = .plain()
        $0.setAttributedTitle(
            NSAttributedString(
                string: StringLiteral.findIdButtonStr,
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray9C
                ]
            ),
            for: .normal
        )
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .gray2E
        $0.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
    }
    
    private let findPwButton = UIButton().then {
        $0.configuration = .plain()
        $0.setAttributedTitle(
            NSAttributedString(
                string: StringLiteral.findPwButtonStr,
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray9C
                ]
            ),
            for: .normal
        )
    }
    
    private lazy var findButtonStackView = UIStackView(arrangedSubviews: [findIdButton, separatorView, findPwButton]).then {
        $0.axis = .horizontal
        $0.spacing = 34
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private let guideLabel = UILabel().then {
        $0.text = StringLiteral.noAccountGuideLabelStr
        $0.font = .pretendard(weight: 600, size: 14)
        $0.textColor = .gray62
    }
    
    private let makeNicknameButton = UIButton().then {
        $0.configuration = .plain()
        $0.setAttributedTitle(
            NSAttributedString(
                string: StringLiteral.makeNicknameButtonStr,
                attributes: [
                    .font : UIFont.pretendard(weight: 400, size: 14),
                    .foregroundColor : UIColor.gray9C,
                    .underlineStyle : NSUnderlineStyle.single.rawValue
                ]
            ),
            for: .normal
        )
    }
    
    private lazy var guideButtonStackView = UIStackView(arrangedSubviews: [guideLabel, makeNicknameButton]).then {
        $0.axis = .horizontal
        $0.spacing = 30
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    /// Bottom Sheet가 present 될 때 추가되는 어두운 배경 뷰
    private let dimmedView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    // MARK: - Set UI
    
    override func addSubview() {
        self.view.addSubviews(
            idLoginLabel,
            idTextField,
            idXButton,
            pwTextField,
            pwXButton,
            pwEyeButton,
            loginButton,
            findButtonStackView,
            guideButtonStackView
        )
    }
    
    override func setLayout() {
        idLoginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(90)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idLoginLabel.snp.bottom).offset(31)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        idXButton.snp.makeConstraints {
            $0.centerY.equalTo(idTextField)
            $0.right.equalTo(idTextField).offset(-20)
            $0.width.height.equalTo(20)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.left.right.equalTo(idTextField)
            $0.height.equalTo(idTextField)
        }
        pwEyeButton.snp.makeConstraints {
            $0.centerY.equalTo(pwTextField)
            $0.right.equalTo(pwTextField).offset(-20)
            $0.width.height.equalTo(20)
        }
        pwXButton.snp.makeConstraints {
            $0.centerY.equalTo(pwEyeButton)
            $0.right.equalTo(pwEyeButton.snp.left).offset(-16)
            $0.width.height.equalTo(20)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(21)
            $0.left.right.equalTo(pwTextField)
            $0.height.equalTo(pwTextField)
        }
        findButtonStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(22)
        }
        guideButtonStackView.snp.makeConstraints {
            $0.top.equalTo(findButtonStackView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(22)
        }
    }
    
    override func bindViewModel() {
        let input = LoginViewModel.Input(
            textFieldBeginEditingEvent:
                Observable.merge(
                    idTextField.rx.controlEvent(.editingDidBegin).map { self.idTextField },
                    pwTextField.rx.controlEvent(.editingDidBegin).map { self.pwTextField }
                ),
            textFieldIsEditingEvent:
                Observable.merge(
                    idTextField.rx.controlEvent(.editingChanged).map { self.idTextField },
                    pwTextField.rx.controlEvent(.editingChanged).map { self.pwTextField }
                ),
            textFieldDidEndEditingEvent:
                Observable.merge(
                    idTextField.rx.controlEvent(.editingDidEnd).map { self.idTextField },
                    pwTextField.rx.controlEvent(.editingDidEnd).map { self.pwTextField }
                ),
            returnKeyDidTapEvent:
                Observable.merge(
                    idTextField.rx.controlEvent(.editingDidEndOnExit).map { self.idTextField },
                    pwTextField.rx.controlEvent(.editingDidEndOnExit).map { self.pwTextField }
                ),
            nicknameDidChangeEvent: nickname.asObservable(),
            loginButtonDidTapEvent: loginButton.rx.tap.asObservable(),
            idXButtonDidTapEvent: idXButton.rx.tap.map { self.idXButton },
            pwXButtonDidTapEvent: pwXButton.rx.tap.map { self.pwXButton },
            makeNicknameButtonDidTapEvent: makeNicknameButton.rx.tap.asObservable(),
            eyeButtonDidTapEvent: pwEyeButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.validLoginNickname.subscribe(onNext: { [self] nickname in
            self.pushToWelcomeVC(id: self.idTextField.text!, nickname: nickname)
        }).disposed(by: disposeBag)
        
        output.noNicknameErr.subscribe(onNext: { [self] _ in
            presentAlert(title: StringLiteral.noNicknameErrTitle, message: StringLiteral.noNicknameErrMsg) {
                self.clearTextFields()
            }
        }).disposed(by: disposeBag)
        
        output.regexErr.subscribe(onNext: { [self] _ in
            presentAlert(title: StringLiteral.regexErrTitle, message: StringLiteral.regexErrMsg) {
                self.clearTextFields()
            }
        }).disposed(by: disposeBag)
        
        output.clearIdTextField.subscribe { [self] _ in
            idTextField.text = ""
            idTextField.sendActions(for: .editingChanged)
        }.disposed(by: disposeBag)
        
        output.clearPwTextField.subscribe { [self] _ in
            pwTextField.text = ""
            pwTextField.sendActions(for: .editingChanged)
        }.disposed(by: disposeBag)
        
        output.isLoginButtonActive.subscribe { [self] isActive in
            loginButton.activateButtonStyle(isActivate: isActive)
        }.disposed(by: disposeBag)
        
        output.presentBottomSheet.subscribe { [self] _ in
            addDimmedView()
            presentBottomSheetVC()
        }.disposed(by: disposeBag)
        
        output.changeSecurity.subscribe { [self] _ in
            pwEyeButton.setImage(pwTextField.isSecureTextEntry ? .eye : .eyeSlash, for: .normal)
            pwTextField.isSecureTextEntry.toggle()
        }.disposed(by: disposeBag)
        
        output.isSideButtonVisible.subscribe(onNext: { [self] isVisible, textField in
            changeSideButtonVisibility(isVisible: isVisible, textField: textField)
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
    
    /// isVisible 값에 따라 텍스트필드 사이드에 있는 X 버튼과 Eye 버튼의 isHidden 값을 변경한다.
    private func changeSideButtonVisibility(isVisible: Bool, textField: UITextField) {
        if textField == idTextField {
            idXButton.isHidden = !isVisible
        } else {
            pwXButton.isHidden = !isVisible
            pwEyeButton.isHidden = !isVisible
        }
    }
    
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
    
    /// id, pw 텍스트필드 비워주는 함수
    private func clearTextFields() {
        self.idTextField.text = ""
        self.pwTextField.text = ""
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
