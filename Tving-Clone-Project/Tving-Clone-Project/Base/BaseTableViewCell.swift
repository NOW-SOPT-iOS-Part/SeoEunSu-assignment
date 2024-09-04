//
//  BaseTableViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black

        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI

    func setLayout() { }

    func setStyle() { }
}
