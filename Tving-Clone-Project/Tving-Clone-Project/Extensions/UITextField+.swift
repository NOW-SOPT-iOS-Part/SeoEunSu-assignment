//
//  UITextField+.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

extension UITextField {
    
    /// 텍스트필드의 왼쪽과 오른쪽에 패딩을 추가하는 함수
    /// - width의 크기만큼 양쪽에 패딩을 준다
    final func addSidePadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
    
    /// 텍스트필드의 border의 가시성을 변경하는 함수
    /// - isVisible이 true면 border가 보이고 false면 보이지 않는다
    final func changeBorderVisibility(isVisible: Bool) {
        self.layer.borderWidth = isVisible ? 1 : 0
        self.layer.borderColor = UIColor.black.cgColor
    }
}
