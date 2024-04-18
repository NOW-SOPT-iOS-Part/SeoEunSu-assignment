//
//  BottomSheetViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/18/24.
//

import UIKit

import SnapKit
import Then

/// Bottom Sheet 뒤의 어두운 뷰 클릭 시 그 어두운 뷰를 제거해주는 프로토콜 선언
/// 이 작업을 BottomSheetVC가 아닌 LoginVC가 해줄 것이기 때문에 Delegate Pattern을 사용함
protocol RemoveDimmedViewDelegate: AnyObject {
    /// LoginVC에 있는 dimmedView를 제거해주는 함수
    func removeDimmedView()
}

class BottomSheetViewController: UIViewController {
    
    // MARK: - Variables
    
    /// 일(어두운 뷰 제거)을 시키기 위한 대리자 변수
    weak var delegate: (RemoveDimmedViewDelegate)?
    
    // MARK: - Subviews
    
    final private let grabBarView = UIView().then {
        $0.backgroundColor = .white2
        $0.layer.cornerRadius = 4
    }
    
    final private let bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    final private let enterNicknameLabel = UILabel().then {
        $0.text = "닉네임을 입력해주세요"
        $0.font = .pretendard(weight: 500, size: 23)
        $0.textColor = .black
    }
    
    final private lazy var nicknameTextField = UITextField().then {
        $0.backgroundColor = .gray2
        $0.font = .pretendard(weight: 600, size: 14)
        $0.textColor = .gray4
        $0.layer.cornerRadius = 3
        $0.addSidePadding(width: 25)
        $0.delegate = self
        $0.addTarget(self, action: #selector(checkTextFieldState), for: .editingChanged)
    }
    
    final private lazy var saveButton = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 3
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray4.cgColor
        $0.setAttributedTitle(
            NSAttributedString(
                string: "저장하기",
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray2
                ]
            ),
            for: .normal
        )
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubview()
        setLayout()
    }
    
    // MARK: - Helpers
    
    // 유저의 터치를 감지하는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // 배경의 self.view 클릭 시 saveButtonDidTap 함수가 호출되도록 코드 작성
        if let touch = touches.first, touch.view == self.view {
            self.saveButtonDidTap()
        }
    }
    
    final private func addSubview() {
        [
            grabBarView,
            bottomSheetView,
            enterNicknameLabel,
            nicknameTextField,
            saveButton
        ].forEach { view.addSubview($0) }
    }
    
    final private func setLayout() {
        bottomSheetView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 2 + 20)
        }
        grabBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(bottomSheetView.snp.top).offset(-15)
            $0.width.equalTo(56)
            $0.height.equalTo(7)
        }
        enterNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(bottomSheetView).offset(50)
            $0.left.equalTo(bottomSheetView).offset(20)
        }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(enterNicknameLabel.snp.bottom).offset(21)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        saveButton.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Actions
    
    /// nicknameTextField의 상태를 확인하는 함수
    /// - nicknameTextField의 텍스트 값이 변할 때마다 호출된다
    /// - 해당 텍스트 필드가 isEmpty인지 아닌지에 따라 저장하기 버튼의 스타일이 달라지게 된다
    @objc
    final private func checkTextFieldState() {
        guard let nicknameText = nicknameTextField.text else { return }
        saveButton.activateButtonStyle(isActivate: !(nicknameText.isEmpty))
    }
    
    /// 저장하기 버튼 클릭 시 호출되는 함수
    /// - 1. 배경의 어두운 뷰를 제거한다 => delegate를 통해 LoginVC에게 일을 시킴
    /// - 2. BottomSheet를 dismiss
    @objc
    final private func saveButtonDidTap() {
        delegate?.removeDimmedView()
        self.dismiss(animated: true)
    }
}

extension BottomSheetViewController: UITextFieldDelegate {
//    text
}
