//
//  FindInfoButton.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

class FindInfoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect())
        
        self.do {
            $0.configuration = .plain()
            $0.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [
                        .font : UIFont.pretendard(weight: 600, size: 14),
                        .foregroundColor : UIColor.gray9C
                    ]
                ),
                for: .normal
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
