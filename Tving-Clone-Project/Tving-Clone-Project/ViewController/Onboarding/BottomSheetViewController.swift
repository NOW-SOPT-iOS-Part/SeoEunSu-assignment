//
//  BottomSheetViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/18/24.
//

import UIKit

import RxGesture
import RxCocoa
import RxSwift
import SnapKit
import Then

/// 해당 작업을 (BottomSheetVC가 아닌) LoginVC가 대신 해줄 것이기 때문에 Delegate Pattern을 사용
protocol BottomSheetDelegate: AnyObject {
    /// 배경 클릭 시 LoginVC에 속해있는 어두운 뷰(dimmedView)를 제거해주는 함수
    func removeDimmedView()
    /// 닉네임 데이터를 LoginVC로 전달해주는 함수
    func passUserData(nickname: String)
}

final class BottomSheetViewController: BaseViewController<BottomSheetViewModel> {
    
    // MARK: - Properties
    
    /// 다른 VC에게 일을 시키기 위한 대리자 변수
    weak var delegate: (BottomSheetDelegate)?
    
    // MARK: - Components
    
    private let backgroundView = UIView()
    
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
    
    private let nicknameTextField = UITextField().then {
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
    
    private let saveButton = UIButton().then {
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
        self.view.addSubviews(
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
    
    override func setStyle() {
        self.view.backgroundColor = .clear
    }
    
    // MARK: - bindViewModel

    override func bindViewModel() {
        let input = BottomSheetViewModel.Input(
            textFieldBeginEditingEvent: nicknameTextField.rx.controlEvent(.editingDidBegin).asObservable(),
            textFieldIsEditingEvent: nicknameTextField.rx.controlEvent(.editingChanged).map { self.nicknameTextField },
            textFieldDidEndEditingEvent: nicknameTextField.rx.controlEvent(.editingDidEnd).asObservable(),
            returnKeyDidTapEvent: nicknameTextField.rx.controlEvent(.editingDidEndOnExit).asObservable(),
            saveButtonDidTapEvent: saveButton.rx.tap.asObservable(), 
            backgroundViewDidTapEvent: backgroundView.rx.tapGesture().asObservable()
        )
        
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.isBorderVisible.subscribe(onNext: { isVisible in
            self.nicknameTextField.changeBorderVisibility(isVisible: isVisible, color: UIColor.black.cgColor)
        }).disposed(by: disposeBag)
        
        output.isButtonActive.subscribe(onNext: { isActive in
            self.saveButton.activateButtonStyle(isActivate: isActive)
        }).disposed(by: disposeBag)
        
        output.dismissKeyboard.subscribe(onNext: {
            self.nicknameTextField.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        output.validNickname.subscribe(onNext: { [self] in
            delegate?.removeDimmedView()
            delegate?.passUserData(nickname: nicknameTextField.text ?? "")
            dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        output.nicknameRegexErr.subscribe(onNext: {
            self.presentAlert(title: StringLiteral.nicknameRegexErrTitle, message: StringLiteral.nicknameRegexErrMsg) {
                self.nicknameTextField.text = ""
            }
        }).disposed(by: disposeBag)
        
        output.backToTheLoginVC.subscribe(onNext: { [self] in
            delegate?.removeDimmedView()
            dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
}
