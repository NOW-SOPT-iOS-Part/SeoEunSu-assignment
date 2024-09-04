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
    
    private let bottomSheetView = BottomSheetView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = bottomSheetView
    }
    
    // MARK: - Set UI
    
    override func setStyle() {
        self.view.backgroundColor = .clear
    }
    
    // MARK: - bindViewModel

    override func bindViewModel() {
        let input = BottomSheetViewModel.Input(
            textFieldBeginEditingEvent: bottomSheetView.nicknameTextField.rx.controlEvent(.editingDidBegin).asObservable(),
            textFieldIsEditingEvent: bottomSheetView.nicknameTextField.rx.controlEvent(.editingChanged).map { self.bottomSheetView.nicknameTextField },
            textFieldDidEndEditingEvent: bottomSheetView.nicknameTextField.rx.controlEvent(.editingDidEnd).asObservable(),
            returnKeyDidTapEvent: bottomSheetView.nicknameTextField.rx.controlEvent(.editingDidEndOnExit).asObservable(),
            saveButtonDidTapEvent: bottomSheetView.saveButton.rx.tap.asObservable(),
            backgroundViewDidTapEvent: bottomSheetView.backgroundView.rx.tapGesture().asObservable()
        )
        
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.isBorderVisible.subscribe(onNext: { isVisible in
            self.bottomSheetView.nicknameTextField.changeBorderVisibility(isVisible: isVisible, color: UIColor.black.cgColor)
        }).disposed(by: disposeBag)
        
        output.isButtonActive.subscribe(onNext: { isActive in
            self.bottomSheetView.saveButton.activateButtonStyle(isActivate: isActive)
        }).disposed(by: disposeBag)
        
        output.dismissKeyboard.subscribe(onNext: {
            self.bottomSheetView.nicknameTextField.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        output.validNickname.subscribe(onNext: { [self] in
            delegate?.removeDimmedView()
            delegate?.passUserData(nickname: bottomSheetView.nicknameTextField.text ?? "")
            dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        output.nicknameRegexErr.subscribe(onNext: {
            self.presentAlert(title: StringLiteral.nicknameRegexErrTitle, message: StringLiteral.nicknameRegexErrMsg) {
                self.bottomSheetView.nicknameTextField.text = ""
            }
        }).disposed(by: disposeBag)
        
        output.backToTheLoginVC.subscribe(onNext: { [self] in
            delegate?.removeDimmedView()
            dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
}
