//
//  UIViewController+.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/19/24.
//

import UIKit

extension UIViewController {
    
    /// 정규식 유형
    enum RegexType {
        case email
        case password
        case nickname
    }
    
    /// 타입에 따라 정규식을 따르는지 확인한다.
    /// - type : 확인하고 싶은 정규식 유형
    /// - input : 정규식이 일치하는지 확인할 문자열
    /// - return : 따르면 true, 따르지 않으면 false
    final func isMatchRegex(type: RegexType, input: String) -> Bool {
        var regexPattern = ""
        switch type {
        case .email:
            regexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case .password:
            regexPattern = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        case .nickname:
            regexPattern = "[ㄱ-ㅎ가-힣]{2,10}"
        }
        let pred = NSPredicate(format:"SELF MATCHES %@", regexPattern)
        return pred.evaluate(with: input)
    }
    
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
