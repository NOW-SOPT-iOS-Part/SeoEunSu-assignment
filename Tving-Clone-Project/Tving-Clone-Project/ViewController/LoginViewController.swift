//
//  LoginViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

import SnapKit
import Then

/// 정규식 유형
enum RegexType {
    case email
    case password
}

final class LoginViewController: UIViewController {

    // MARK: - Subviews
    
    final private let idLoginLabel = UILabel().then {
        $0.text = "TVING ID 로그인"
        $0.font = .pretendard(weight: 500, size: 23)
        $0.textColor = .gray1
    }
    
    final private lazy var idTextField = UITextField().then {
        $0.tag = 1
        $0.textColor = .gray2
        $0.font = .pretendard(weight: 600, size: 15)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray4
        $0.attributedPlaceholder = NSAttributedString(
            string: "아이디",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray2]
        )
        $0.addSidePadding(width: 22)
        $0.delegate = self
        $0.addTarget(self, action: #selector(checkTextFieldState), for: .editingChanged)
    }
    
    final private lazy var idXButton = UIButton().then {
        $0.tag = 1
        $0.setImage(.xCircle, for: .normal)
        $0.addTarget(self, action: #selector(xButtonDidTap), for: .touchUpInside)
        $0.isHidden = true
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
        $0.addSidePadding(width: 22)
        $0.isSecureTextEntry = true
        $0.delegate = self
        $0.addTarget(self, action: #selector(checkTextFieldState), for: .editingChanged)
    }
    
    final private lazy var pwXButton = UIButton().then {
        $0.setImage(.xCircle, for: .normal)
        $0.addTarget(self, action: #selector(xButtonDidTap), for: .touchUpInside)
        $0.isHidden = true
    }
    
    final private lazy var pwEyeButton = UIButton().then {
        $0.setImage(.eyeSlash, for: .normal)
        $0.addTarget(self, action: #selector(eyeButtonDidTap), for: .touchUpInside)
        $0.isHidden = true
    }
    
    final private lazy var loginButton = UIButton().then {
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
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
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
    
    final private lazy var makeNicknameButton = UIButton().then {
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
        $0.addTarget(self, action: #selector(makeNicknameButtonDidTap), for: .touchUpInside)
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
            idXButton,
            pwTextField,
            pwXButton,
            pwEyeButton,
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
    
    /// 텍스트필드 사이드에 있는 X 버튼과 Eye 버튼의 visibility를 변경한다.
    final private func changeSideButtonVisibility(textField: UITextField) {
        if textField.tag == 1 {
            idXButton.isHidden = false
        } else {
            pwXButton.isHidden = false
            pwEyeButton.isHidden = false
        }
    }
    
    /// 타입에 따라 정규식을 따르는지 확인한다.
    /// - type : 확인하고 싶은 정규식 유형
    /// - input : 정규식이 일치하는지 확인할 문자열
    /// - return : 따르면 true, 따르지 않으면 false
    final private func isMatchRegex(type: RegexType, input: String) -> Bool {
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
    
    // MARK: - Actions
    
    /// 텍스트 필드 사이드에 있는 X 버튼 클릭 시 호출되는 함수
    /// - 해당 텍스트 필드의 내용을 지워준다.
    /// - 내용 삭제 시 LoginButton이 비활성화 되어야 하기 때문에 changeLoginButtonStyle 함수를 false 값을 넣어 호출함.
    @objc
    final private func xButtonDidTap(_ sender: UIButton) {
        if sender.tag == 1 {
            idTextField.text = ""
        } else {
            pwTextField.text = ""
        }
        loginButton.activateButtonStyle(isActivate: false)
    }
    
    /// 비밀번호 텍스트 필드 사이드에 있는 Eye / Eye-Slash 버튼 클릭 시 호출되는 함수
    /// - 1. 이미지를 변경한다. ( Eye -> Eye-Slash / Eye-Slash -> Eye )
    /// - 2. 비밀번호 텍스트 필드의 security 여부를 변경한다.
    @objc
    final private func eyeButtonDidTap(_ sender: UIButton) {
        pwEyeButton.setImage(pwTextField.isSecureTextEntry ? .eye : .eyeSlash, for: .normal)
        pwTextField.isSecureTextEntry = !pwTextField.isSecureTextEntry
    }
    
    /// 로그인하기 버튼 클릭 시 호출되는 함수
    /// - 1. 아이디 데이터 전달 및 화면 이동
    /// - 2. 아이디 및 비밀번호 정규식 확인 및 에러 처리
    @objc
    final private func loginButtonDidTap(_ sender: UIButton) {
        if isMatchRegex(type: .email, input: idTextField.text ?? "") && isMatchRegex(type: .password, input: pwTextField.text ?? "") {
            let welcomeVC = WelcomeViewController()
            guard let idData = idTextField.text else { return }
            welcomeVC.idData = idData
            welcomeVC.modalPresentationStyle = .fullScreen
            welcomeVC.modalTransitionStyle = .coverVertical
            self.present(welcomeVC, animated: true)
        } else {
            let alert = UIAlertController(title: "정규식 에러", message: "이메일 또는 비밀번호의 형식이 올바르지 않습니다", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                self.idTextField.text = ""
                self.pwTextField.text = ""
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    /// idTextField와 pwTextField의 상태를 확인하는 함수
    /// - idTextField와 pwTextField의 값이 변할 때마다 호출된다
    /// - 해당 텍스트 필드가 isEmpty인지 아닌지에 따라 LoginButton의 스타일이 달라지게 된다
    @objc
    final private func checkTextFieldState() {
        guard let idText = idTextField.text else { return }
        guard let pwText = pwTextField.text else { return }
        
        loginButton.activateButtonStyle(isActivate: !(idText.isEmpty) && !(pwText.isEmpty))
    }
    
    /// 닉네임 만들러가기 버튼 클릭 시 호출되는 함수
    @objc
    final private func makeNicknameButtonDidTap() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    /// 텍스트 필드 내용 수정을 시작할 때 호출되는 함수
    /// - 1. border를 활성화해준다.
    /// - 2. 텍스트가 채워져 있으면 바로 사이드 버튼들의 visibility를 변경한다.
    final func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !(textField.text ?? "").isEmpty {
            changeSideButtonVisibility(textField: textField)
        }
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray2.cgColor
        return true
    }
    
    /// 텍스트 필드 내용 수정 중일 때 호출되는 함수
    /// - 사이드 버튼들의 visibility를 변경한다.
    final func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        changeSideButtonVisibility(textField: textField)
        return true
    }
    
    /// 텍스트 필드 내용 수정이 끝났을 때 호출되는 함수
    /// - border를 제거해준다.
    final func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            idXButton.isHidden = true
        } else {
            pwXButton.isHidden = true
            pwEyeButton.isHidden = true
        }
        textField.layer.borderWidth = 0
        textField.layer.borderColor = nil
    }
}
