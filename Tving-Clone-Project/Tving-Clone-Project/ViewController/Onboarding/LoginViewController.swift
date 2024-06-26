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

    // MARK: - Properties
    
    final private var nickname: String?
    
    // MARK: - Components
    
    final private let idLoginLabel = UILabel().then {
        $0.text = "TVING ID 로그인"
        $0.font = .pretendard(weight: 500, size: 23)
        $0.textColor = .grayD6
    }
    
    final private lazy var idTextField = UITextField().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 600, size: 15)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray2E
        $0.attributedPlaceholder = NSAttributedString(
            string: "아이디",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray9C]
        )
        $0.addSidePadding(width: 22)
        $0.delegate = self
        $0.addTarget(self, action: #selector(checkTextFieldState), for: .editingChanged)
    }
    
    final private lazy var idXButton = UIButton().then {
        $0.setImage(.xCircle, for: .normal)
        $0.addTarget(self, action: #selector(xButtonDidTap), for: .touchUpInside)
        $0.isHidden = true
    }
    
    final private lazy var pwTextField = UITextField().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 600, size: 15)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray2E
        $0.attributedPlaceholder = NSAttributedString(
            string: "비밀번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray9C]
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
        $0.layer.borderColor = UIColor.gray2E.cgColor
        $0.setAttributedTitle(
            NSAttributedString(
                string: "로그인하기",
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray9C
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
                    .foregroundColor : UIColor.gray9C
                ]
            ),
            for: .normal
        )
    }
    
    final private let separatorView = UIView().then {
        $0.backgroundColor = .gray2E
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
                    .foregroundColor : UIColor.gray9C
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
        $0.textColor = .gray62
    }
    
    final private lazy var makeNicknameButton = UIButton().then {
        $0.configuration = .plain()
        $0.setAttributedTitle(
            NSAttributedString(
                string: "닉네임 만들러가기",
                attributes: [
                    .font : UIFont.pretendard(weight: 400, size: 14),
                    .foregroundColor : UIColor.gray9C,
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
    
    /// Bottom Sheet가 present 될 때 추가되는 어두운 배경 뷰
    final private let dimmedView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
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
        if textField == idTextField {
            idXButton.isHidden = false
        } else {
            pwXButton.isHidden = false
            pwEyeButton.isHidden = false
        }
    }
    
    /// 배경에 dimmedView를 추가하는 함수
    /// - 1. animate를 통해 서서히 추가되는 것 같은 효과 제공
    /// - 2. animation 끝나면 서브뷰로 추가 및 레이아웃 설정
    final private func addDimmedView() {
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 1.0
        } completion: { [self] _ in
            view.addSubview(dimmedView)
            dimmedView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    // MARK: - Actions
    
    /// 텍스트 필드 사이드에 있는 X 버튼 클릭 시 호출되는 함수
    /// - 해당 텍스트 필드의 내용을 지워준다.
    /// - 내용 삭제 시 LoginButton이 비활성화 되어야 하기 때문에 changeLoginButtonStyle 함수를 false 값을 넣어 호출함.
    @objc
    final private func xButtonDidTap(_ sender: UIButton) {
        if sender == idXButton {
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
        pwTextField.isSecureTextEntry.toggle()
    }
    
    /// 로그인하기 버튼 클릭 시 호출되는 함수
    /// - 1. 아이디 및 비밀번호 정규식 확인 및 에러 처리
    /// - 2. 닉네임 설정 여부 확인 및 에러 처리
    /// - 3. 아이디, 닉네임 데이터 전달 및 화면 이동
    @objc
    final private func loginButtonDidTap(_ sender: UIButton) {
        if isMatchRegex(type: .email, input: idTextField.text ?? "") && isMatchRegex(type: .password, input: pwTextField.text ?? "") {
            guard let id = idTextField.text else { return }
            if let nickname = nickname {
                let welcomeVC = WelcomeViewController()
                welcomeVC.id = id
                welcomeVC.nickname = nickname
                welcomeVC.modalPresentationStyle = .fullScreen
                welcomeVC.modalTransitionStyle = .coverVertical
                self.present(welcomeVC, animated: true)
            } else {
                presentAlert(title: "닉네임 미설정 에러", message: "닉네임을 먼저 설정해주세요!") {
                    self.idTextField.text = ""
                    self.pwTextField.text = ""
                }
            }
        } else {
            presentAlert(title: "정규식 에러", message: "이메일 또는 비밀번호의 형식을 다시 확인해주세요!") {
                self.idTextField.text = ""
                self.pwTextField.text = ""
            }
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
    /// - 1. 배경에 dimmedView 추가
    /// - 2. Bottom Sheet VC를 present
    @objc
    final private func makeNicknameButtonDidTap() {
        addDimmedView()
        
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.delegate = self
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
        textField.layer.borderColor = UIColor.gray9C.cgColor
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
        if textField == idTextField {
            idXButton.isHidden = true
        } else {
            pwXButton.isHidden = true
            pwEyeButton.isHidden = true
        }
        textField.layer.borderWidth = 0
        textField.layer.borderColor = nil
    }
    
    /// 키보드의 return 키 클릭 시 호출되는 함수
    /// - 키보드를 내려준다
    final func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        self.nickname = nickname
    }
}
