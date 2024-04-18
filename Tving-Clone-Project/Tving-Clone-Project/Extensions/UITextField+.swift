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
}
