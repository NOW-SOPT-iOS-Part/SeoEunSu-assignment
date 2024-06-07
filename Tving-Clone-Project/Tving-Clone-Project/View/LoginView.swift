//
//  LoginView.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

class LoginView: BaseView {
    
    // MARK: - Components
    
    private let idLoginLabel = UILabel().then {
        $0.text = StringLiteral.idLoginLabelStr
        $0.font = .pretendard(weight: 500, size: 23)
        $0.textColor = .grayD6
    }
    
    let idTextField = LoginTextField(placeHolder: StringLiteral.idTextFieldPlaceHolder)
    
    let idXButton = UIButton().then {
        $0.setImage(.xCircle, for: .normal)
        $0.isHidden = true
    }
    
    let pwTextField = LoginTextField(placeHolder: StringLiteral.pwTextFieldPlaceHolder).then {
        $0.isSecureTextEntry = true
    }
    
    let pwXButton = UIButton().then {
        $0.setImage(.xCircle, for: .normal)
        $0.isHidden = true
    }
    
    let pwEyeButton = UIButton().then {
        $0.setImage(.eyeSlash, for: .normal)
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    let loginButton = UIButton().then {
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
    
    private let findIdButton = FindInfoButton(title: StringLiteral.findIdButtonStr)
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .gray2E
        $0.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
    }
    
    private let findPwButton = FindInfoButton(title: StringLiteral.findPwButtonStr)
    
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
    
    let makeNicknameButton = UIButton().then {
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
    
    // MARK: - Set UI
    
    override func addSubview() {
        self.addSubviews(
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
}

extension LoginView {
    
    // MARK: - Helpers
    
    /// isVisible 값에 따라 텍스트필드 사이드에 있는 X 버튼과 Eye 버튼의 isHidden 값을 변경한다.
    func changeSideButtonVisibility(isVisible: Bool, textField: UITextField) {
        if textField == idTextField {
            idXButton.isHidden = !isVisible
        } else {
            pwXButton.isHidden = !isVisible
            pwEyeButton.isHidden = !isVisible
        }
    }
    
    /// id, pw 텍스트필드 비워주는 함수
    func clearTextFields() {
        self.idTextField.text = ""
        self.pwTextField.text = ""
    }
}
