//
//  LoginViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: UIViewController {

    // MARK: - Subviews
    
    final private let idLoginLabel = UILabel().then {
        $0.text = "TVING ID 로그인"
        $0.font = .pretendard(weight: 500, size: 23)
        $0.textColor = .gray1
    }
    
    final private lazy var idTextField = UITextField().then {
        $0.textColor = .gray2
        $0.font = .pretendard(weight: 600, size: 15)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray4
        $0.attributedPlaceholder = NSAttributedString(
            string: "아이디",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray2]
        )
        $0.addLeftPadding(width: 22)
        $0.delegate = self
    }
    
    final private lazy var pwTextField = UITextField().then {
        $0.textColor = .gray2
        $0.font = .pretendard(weight: 600, size: 15)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray4
        $0.attributedPlaceholder = NSAttributedString(
            string: "비밀번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray2]
        )
        $0.addLeftPadding(width: 22)
        $0.delegate = self
    }
    
    final private let loginButton = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 3
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray4.cgColor
        $0.setAttributedTitle(
            NSAttributedString(
                string: "로그인하기",
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray2
                ]
            ),
            for: .normal
        )
    }
    
    final private let findIdButton = UIButton().then {
        $0.configuration = .plain()
        $0.setAttributedTitle(
            NSAttributedString(
                string: "아이디 찾기",
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray2
                ]
            ),
            for: .normal
        )
    }
    
    final private let separatorView = UIView().then {
        $0.backgroundColor = .gray4
        $0.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
    }
    
    final private let findPwButton = UIButton().then {
        $0.configuration = .plain()
        $0.setAttributedTitle(
            NSAttributedString(
                string: "비밀번호 찾기",
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray2
                ]
            ),
            for: .normal
        )
    }
    
    final private lazy var findButtonStackView = UIStackView(arrangedSubviews: [findIdButton, separatorView, findPwButton]).then {
        $0.axis = .horizontal
        $0.spacing = 34
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    final private let guideLabel = UILabel().then {
        $0.text = "아직 계정이 없으신가요?"
        $0.font = .pretendard(weight: 600, size: 14)
        $0.textColor = .gray3
    }
    
    final private let makeNicknameButton = UIButton().then {
        $0.configuration = .plain()
        $0.setAttributedTitle(
            NSAttributedString(
                string: "닉네임 만들러가기",
                attributes: [
                    .font : UIFont.pretendard(weight: 400, size: 14),
                    .foregroundColor : UIColor.gray2,
                    .underlineStyle : NSUnderlineStyle.single.rawValue
                ]
            ),
            for: .normal
        )
    }
    
    final private lazy var guideButtonStackView = UIStackView(arrangedSubviews: [guideLabel, makeNicknameButton]).then {
        $0.axis = .horizontal
        $0.spacing = 30
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        addSubview()
        setLayout()
    }
    
    // MARK: - Helpers
    
    final private func addSubview() {
        [
            idLoginLabel,
            idTextField,
            pwTextField,
            loginButton,
            findButtonStackView,
            guideButtonStackView
        ].forEach { self.view.addSubview($0) }
    }
    
    final private func setLayout() {
        idLoginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(90)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idLoginLabel.snp.bottom).offset(31)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.left.right.equalTo(idTextField)
            $0.height.equalTo(idTextField)
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
    
    // MARK: - Actions
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    /// 텍스트 필드 내용 수정을 시작할 때 호출되는 함수로,
    /// border를 활성화해준다.
    final func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray2.cgColor
        return true
    }
    
    /// 텍스트 필드 내용 수정이 끝났을 때 호출되는 함수로,
    /// border를 제거해준다.
    final func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.layer.borderColor = nil
    }
}
