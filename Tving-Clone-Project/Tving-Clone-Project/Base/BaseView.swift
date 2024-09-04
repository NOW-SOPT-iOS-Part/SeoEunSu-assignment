//
//  BaseView.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI
    
    func addSubview() { }
    func setLayout() { }
    func setStyle() { }
}
