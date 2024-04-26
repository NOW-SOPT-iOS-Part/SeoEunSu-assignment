//
//  UIButton+.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/19/24.
//

import UIKit

extension UIButton {
    
    /// 로그인하기, 저장하기 와 같은 활성화 / 비활성화 버튼의 스타일을 isActivate 값에 따라 변경하는 함수
    /// - isActivate가 true면 버튼을 활성화 스타일로 변경
    /// - isActivate가 false면 버튼을 비활성화 스타일로 변경
    final func activateButtonStyle(isActivate: Bool) {
        self.isEnabled = isActivate ? true : false
        self.backgroundColor = isActivate ? .red : .black
        self.layer.borderWidth = isActivate ? 0 : 1
        self.layer.borderColor = isActivate ? nil : UIColor.gray4.cgColor
        self.setAttributedTitle(
            NSAttributedString(
                string: self.titleLabel?.text ?? "",
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : isActivate ? UIColor.white : UIColor.gray2
                ]
            ),
            for: .normal
        )
    }
}
