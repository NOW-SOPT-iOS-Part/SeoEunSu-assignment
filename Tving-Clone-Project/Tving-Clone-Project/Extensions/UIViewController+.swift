//
//  UIViewController+.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/19/24.
//

import UIKit

extension UIViewController {
    
    /// 경고 alert를 띄워주는 함수
    /// - title: 경고창의 상단에 띄울 String 값
    /// - message: 경고창 내용으로 띄울 String 값
    /// - action: OK 버튼 클릭 시 실행될 클로저
    final func presentAlert(title: String, message: String, action: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in action() }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
