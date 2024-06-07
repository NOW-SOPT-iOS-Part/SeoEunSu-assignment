//
//  BottomSheetView.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

import SnapKit
import Then

class BottomSheetView: BaseView {
    
    // MARK: - Components
    
    let backgroundView = UIView()
    
    private let grabBarView = UIView().then {
        $0.backgroundColor = .white2
        $0.layer.cornerRadius = 4
    }
    
    private let bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private let enterNicknameLabel = UILabel().then {
        $0.text = StringLiteral.enterNicknameLabelStr
        $0.font = .pretendard(weight: 500, size: 23)
        $0.textColor = .black
    }
    
    let nicknameTextField = UITextField().then {
        $0.backgroundColor = .gray9C
        $0.font = .pretendard(weight: 600, size: 14)
        $0.textColor = .gray2E
        $0.attributedPlaceholder = NSAttributedString(
            string: StringLiteral.nicknameTextFieldPlaceHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayD6]
        )
        $0.layer.cornerRadius = 3
        $0.addSidePadding(width: 25)
    }
    
    let saveButton = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray2E.cgColor
        $0.setAttributedTitle(
            NSAttributedString(
                string: "저장하기",
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.gray9C
                ]
            ),
            for: .normal
        )
        $0.isEnabled = false
    }
    
    // MARK: - Set UI
    
    override func addSubview() {
        self.addSubviews(
            backgroundView,
            grabBarView,
            bottomSheetView,
            enterNicknameLabel,
            nicknameTextField,
            saveButton
        )
    }
    
    override func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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
}
