//
//  LoginTextField.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

class LoginTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(placeHolder: String) {
        self.init(frame: CGRect())
        
        self.do {
            $0.textColor = .gray9C
            $0.font = .pretendard(weight: 600, size: 15)
            $0.layer.cornerRadius = 3
            $0.backgroundColor = .gray2E
            $0.attributedPlaceholder = NSAttributedString(
                string: placeHolder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray9C]
            )
            $0.addSidePadding(width: 22)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
